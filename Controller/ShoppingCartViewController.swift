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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView(){
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        DispatchQueue.main.async { // 畫面更新
            self.shoppingCartTableView.reloadData()
        }
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
        userOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        
        cell.drinkImageView.kf.setImage(with: userOrderList[indexPath.row].drinkImage)
        cell.drinkNameLabel.text = userOrderList[indexPath.row].drinkName
        cell.drinkSizeLabel.text = userOrderList[indexPath.row].size
        cell.drinkHeatLabel.text = "熱量:\(userOrderList[indexPath.row].heat)"
        cell.drinkCaffeineLabel.text = "咖啡因:\(userOrderList[indexPath.row].caffeine)"
        cell.drinkSugarLabel.text = "糖:\(userOrderList[indexPath.row].sugar)"
        cell.drinkQuantityLabel.text = "\(userOrderList[indexPath.row].quantity)杯"
        cell.drinkPriceLabel.text = "$\(userOrderList[indexPath.row].price)"
        
        return cell
    }
    
    // 打開 TableView 編輯模式
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.shoppingCartTableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView,commit editingStyle:UITableViewCell.EditingStyle,forRowAt indexPath:IndexPath) {

        userOrderList.remove(at: indexPath.row) // 刪除資料
        self.shoppingCartTableView.deleteRows(at: [indexPath], with: .automatic) // 刪除動畫
        //self.shoppingCartTableView.reloadData()
        print(userOrderList)
    }
    
    
}
