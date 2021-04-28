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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
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
        tableview.dataSource = self
        tableview.reloadData()
    }
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "index: \(indexPath.row)"
        
        return cell
        
    }
    
    
}
