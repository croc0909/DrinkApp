//
//  DrinkListViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/23.
//

import UIKit

class DrinkListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var drinkListTableView: UITableView!
    
    var airtableUrl = "https://api.airtable.com/v0/appYY0o7fiRNpJDPF/Projects"
    var apiKey = "Bearer keyU9Ueumx1YzPC06"
    var httpHeaderField = "Authorization"
    
    var drinkData = [StoreItem]() // 空資料
    var drinkClassification = [String]() // 飲料類別

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUrl()
        self.tableViewInit()
        // Do any additional setup after loading the view.
    }
    
    func getUrl(){
        let url = URL(string: airtableUrl)!
        var request = URLRequest(url: url)
        // 設定 apiKey
        request.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
        //
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let data{
                do{
                    let SearchResponse = try decoder.decode(SearchResponse.self, from: data)
                    
                    for i in 0...(SearchResponse.records.count - 1){
                        self.drinkData.append(SearchResponse.records[i])
                    }
                    self.updateMenu()
                }catch{
                    print("error \(error)")
                }
            }
        }.resume()
        
    }
    
    func updateMenu(){
        print("\(drinkData.count)")
        print("drinkClassification \(drinkClassification.count)")
        for i in 0...(drinkData.count - 1){
            print("\(i) \(drinkData[i].fields.Classification)")
            
            if(drinkClassification.count == 0){
                drinkClassification.append(drinkData[i].fields.Classification)
            }
            else{
                for x in 0...(drinkClassification.count - 1){ // 檢查是否有相同飲料類別
                    print("Class \(drinkClassification[x]) Data \(drinkData[i].fields.Classification)")
                    if(drinkClassification[x] == drinkData[i].fields.Classification){
                        break
                    }
                    else{
                        drinkClassification.append(drinkData[i].fields.Classification)
                        break
                    }
                }
            }
        }
        
        DispatchQueue.main.async { // 畫面更新
            self.drinkListTableView.reloadData()
        }
        print("drinkClassification \(drinkClassification)")
    }
    
    func tableViewInit(){
        drinkListTableView.delegate = self
        drinkListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkClassification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkListCell", for: indexPath) as! DrinkListCell
        cell.productImageView.image = UIImage(named: "摩卡")
        cell.productNameLael.text = drinkClassification[indexPath.row]
        return cell
        
    }
    
    
    @IBSegueAction func toDrinkDetailSegueAction(_ coder: NSCoder) -> DrinkDetailViewController? {
        return nil/*DrinkDetailViewController(coder: coder,type: DrinkDetail)*/
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
