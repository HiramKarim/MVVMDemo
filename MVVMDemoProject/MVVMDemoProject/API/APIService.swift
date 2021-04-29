//
//  APIService.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 28/04/21.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    func getStores(completion: @escaping (_ stores:[StoreModel]) -> Void) {
        
        guard let url = URL(string: "http://waterstoreproject-dev.us-west-1.elasticbeanstalk.com/stores/list") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                if let storesDecoded = try? JSONDecoder().decode([StoreModel].self, from: data) {
                    completion(storesDecoded)
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        
    }
    
    func getProducts(byStore storeid:Int, completion: @escaping (_ stores:[ProductModel]) -> Void) {
        
        guard let url = URL(string: "http://waterstoreproject-dev.us-west-1.elasticbeanstalk.com/products/list/\(storeid)") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                if let productsDecoded = try? JSONDecoder().decode([ProductModel].self, from: data) {
                    completion(productsDecoded)
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        
    }
    
}
