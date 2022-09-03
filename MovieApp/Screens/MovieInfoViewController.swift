//
//  MovieInfoViewController.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import Foundation
import UIKit


class MovieInfoViewController: UIViewController, UIScrollViewDelegate {
    var name: String!
    var id: Int!
    
    
    let scrollView = CustomScrollView()
    let contentView = ContainerView()
    let movieTitleLabel = TitleLabel(textAlignment: .left, fontSize: 24)
    let imageView = MovieImageView(frame: .zero)
    let imdbView = ImageView(frame: .zero)
    let rateIcon = ImageView(frame: .zero)
    
    
    let descriptionLabel = SecondaryLabel(fontSize: 18)
    let rateLabel = DescriptionLabel(fontSize: 22)
    let releasedLabel = DescriptionLabel(fontSize: 16)
    
    weak var delegate: MovieInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getMovieInfo()
        getUI()
    }
    
    
    func configureViewController(){
        let addFavorite = UIBarButtonItem(image: SFSymbols.like ,style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addFavorite
        title = "\(name ?? "")"
        view.backgroundColor = .systemBackground
        
    }
    
    func getMovieInfo() {
        NetworkManager.shared.getMovieInfo(for: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.configureUIElements(with: movie)
                }
              
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureUIElements(with movie: MovieDetail) {
        
        self.movieTitleLabel.text = movie.title
        self.descriptionLabel.text = movie.overview
        self.imdbView.image = Images.imdb
        self.rateIcon.image = Images.rate
        self.rateLabel.text = "\(String(format: "%.1f" ,movie.voteAverage ?? 0)) / 10"
        self.releasedLabel.text = movie.releaseDate?.convertToDisplayFormat()
        self.descriptionLabel.text = movie.overview
        
        NetworkManager.shared.downloadImage(from: movie.backdropPath ?? "placeholder") { [weak self] image in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func getUI() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(imdbView)
        contentView.addSubview(rateIcon)
        contentView.addSubview(rateLabel)
        contentView.addSubview(releasedLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(movieTitleLabel)


 
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            imdbView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            imdbView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imdbView.widthAnchor.constraint(equalToConstant: 49),
            imdbView.heightAnchor.constraint(equalToConstant: 24),
            
            rateIcon.centerYAnchor.constraint(equalTo: imdbView.centerYAnchor),
            rateIcon.leadingAnchor.constraint(equalTo: imdbView.trailingAnchor,constant: 8),
            rateIcon.widthAnchor.constraint(equalToConstant: 16),
            rateIcon.heightAnchor.constraint(equalToConstant: 16),
            
            rateLabel.centerYAnchor.constraint(equalTo: imdbView.centerYAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: rateIcon.trailingAnchor, constant: 8),
            rateLabel.heightAnchor.constraint(equalToConstant: 16),
            
            releasedLabel.centerYAnchor.constraint(equalTo: imdbView.centerYAnchor),
            releasedLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor, constant: 20),
            releasedLabel.heightAnchor.constraint(equalToConstant: 18),
            
            
            movieTitleLabel.topAnchor.constraint(equalTo: imdbView.bottomAnchor, constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            descriptionLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
        ])
        
    }
    
    @objc func addButtonTapped() {
        
        NetworkManager.shared.getMovieInfo(for: id) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movie):
                let favorite = UpComingMovie(id: movie.id, backdropPath: movie.backdropPath, overview: movie.overview, releaseDate: movie.releaseDate, title: movie.title)

                PersistenceMangaer.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }

                    guard let error = error else {
                        self.presentAlertOnMainThread(title: "Succes!", message: "You have succesfully favorited this movie.", buttonTitle:"Ok")
                        return
                    }

                    self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
}
