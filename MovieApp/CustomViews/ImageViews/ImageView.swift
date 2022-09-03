//
//  ImageView.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import UIKit

class ImageView: UIImageView {
    
    let placeholderImage = Images.placeholder!

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentMode = .scaleAspectFill
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
