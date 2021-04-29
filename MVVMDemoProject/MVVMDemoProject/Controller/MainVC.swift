//
//  MainVC.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 27/04/21.
//

import UIKit

class MainVC: UIViewController {
    
    let tableview:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    var waterStores = [StoreModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        getStores()
    }
    
    private func configUI() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.title = "Water Store"
        
        self.view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func getStores() {
        APIService.shared.getStores { [weak self] (storesArray) in
            
            self?.waterStores = storesArray
            
            DispatchQueue.main.async {
                self?.tableview.dataSource = self
                self?.tableview.reloadData()
            }
        }
    }
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waterStores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let store = waterStores[indexPath.row]
        
        cell.textLabel?.text = store.name
        
        return cell
        
    }
    
    
}
