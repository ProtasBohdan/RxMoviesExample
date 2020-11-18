//
//  TopRatedMovieDTO.swift
//  RxMovies
//
//  Created by protas on 18.11.2020.
//

import Foundation

struct TopRatedMovieDTO: Codable {
    let id: Int
    let title: String
    let poster_path: String?
    let overview: String?
}
