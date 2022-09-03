//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import UIKit


protocol MovieInfoVCDelegate: class {
    func didRequestMovie(for id: Int)
}

class MovieListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var movies: [UpComingMovie] = []
    var page: Int = 1
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, UpComingMovie>!
    

    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Movie App"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getMovies(page: page)
        configureDataSource()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFloweLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
    }
    
    func getMovies(page: Int) {
         
        showLoadingView()
        
        NetworkManager.shared.getMovie(page: page) { [weak self] result in
 
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let movie):
                self.movies.append(contentsOf: movie.results ?? [])
                
                if self.movies.isEmpty {
                    let message = "We couldn't find any movies."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }


                }
                self.updateData(on: self.movies)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateData(on movies: [UpComingMovie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UpComingMovie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, UpComingMovie>(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath)
             as! MovieCell
            cell.set(movie: movie)
            return cell
            
        })
    }
    
    
}


extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        
        let destVC = MovieInfoViewController()
        destVC.name = movie.title
        destVC.id = movie.id
        
        let navController = UINavigationController(rootViewController: destVC)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        if offsetY > contentHeight - height {
            page += 1
            getMovies(page: page)
        }
    }
    
    
}

