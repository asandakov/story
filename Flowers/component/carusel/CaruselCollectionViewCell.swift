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
       img.contentMode = .scaleAspectFit
       return img
    }()
    
    let nameLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 14.0)
        name.numberOfLines = 2
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let priceLabel:UILabel = {
       let price = UILabel()
        price.font = Fonts.Text.textSemiboldFont(size: 14.0)
        price.textColor = Colors.Product.price
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    let buyBotton:UIButton = {
        let buy = UIButton()
        buy.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        buy.setTitleColor(Colors.Product.textBuy, for: .normal)
        buy.setTitle(Localization.Product.textBuyButton, for: .normal)
        buy.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 14.0)
        buy.backgroundColor = Colors.Product.backgroundBuy
        buy.layer.cornerRadius = 5
        buy.translatesAutoresizingMaskIntoConstraints = false
        return buy
    }()
    
    var buyBottonAction : (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(pictureImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(buyBotton)
              
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        buyBotton.addTarget(self, action: #selector(clickBuyBotton(_:)), for: .touchUpInside)
        
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickBuyBotton(_ sender:UIButton){
          buyBottonAction?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 5, height: 8)
      
        self.clipsToBounds = false
    }
    
    
    func setConstraint() {
        pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pictureImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        pictureImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pictureImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 10).isActive = true

        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: buyBotton.centerYAnchor).isActive = true
        
        buyBotton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        buyBotton.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50).isActive = true
        buyBotton.widthAnchor.constraint(equalToConstant: buyBotton.frame.size.width).isActive = true
        
    }
    
}
