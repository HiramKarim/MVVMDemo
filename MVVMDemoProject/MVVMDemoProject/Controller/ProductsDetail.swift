//
//  ProductsDetail.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 28/04/21.
//

import UIKit

class ProductsDetail: UIViewController {
    
    let tableview:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    var storeID:Int? {
        didSet {
            guard let storeid = storeID else { return }
            configUI()
            getProductsByStore(storeid: storeid)
        }
    }
    
    var productsArray = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configUI() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.dataSource = self
        //tableview.delegate = self
    }
    
    private func getProductsByStore(storeid:Int) {
        APIService.shared.getProducts(byStore: storeid) { [weak self] (products) in
            self?.productsArray = products
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
    }
    
}

extension ProductsDetail: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let product = productsArray[indexPath.row]
        
        cell.textLabel?.text = product.name
        
        return cell
        
    }
}
