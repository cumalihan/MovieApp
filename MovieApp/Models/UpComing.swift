//
//  UpComing.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 1.09.2022.
//

import Foundation



struct Movie: Codable, Hashable {
    var results: [UpComingMovie]
}

struct UpComingMovie: Codable, Hashable {
    var id: Int
    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    var title: String?
}
