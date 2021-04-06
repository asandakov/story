//
//  ProductTableViewCell.swift
//  Flowers
//
//  Created by Алексей on 27.12.2020.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let reuseId = "ProductTableViewCell"
    
    let pictureImageView:UIImageView = {
       let img = UIImageView()
       img.translatesAutoresizingMaskIntoConstraints = false
       img.contentMode = .scaleAspectFit
       return img
    }()
         
    
    let nameLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.numberOfLines = 2
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let priceLabel:UILabel = {
       let price = UILabel()
        price.font = Fonts.Text.textSemiboldFont(size: 16.0)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textColor = Colors.Product.price
        return price
    }()

    let buyBotton:UIButton = {
        let buy = UIButton(type: .system)
        buy.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        buy.setTitleColor(Colors.Product.textBuy, for: .normal)
        buy.setTitle(Localization.Product.textBuyButton, for: .normal)
        buy.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        buy.backgroundColor = Colors.Product.backgroundBuy
        buy.layer.cornerRadius = 5
        buy.translatesAutoresizingMaskIntoConstraints = false
        return buy
    }()
    
    var buyBottonAction : (() -> ())?
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(pictureImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(buyBotton)
 
              
        buyBotton.addTarget(self, action: #selector(clickBuyBottonn(_:)), for: .touchUpInside)
                                    
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setConstraint()
        

        
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
      
  
    @objc func clickBuyBottonn(_ sender:UIButton){
        buyBottonAction?()
    }
    
    
    
    func setConstraint() {

        pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
       pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        pictureImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true

   
                               
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 10).isActive = true


        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: buyBotton.centerYAnchor).isActive = true


        buyBotton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        buyBotton.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50).isActive = true
        buyBotton.widthAnchor.constraint(equalToConstant: buyBotton.frame.size.width).isActive = true
        
    }

}
