//
//  APIClass.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/13.
//

import Foundation


class OrderController{
    
    let url:URL
    let apiKey:String
    let header:String
    
    init(url: URL, apiKey: String, header: String) {
        self.url = url
        self.apiKey = apiKey
        self.header = header
        print("getUrlResponse init")
    }
    
    func getResponse(airtableUrl:String,apiKey:String,httpHeaderField:String)-> Void/*Any*/{
        let url = URL(string: airtableUrl)!
        var request = URLRequest(url: url)
        // 設定 apiKey
        request.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
        //
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            //var response = SearchResponse(records: [StoreItem]())
            
            if let data{
                do{
                    let response = try decoder.decode(SearchResponse.self, from: data)
                    
                }catch{
                    print("error \(error)")
                }
            }
        }.resume()
    }
    
    func uploadOrder(data:Order,completion:@escaping (Result<String,Error>)->()){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(data)
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if data != nil {
                completion(.success("發送成功"))
                print("成功")
            }else if let error = error{
                completion(.failure(error))
            }
        }.resume()
    }
}
