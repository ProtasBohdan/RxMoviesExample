//
//  MoviesAPI.swift
//  RxMovies
//
//  Created by protas on 18.11.2020.
//

import Foundation
import RxSwift

class MoviesAPIService {

    // MARK: Properties
    
    /// shared instance for current object
    static let shared = MoviesAPIService()
    
    /// base url path for image, thah used in themoviedb service
    static let imageBase = URL(string: "https://image.tmdb.org/t/p/original/")!
    
    private let base = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "06c477fb6235927e8e8ea7e96b18133c"
    
    // MARK: Public
    
    /// Function that fetch top rated movies from server
    /// - Returns: Observable object
    func topRated() -> Observable<[TopRatedMovieDTO]> {
        var request = URLComponents(
            url: base.appendingPathComponent("movie/top_rated"),
            resolvingAgainstBaseURL: true)?
        .addingApiKey(apiKey)
        .request
        
        request?.httpMethod = "GET"
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx
            .decodable(request: request!, type: PageDTO<TopRatedMovieDTO>.self)
            .map(\.results)
    }
    
    
}

// MARK: - Privates

private extension URLComponents {
    
    func addingApiKey(_ apiKey: String) -> URLComponents {
        var copy = self
        copy.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return copy
    }
    
    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
    
    
}
