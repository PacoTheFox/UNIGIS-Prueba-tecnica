//
//  Movie.swift
//  App
//
//  Created by Francisco Aguirre San Román on 14/02/24.
//


import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let poster_path: String
    let title: String
    let release_date: String
    let original_language: String
    let vote_average: Float
    let overview: String
    let genre_ids: [Int]
    

}


struct TMDBResponse: Codable {
    let results: [Movie]

}

