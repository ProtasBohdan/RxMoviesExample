//
//  MoviesAPI.swift
//  RxMovies
//
//  Created by protas on 18.11.2020.
//

import Foundation
import RxSwift

class MoviesAPIService {

    static let shared = MoviesAPIService()
    
    private let base = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "06c477fb6235927e8e8ea7e96b18133c"
    
    
}
