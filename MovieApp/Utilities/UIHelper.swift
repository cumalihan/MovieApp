//
//  UIHelper.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import UIKit

enum UIHelper {
      static func createThreeColumnFloweLayout(in view: UIView) -> UICollectionViewFlowLayout {
          let width = view.bounds.width
          let padding: CGFloat = 12
          let minimumItemSpacing: CGFloat = 10
          let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
          let itemWidth = availableWidth
          
          let flowLayout = UICollectionViewFlowLayout()
          flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
          flowLayout.itemSize = CGSize(width: itemWidth, height: 136)
          
          return flowLayout
      }
}
