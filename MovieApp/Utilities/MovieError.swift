//
//  Error.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import Foundation



enum MovieError: String, Error {
    case invalidMovie = "Invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The Data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this movie. Please try again"
    case alreadyFavorites = "You've already favorited this movie."
}
