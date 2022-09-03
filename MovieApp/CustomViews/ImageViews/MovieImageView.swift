//
//  MovieImageView.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import UIKit

class MovieImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "placeholder")!

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFill
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
