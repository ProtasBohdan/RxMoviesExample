//
//  MoviesPageDTO.swift
//  RxMovies
//
//  Created by protas on 18.11.2020.
//

import Foundation

struct PageDTO<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}
