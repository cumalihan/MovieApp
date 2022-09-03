//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 1.09.2022.
//

import UIKit


//https://api.themoviedb.org/3/movie/upcoming?api_key=3b339ab3647ecd821b7f43ec972edfb3


class NetworkManager {
    
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "3b339ab3647ecd821b7f43ec972edfb3"
    
    private let imageBaseURL = "https://image.tmdb.org/t/p/original"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getMovie(page: Int, completed: @escaping(Result<Movie, MovieError>) -> Void) {
        let endpoint = baseURL + "/movie/upcoming?api_key=\(apiKey)&language=en-US&page=\(page)"
        
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(Movie.self, from: data)
                completed(.success(movie))
            } catch {
                completed(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
    
    func getMovieInfo(for id: Int, completed: @escaping(Result<MovieDetail, MovieError>) -> Void) {
        
        let endpoint = baseURL + "/movie/\(id)" + "?api_key=3b339ab3647ecd821b7f43ec972edfb3"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidResponse))
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(MovieDetail.self, from: data)
                completed(.success(movie))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
        
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        
        let urlImage =  imageBaseURL + urlString
        let cacheKey = NSString(string: imageBaseURL + urlString)
        
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlImage) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completed(nil)
                      return
                  }
                    
                    
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
    }
}
