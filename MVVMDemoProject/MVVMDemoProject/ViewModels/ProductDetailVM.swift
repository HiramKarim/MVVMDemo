//
//  ProductDetailVM.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 16/05/21.
//

import Foundation

class ProductsDetailVM {
    
    private let apiService:APIService
    
    private var productsArray = [ProductModel]()
    
    private var productsToBuy = [ProductModel]()
    
    init(apiService:APIService) {
        self.apiService = apiService
    }
    
    func getProductsByStore(storeid:Int, completion: @escaping () -> Void) {
        apiService.getProducts(byStore: storeid) { [weak self] (products) in
            self?.productsArray = products
            completion()
        }
    }
    
    func getProducts() -> [ProductModel] {
        return productsArray
    }
    
    func getProductsCount() -> Int {
        return productsArray.count
    }
    
    func getProductAtPosition(position:Int) -> ProductModel {
        return productsArray[position]
    }
    
    func addProductToBuy(position:Int) {
        productsToBuy.append(getProductAtPosition(position: position))
    }
    
}
