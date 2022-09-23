//
//  ReviseViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/21.
//

import UIKit
import Kingfisher

class ReviseViewController: UIViewController {
    
    
    @IBOutlet weak var drinkImageView: UIImageView!
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkQuantityLabel: UILabel!
    @IBOutlet weak var drinkHeatLabel: UILabel!
    @IBOutlet weak var drinkCaffeineLabel: UILabel!
    @IBOutlet weak var drinkSugarLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!
    
    @IBOutlet weak var drinkSegmentedControl: UISegmentedControl!
    
    
    // 上一頁點選的資料
    var drinkMessage = OrderItems(id: "", fields: OrderFields(orderName: "", size: "", price: "", caffeine: "", heat: "", sugar: "", drinkImage: URL(filePath: ""), quantity: "")) // 接資料
    // 全部飲料資料 篩選用
    var drinkdata = OrderItems(id: "", fields: OrderFields(orderName: "", size: "", price: "", caffeine: "", heat: "", sugar: "", drinkImage: URL(filePath: ""), quantity: "")) // 接資料

    var baseURL = URL(string: "https://api.airtable.com/v0/appYY0o7fiRNpJDPF/Order")!
    
    var priceArray = [String]()
    var caffeineArray = [String]()
    var sugarArray = [String]()
    var sizeArray = [String]()
    // 使用者選擇的變數
    var pickValue = 0

    
    var drinkQuantity = 1 // 預設的飲料數量
    
    // 初始化
    init?(coder: NSCoder,orderData:OrderItems) {
        super.init(coder: coder)
        // 接資料
        self.drinkMessage = orderData
        print("drinkMessage \(drinkMessage)")
        print("drinkMessage \(drinkMessage.fields.orderName)")
    }
    // 初始化失敗時
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.uiInit()
        self.setSegmentedControl()
        // Do any additional setup after loading the view.
    }
    
    func uiInit(){
        drinkNameLabel.text = drinkMessage.fields.orderName
        drinkImageView.kf.setImage(with: drinkMessage.fields.drinkImage)
        drinkQuantityLabel.text =  drinkMessage.fields.quantity
        drinkHeatLabel.text = drinkMessage.fields.heat
        drinkCaffeineLabel.text = drinkMessage.fields.caffeine
        drinkSugarLabel.text = drinkMessage.fields.sugar
        drinkPriceLabel.text = drinkMessage.fields.price
        drinkQuantity = Int(drinkMessage.fields.quantity)!
    }
    
    func getData(){
        for i in 0...drinkData.count - 1{
            if(drinkData[i].fields.Name == drinkMessage.fields.orderName){

                priceArray = drinkData[i].fields.price
                caffeineArray = drinkData[i].fields.caffeine
                sugarArray = drinkData[i].fields.sugar
                sizeArray = drinkData[i].fields.size
            }
        }
        print("price \(priceArray)")
        print("caffeine \(caffeineArray)")
        print("sugar \(sugarArray)")
        print("size \(sizeArray)")
    }
    
    func setSegmentedControl(){
        for i in 0...sizeArray.count - 1{
            if( i <= drinkSegmentedControl.numberOfSegments - 1){
                // 設定 Title
                drinkSegmentedControl.setTitle("\(sizeArray[i])", forSegmentAt: i)
            }
            else{
                // 新增 Title
                drinkSegmentedControl.insertSegment(withTitle: "\(sizeArray[i])", at: i, animated: true)
            }
        }
    }
    
    func updateUI(){
        drinkQuantityLabel.text = String(drinkQuantity)
        print("drinkQuantity \(drinkQuantity)")
        print("pickValue \(pickValue)")
        drinkPriceLabel.text = "\(Int(priceArray[pickValue])! * drinkQuantity)"
    }
    
    @IBAction func quantityAction(_ sender: UIButton) {
        switch sender.tag{
        case 0:
            if(drinkQuantity <= 1){
                drinkQuantity = 1
            }else{
                drinkQuantity -= 1
            }
            self.updateUI()//更新數據
        case 1:
            drinkQuantity += 1
            self.updateUI()//更新數據
        default:
            print("nil")
        }
    }
    
    @IBAction func segmentChangeAction(_ sender: UISegmentedControl) {
        switch drinkSegmentedControl.selectedSegmentIndex {
           case 0...drinkSegmentedControl.numberOfSegments - 1 :
            pickValue = sender.selectedSegmentIndex
            self.updateUI()
           default:
               break
           }
    }
    
    @IBAction func reviseAction(_ sender: Any) {
        
        let orderFields = ReviseOrder.Records.Fields(orderName: drinkMessage.fields.orderName, size: sizeArray[pickValue], price: priceArray[pickValue], caffeine: caffeineArray[pickValue], heat:  drinkMessage.fields.heat, sugar: drinkMessage.fields.sugar, drinkImage: drinkMessage.fields.drinkImage, quantity: "\(drinkQuantity)")
        let orderRecords = ReviseOrder.Records(id: "\(drinkMessage.id)", fields: orderFields)
        let order = ReviseOrder(records: [orderRecords])
        
        print("ID \(drinkMessage.id)")
        print("修改後 \(orderFields)")
        print("order \(order)")
        ///\(drinkMessage.id)
        NetworkController.shared.updateOrder(urlString: "\(self.baseURL)",data: order){result in
            switch result{
            case .success(let result):
                print("修改成功 \(result)")
            case .failure(_):
                print("Error")
            }
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
