//
//  ShoppingCartViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/13.
//

import UIKit
import Kingfisher

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    var drinkDatas = [OrderItems]() // 飲料資料
    var drinkValue = 0
    var baseURL = URL(string: "https://api.airtable.com/v0/appYY0o7fiRNpJDPF/Order")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        print("Show \(drinkData)")
        //self.getShoppingCart()
        // Do any additional setup after loading the view.
    }
    
    func setTableView(){
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        self.getShoppingCart()
    }

    func getShoppingCart(){
        NetworkController.shared.getResponse(url: self.baseURL) { result in
            switch result{
            case .success(let ShoppingCartDatas):
                //print("ShoppingCartDatas \(ShoppingCartDatas)")
                print("Fetch Data Success")
                self.updateUI(with: ShoppingCartDatas)
            case .failure(let error):
                print("error \(error)")
                //self.displayError(error, title: "Failed To Fetch The Data!")
            }
        }
    }
    
    func updateUI(with ShoppingCartDatas: [OrderItems]) {
        drinkDatas = ShoppingCartDatas
        DispatchQueue.main.async {
            self.shoppingCartTableView.reloadData()
        }
    }
    
    
    @IBSegueAction func toReviseViewSegue(_ coder: NSCoder) -> ReviseViewController? {
        return ReviseViewController(coder: coder,orderData: drinkDatas[drinkValue])
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

extension ShoppingCartViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        
        cell.drinkImageView.kf.setImage(with: drinkDatas[indexPath.row].fields.drinkImage)
        cell.drinkNameLabel.text = drinkDatas[indexPath.row].fields.orderName
        cell.drinkSizeLabel.text = drinkDatas[indexPath.row].fields.size
        cell.drinkHeatLabel.text = "熱量:\(drinkDatas[indexPath.row].fields.heat)"
        cell.drinkCaffeineLabel.text = "咖啡因:\(drinkDatas[indexPath.row].fields.caffeine)"
        cell.drinkSugarLabel.text = "糖:\(drinkDatas[indexPath.row].fields.sugar)"
        cell.drinkQuantityLabel.text = "\(drinkDatas[indexPath.row].fields.quantity)杯"
        cell.drinkPriceLabel.text = "$\(drinkDatas[indexPath.row].fields.price)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("點擊\(drinkDatas[indexPath.row])")
        drinkValue = indexPath.row
        performSegue(withIdentifier: "toReviseViewController", sender: nil) // 跳頁
    }
    
    // 打開 TableView 編輯模式
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.shoppingCartTableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView,commit editingStyle:UITableViewCell.EditingStyle,forRowAt indexPath:IndexPath) {

        print("id \(drinkDatas[indexPath.row].id)")
        NetworkController.shared.deleteOrder(urlString: "\(self.baseURL)/\(drinkDatas[indexPath.row].id)")

        drinkDatas.remove(at: indexPath.row) // 刪除資料
        self.shoppingCartTableView.deleteRows(at: [indexPath], with: .automatic) // 刪除動畫
    }
}
