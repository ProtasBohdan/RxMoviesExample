//
//  TopMoviesListViewController.swift
//  RxMovies
//
//  Created by protas on 18.11.2020.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class TopMoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private let viewModel = TopMoviesListViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
        viewModel.fetchDataSource()
    }

    // MARK: - Privates
    
    private func setupUI() {
        tableView.estimatedRowHeight = 230
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindUI() {

        // binding data source
        viewModel.topRatedMovies.bind(to: tableView.rx.items(cellIdentifier: "TopMovieTableViewCell", cellType: TopMovieTableViewCell.self)) { row, model, cell in
            cell.titleLabel.text = model.title
            cell.bodyLabel.text = model.overview
            cell.posterImageView?.kf.setImage(with: model.posterURL)
        }.disposed(by: bag)
        
        // observing errors to show
        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .unknown:
                    print("An uknown error occured")
                case .textDescribed(let descr):
                    print("An error occured: \(descr)")
                }
            })
            .disposed(by: bag)
    }
    
    
}
