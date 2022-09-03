//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import Foundation


struct MovieDetail: Codable, Hashable {
    var id: Int
    var imdbId: String?
    var title: String?
    var overview: String?
    var backdropPath: String?
    var releaseDate: String?
    var voteAverage: Double?
}
