//
//  ProductModel.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 28/04/21.
//

import Foundation

struct ProductModel:Decodable {
    let id:Int
    let name:String
    let price:Decimal
    let stock:Int
}
