//
//  MessageLabel.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 3.09.2022.
//

import UIKit

class MessageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        numberOfLines = 0;
        textAlignment = .center;
        sizeToFit()
    }

}
