//
//  CellCaruselCollectionView.swift
//  Flowers
//
//  Created by Алексей on 26.12.2020.
//

import UIKit

class CaruselCollectionViewCell: UICollectionViewCell {
  
    static let reuseId = "CaruselCollectionViewCell"
    
    let pictureImageView:UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
       img.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
       return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pictureImageView)
              
        pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pictureImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        pictureImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
