//
//  TopMoviesListViewModel.swift
//  RxMovies
//
//  Created by protas on 18.11.2020.
//

import Foundation
import RxSwift

class TopMoviesListViewModel {
    
    /// Errors that describe state of view model
    public enum MoviesListViewModelError: Error {
        case unknown
        case textDescribed(descr: String)
    }
    
    // MARK: Properties
    
    private let bag = DisposeBag()
    
    // MARK: Output
    
    private(set) var topRatedMovies: PublishSubject<[TopRatedMovieModel]> = PublishSubject()
    private(set) var error: PublishSubject<MoviesListViewModelError> = PublishSubject()
    
    // MARK: Public
    
    func fetchDataSource() {
        MoviesAPIService.shared.topRated().subscribe {
            switch $0 {
            case .next(let movies):
                let mappedModels = movies.map {
                    TopRatedMovieModel(
                        id: $0.id,
                        title: $0.title,
                        overview: $0.overview,
                        posterURL: MoviesAPIService.imageBase.appendingPathComponent($0.poster_path ?? "")
                    )
                }
                DispatchQueue.main.async {
                    self.topRatedMovies.onNext(mappedModels)
                }
            case .error(let error):
                self.error.onNext(.textDescribed(descr: error.localizedDescription))
            case .completed:
                print("done")
            }
        }.disposed(by: bag)
    }
    
}
