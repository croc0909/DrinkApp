//
//  APIClass.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/13.
//

import Foundation


class NetworkController{
    static let shared = NetworkController()
    
    var url:URL
    var apiKey:String
    var header:String
    
    let baseURL = URL(string: "https://api.airtable.com/v0/appYY0o7fiRNpJDPF/Order")!
    
    init(){
        self.url = baseURL
        self.apiKey = "Bearer keyU9Ueumx1YzPC06"
        self.header = "Authorization"
        print("getUrlResponse init")
    }
    
    func setClass(url: URL, apiKey: String, header: String){
        self.url = url
        self.apiKey = apiKey
        self.header = header
    }
    
    //
    func getResponse(url: URL, completion: @escaping (Result<[OrderItems], Error>) -> Void){
        var request = URLRequest(url: url)
        // 設定 apiKey
        request.setValue(self.apiKey, forHTTPHeaderField: self.header)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let content = String(data: data! , encoding: .utf8){
              //print("content \(content)")
            }
            
            if let data{
                do{
                    let shopResponse = try decoder.decode(shoppingCartResponse.self, from: data)
                    completion(.success(shopResponse.records))
                    //print("shopResponse \(shopResponse)")
                }catch{
                    completion(.failure(error))
                    //print("error \(error)")
                }
            }
        }.resume()
    }
    
    // POST
    func uploadOrder(data:Order,completion:@escaping (Result<String,Error>)->()){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(apiKey)", forHTTPHeaderField: "\(self.header)")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(data)
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            if data != nil {
                completion(.success("發送成功"))
                if let content = String(data: data! , encoding: .utf8){
                 //print("response\(String(describing: response)) error\(String(describing: error))")
                  print("content \(content)")
                }
                
            }else if let error = error{
                completion(.failure(error))
            }
        }.resume()
    }
    
    // PATCH
    func updateOrder(urlString:String,data:ReviseOrder,completion:@escaping (Result<String,Error>)->()){
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("\(apiKey)", forHTTPHeaderField: "\(self.header)")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(data)
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            if data != nil {
                completion(.success("修改成功"))
                if let content = String(data: data! , encoding: .utf8){
                 //print("response\(String(describing: response)) error\(String(describing: error))")
                  print("content \(content)")
                }
                
            }else if let error = error{
                completion(.failure(error))
            }
        }.resume()
    }
    
    // DELETE
    func deleteOrder(urlString: String) {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue("\(apiKey)", forHTTPHeaderField: "\(self.header)")
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if let response = response as? HTTPURLResponse, error == nil {
              print("Delete success")
              print(response.statusCode)
            } else {
              print(error)
            }
        }.resume()
    }
    
}
