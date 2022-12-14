//
//  DrinkListModel.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/23.
//

import Foundation
import UIKit

// 讀取資料 ----------------------------
// 第一層
struct SearchResponse: Decodable{
    let records: [StoreItem]
}

// 第二層
struct StoreItem: Decodable{
    let id:String
    let fields:Fields
}

// 第三層
struct Fields: Decodable{
    let Name:String // 飲料名稱
    let type:String // 飲料類別
    let Classification:String // 飲料品項
    let size :[String] // 飲料容量
    let price:[String] // 價格
    let caffeine:[String] // 咖啡因
    let heat:[String] // 熱量
    let sugar:[String] // 糖
    let image:[ImageItem]// 圖片
    let content:String // 飲料簡介
}

// 圖片解析
struct ImageItem: Decodable
{
    let url:URL
    let filename:String
}
// 讀取資料 end ----------------------------


struct drinkOrder{
    var drinkName:String
    var size:[String]
    var price:[String]
    var caffeine:[String]
    var heat:[String]
    var sugar:[String]
    var drinkImage:URL
    var drinkInformation:String
    
    init(drinkName: String, size: [String], price: [String], caffeine: [String], heat: [String], sugar: [String], drinkImage: URL, drinkInformation: String) {
        self.drinkName = drinkName
        self.size = size
        self.price = price
        self.caffeine = caffeine
        self.heat = heat
        self.sugar = sugar
        self.drinkImage = drinkImage
        self.drinkInformation = drinkInformation
    }
}


struct userOrder{
    var drinkName:String
    var size:String
    var price:String
    var caffeine:String
    var heat:String
    var sugar:String
    var drinkImage:URL
    var quantity:String
}

// 暫存用
//var userOrderList = Array<userOrder>()

// 上傳用 --------------------------
struct Order:Codable{
    var records:[Records]
    struct Records:Codable{
        var fields:Fields
        struct Fields:Codable{
            var orderName:String
            var size:String
            var price:String
            var caffeine:String
            var heat:String
            var sugar:String
            var drinkImage:URL
            var quantity:String
        }
    }
}
// 上傳用 end --------------------------

// 修改用 --------------------------
struct ReviseOrder:Codable{
    var records:[Records]
    struct Records:Codable{
        var id:String
        var fields:Fields
        struct Fields:Codable{
            var orderName:String
            var size:String
            var price:String
            var caffeine:String
            var heat:String
            var sugar:String
            var drinkImage:URL
            var quantity:String
        }
    }
}
// 修改用 end --------------------------
