//
//  APIClass.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/13.
//

import Foundation


class getUrlResponse{
    
    let url:String
    let apiKey:String
    let header:String
    
    init(url: String, apiKey: String, header: String) {
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
}
