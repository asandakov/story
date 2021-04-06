//
//  OrderTableViewCell.swift
//  Flowers
//
//  Created by Алексей on 05.01.2021.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    static let reuseId = "OrderTableViewCell"
    
    
    let numberLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.numberOfLines = 1
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    let dateLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.numberOfLines = 1
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    
    let pictureImageView:UIImageView = {
       let img = UIImageView()
       img.translatesAutoresizingMaskIntoConstraints = false
       img.contentMode = .scaleAspectFit
       return img
    }()
         
    
    let nameLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.numberOfLines = 1
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

  
    let fioLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.numberOfLines = 1
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    let phoneLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.numberOfLines = 1
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(numberLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(pictureImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(fioLabel)
        contentView.addSubview(phoneLabel)
                     
        
      
        
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      
        setConstraint()
        

        
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
      

    
    
    
    func setConstraint() {

        numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
     
        
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
     
        fioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        fioLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10).isActive = true
        fioLabel.widthAnchor.constraint(equalToConstant: contentView.frame.size.width - phoneLabel.frame.size.width - 50).isActive = true
       
        phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: fioLabel.topAnchor).isActive = true
       
        
        
        pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
       pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        pictureImageView.topAnchor.constraint(equalTo: fioLabel.bottomAnchor, constant: 10).isActive = true
        pictureImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true

   
                               
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 10).isActive = true


        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true



        
    }

}
