//
//  OrderViewController.swift
//  Flowers
//
//  Created by Алексей on 04.01.2021.
//

import UIKit

class OrderViewController: UIViewController,
                           UITableViewDelegate, UITableViewDataSource {

    var presenter:OrderPresenterProtocol!
    let tableView: UITableView = UITableView()
    let noOrderView:UIView = {
        let noOrderView = UIView()
        noOrderView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let textNoOrderLabel = UILabel()
        textNoOrderLabel.font = Fonts.Text.textSemiboldFont(size: 16.0)
        textNoOrderLabel.numberOfLines = 0
        textNoOrderLabel.textColor = Colors.Common.grayColor
        textNoOrderLabel.text = Localization.Order.noOrder
        textNoOrderLabel.sizeToFit()
        textNoOrderLabel.center = noOrderView.center
        textNoOrderLabel.textAlignment = .center
        noOrderView.addSubview(textNoOrderLabel)
        noOrderView.translatesAutoresizingMaskIntoConstraints = false
        textNoOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        textNoOrderLabel.centerXAnchor.constraint(equalTo: noOrderView.centerXAnchor).isActive = true
        textNoOrderLabel.centerYAnchor.constraint(equalTo: noOrderView.centerYAnchor).isActive = true
        return noOrderView
    }()
    var indexOfPageToRequest = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Localization.Order.title
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(noOrderView)
        self.view.addSubview(tableView)
 
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.reuseId)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
       
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
       
        noOrderView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true       
        noOrderView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
        noOrderView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        noOrderView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        noOrderView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        noOrderView.isHidden = true
       
        tableView.tableFooterView = createSpinerFooter()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)      
        self.presenter.getOrder(isPage:false)
    }
        
    
    func createSpinerFooter() -> UIView{
        let view = UIView(frame: CGRect(x: 0, y: 0, width:self.view.bounds.width, height: 50))
        let spiner = UIActivityIndicatorView()
        spiner.startAnimating()
        spiner.center = view.center
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(spiner)
        return view
    }
    
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.presenter?.order.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.reuseId, for: indexPath) as? OrderTableViewCell else {
            return UITableViewCell()
        }
        
        
        let data = presenter.order


        guard let url = URL(string:data[indexPath.row].img) else { return UITableViewCell()}


        cell.pictureImageView.sd_setImage(with: url, placeholderImage: Images.Photo.placeholder) { (image, _, _, _) in
            if image == nil {
                cell.pictureImageView.image = Images.Photo.placeholder
            }
        }

        cell.nameLabel.text = data[indexPath.row].name
        cell.priceLabel.text = String(data[indexPath.row].price).stingWithCurrency
        cell.numberLabel.text = "№" + String(data[indexPath.row].number)
        cell.dateLabel.text = data[indexPath.row].date.toDateTime()
        cell.fioLabel.text = data[indexPath.row].fio
        cell.phoneLabel.text = data[indexPath.row].phone
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 500
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
        {
        
        
        let createOrder = UIContextualAction(style: .destructive, title: Localization.Order.actionRepeat) { (action, view, handler) in
                
                var user = UserOrder()
                user.name = self.presenter.order[indexPath.row].fio
                user.phone = self.presenter.order[indexPath.row].phone
                
                let product = Product()
                product.name = self.presenter.order[indexPath.row].name
                product.price = String(self.presenter.order[indexPath.row].price)
                product.id = String( self.presenter.order[indexPath.row].id)
                product.url = self.presenter.order[indexPath.row].img
                
                
                self.showBuyAlert(product: product, userInfo: user){ (user) in
                    self.presenter.orderService.addOrder(view: self, user: user, product: product)
                }
              
            }
            createOrder.backgroundColor = Colors.Common.readColor
                
            let configuration = UISwipeActionsConfiguration(actions: [createOrder])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }

    
}

extension OrderViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (self.presenter.orderData.isPage){
            if offsetY > contentHeight - scrollView.frame.size.height {
              
                if (tableView.tableFooterView == nil){
                    tableView.tableFooterView = createSpinerFooter()
                }
        
                if (self.presenter.isRequestOrder){
                    self.presenter.getOrder(isPage:true)
                }
           
                
             }
        }else{
            tableView.tableFooterView = nil
        }
    }
}

extension OrderViewController:OrderControllerProtocol {
  
    func sucessOrder() {
     
        if (presenter.order.count == 0) && (self.presenter.orderData.curPage == 1){
            self.noOrderView.isHidden = false
            self.tableView.isHidden = true
        }else{
            self.noOrderView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
    }
    
    func errorOrder(error: String) {
        self.showAlert(message: error)
    }   
     
}

extension OrderViewController: OrderServiceControllerProtocol {
   
    func sussesServiceOrder() {
        self.presenter.getOrder(isPage:false)
        self.showAlert(message: Localization.Alert.OrderBuy.saveOrder)
    }
    
    func errorServiceOrder(error: String) {
        self.showAlert(tite: Localization.Alert.OrderBuy.title,message: error)
    }
    
}
