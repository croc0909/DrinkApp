//
//  DrinkOrderModel.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/20.
//

import Foundation
import UIKit


struct shoppingCartResponse: Codable{
    let records: [OrderItems]
}

struct OrderItems: Codable{
    let id:String
    let fields: OrderFields
}

struct OrderFields: Codable{
    var orderName:String
    var size:String
    var price:String
    var caffeine:String
    var heat:String
    var sugar:String
    var drinkImage:URL
    var quantity:String
}

