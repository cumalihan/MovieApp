//
//  MovieCell.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import UIKit


class MovieCell: UICollectionViewCell {
    static let reuseID = "MovieCell"
    
    
    let movieImageView = MovieImageView(frame: .zero)
    let movieTitleLabel = TitleLabel(textAlignment: .left, fontSize: 15)
    let movieDescriptionLabel = DescriptionLabel(fontSize: 13)
    let movieDateLabel = DescriptionLabel(fontSize: 12)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: UpComingMovie) {
        movieTitleLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
        movieDateLabel.text = "\(movie.releaseDate?.convertToDisplayFormat() ?? "")"
        
        
        
        NetworkManager.shared.downloadImage(from: movie.backdropPath ?? "placeholder") { [weak self] image in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    
    
    private func configure() {
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(movieDescriptionLabel)
        addSubview(movieDateLabel)
        
        movieDescriptionLabel.numberOfLines = 4
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieImageView.heightAnchor.constraint(equalToConstant: 104),
            movieImageView.widthAnchor.constraint(equalToConstant: 104),
            
            movieTitleLabel.topAnchor.constraint(equalTo: self.movieImageView.topAnchor, constant: 12),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            movieDescriptionLabel.topAnchor.constraint(equalTo: self.movieTitleLabel.topAnchor, constant: 24),
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            movieDescriptionLabel.heightAnchor.constraint(equalToConstant: 36),
            
            
            movieDateLabel.topAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: -12),
            movieDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            movieDateLabel.heightAnchor.constraint(equalToConstant: 20)
            
            
        ])
    }
    
}
