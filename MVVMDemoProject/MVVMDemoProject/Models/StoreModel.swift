//
//  StoreModel.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 28/04/21.
//

import Foundation

struct StoreModel:Decodable {
    let storeID:Int?
    let name:String?
    let address:String?
    let storeLogoURL:String?
    let storeRoute:String?
    let storeAddress:String?
    
    enum CodingKeys: String, CodingKey {
        case storeID = "id"
        case name
        case address
        case storeLogoURL = "logo_url"
        case storeRoute = "store_route"
        case storeAddress = "street_address"
        
    }
}
