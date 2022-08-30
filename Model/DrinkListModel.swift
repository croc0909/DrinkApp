//
//  DrinkListModel.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/23.
//

import Foundation
import UIKit

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
    let size :[String] // 飲料容量
    let price:[String] // 價格
    let image:[ImageItem]// 圖片
    let Name:String // 飲料名稱
    let type:String // 飲料類別
    let Classification:String // 飲料品項
    let content:String // 飲料簡介
}

// 圖片解析
struct ImageItem: Decodable
{
    let url:URL?
    let filename:String
}

struct drinkList{
    var drinkDictionary: [String: [drinkDetail]]
}

struct drinkDetail{
    var drinkDetailDictionary: [String: [Drink]]
}

struct Drink{
    var drinkInformation:[String: String]
}

//let DrinkLists = []

let DrinkList = ["咖啡飲品":DrinkDetailList]

let DrinkDetailList = ["每日精選":CofficeOfDay,"濃縮咖啡飲料":Espresso]

let Drinks = [ ["drinkName": "每日精選咖啡", "drinkImage": "每日精選咖啡"]
]

let CofficeOfDay = [
    ["drinkName": "每日精選咖啡", "drinkImage": "每日精選咖啡"],
    ["drinkName": "冰每日精選咖啡", "drinkImage": "冰每日精選咖啡"],
    ["drinkName": "咖啡密斯朵", "drinkImage": "咖啡密斯朵"]
]

let Espresso = [
    ["drinkName": "可可瑪奇朵", "drinkImage": "可可瑪奇朵"],
    ["drinkName": "冰可可瑪奇朵", "drinkImage": "冰可可瑪奇朵"],
    ["drinkName": "雲朵冰搖濃縮咖啡", "drinkImage": "雲朵冰搖濃縮咖啡"],
    ["drinkName": "那堤", "drinkImage": "那堤"],
    ["drinkName": "冰那堤", "drinkImage": "冰那堤"],
    ["drinkName": "焦糖瑪奇朵", "drinkImage": "焦糖瑪奇朵"],
    ["drinkName": "冰焦糖瑪奇朵", "drinkImage": "冰焦糖瑪奇朵"],
    ["drinkName": "摩卡", "drinkImage": "摩卡"],
    ["drinkName": "冰摩卡", "drinkImage": "冰摩卡"],
    ["drinkName": "卡布奇諾", "drinkImage": "卡布奇諾"],
    ["drinkName": "美式咖啡", "drinkImage": "美式咖啡"],
    ["drinkName": "冰美式咖啡", "drinkImage": "冰美式咖啡"],
    ["drinkName": "濃縮咖啡", "drinkImage": "濃縮咖啡"],
    ["drinkName": "特選馥郁那堤", "drinkImage": "特選馥郁那堤"],
    ["drinkName": "冰特選馥郁那堤", "drinkImage": "冰特選馥郁那堤"],
    ["drinkName": "馥列白", "drinkImage": "馥列白"],
    ["drinkName": "冰馥列白", "drinkImage": "冰馥列白"],
    ["drinkName": "白巧克力那堤", "drinkImage": "白巧克力那堤"],
    ["drinkName": "冰白巧克力那堤", "drinkImage": "冰白巧克力那堤"]
]

