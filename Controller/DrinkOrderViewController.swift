//
//  DrinkOrderViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/31.
//

import UIKit
import Kingfisher

class DrinkOrderViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkInformationLabel: UILabel!
    @IBOutlet weak var drinkHeatLabel: UILabel!
    @IBOutlet weak var drinkSugarLabel: UILabel!
    @IBOutlet weak var drinkCaffeineLabel: UILabel!
    
    @IBOutlet weak var drinkOrderScrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var drinkSizeScrollView: UIScrollView!
    
    
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var reduceButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var addDrinkButton: UIButton!
    @IBOutlet weak var drinkQuantityLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!
    
    
    var drinkMessage = drinkOrder(drinkName: "", size: ["",""], price: ["",""], caffeine: ["",""], heat: ["",""], sugar: ["",""], drinkImage: URL(filePath: ""), drinkInformation: "nil")
    
    var userDrinkOrder = userOrder(drinkName: "", size: "", price: "", caffeine: "", heat: "", sugar: "", drinkImage: URL(filePath: ""), quantity: "")
    
    
    
    var HeatText = "大卡"
    var CaffeineText = "毫克"
    var SugarText = "公克"
    var ButtonGap = 5
    
    var drinkQuantity = 1 // 飲料預設數量
    var drinkPrice = 0 // 飲料價格
    
    // 初始化
    init?(coder: NSCoder, data: drinkOrder) {
        super.init(coder: coder)
        drinkMessage = data
        print(drinkMessage)
    }
    // 初始化失敗時
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drinkOrderViewInit()
        // Do any additional setup after loading the view.
    }
    
    func drinkOrderViewInit(){
        self.setScrollView()
        self.setData()
    }
    
    func setScrollView(){
        drinkOrderScrollView.delegate = self
        let ScrollViewContentWidth = scrollContentView.layer.frame.width
        let ScrollViewContentHeight = scrollContentView.layer.frame.height
        drinkOrderScrollView.contentSize = CGSize(width: ScrollViewContentWidth, height: ScrollViewContentHeight)
        
        drinkSizeScrollView.delegate = self
        let drinkContentHeight = drinkSizeScrollView.layer.frame.size.height
        let drinkContentWidth = drinkContentHeight * CGFloat(drinkMessage.size.count) +
        (CGFloat(ButtonGap) * CGFloat(drinkMessage.size.count - 1))
        
        drinkSizeScrollView.contentSize = CGSize(width: drinkContentWidth, height: drinkContentHeight)
        //print("drinkSizeScrollView \(drinkSizeScrollView.contentSize)")
        
        for i in 0...(drinkMessage.size.count - 1){
            //print("size \(drinkMessage.size[i])")
            // 按鈕部分
            let buttonHight = drinkSizeScrollView.layer.frame.size.height
            let buttonWidth = buttonHight
        
            //print("buttonHight \(buttonHight) buttonWidth \(buttonWidth)")
            let buttonX = (buttonWidth * CGFloat(i)) + (CGFloat(ButtonGap) * CGFloat(i))
            print("buttonX \(i) \(buttonX) ")
            
            let button = UIButton(frame: CGRect(x: buttonX, y: 0 , width: buttonWidth, height: buttonHight))
            button.backgroundColor = .blue // 測試按鈕顏色用
            button.setTitle(drinkMessage.size[i], for: .normal)
            //button.alpha = 0.1 // 將按鈕設為透明
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            drinkSizeScrollView.addSubview(button)
             
        }
    }
    
    func setData(){
        drinkImageView.kf.setImage(with: drinkMessage.drinkImage)
        drinkNameLabel.text = drinkMessage.drinkName
        drinkInformationLabel.text = drinkMessage.drinkInformation
        drinkHeatLabel.text = "\(drinkMessage.heat[0])\(HeatText)"
        drinkCaffeineLabel.text = "\(drinkMessage.caffeine[0])\(CaffeineText)"
        drinkSugarLabel.text = "\(drinkMessage.sugar[0])\(SugarText)"
        drinkPriceLabel.text = "\(drinkMessage.price[0])"
        
        drinkPrice = Int(drinkMessage.price[0]) ?? 0
        userDrinkOrder.drinkName = "\(drinkMessage.drinkName)"
        userDrinkOrder.size = "\(drinkMessage.size[0])"
        userDrinkOrder.caffeine = "\(drinkMessage.caffeine[0])\(CaffeineText)"
        userDrinkOrder.sugar = "\(drinkMessage.sugar[0])\(SugarText)"
        userDrinkOrder.heat = "\(drinkMessage.heat[0])\(HeatText)"
        userDrinkOrder.price = "\(drinkMessage.price[0])"
        userDrinkOrder.drinkImage = drinkMessage.drinkImage
    }
    
    @objc func buttonAction(sender: UIButton!){
        if let buttonName = sender.currentTitle {
            self.updateInformation(choose: buttonName)
        }
    }
    
    func updateInformation(choose:String){
        for i in 0...(drinkMessage.size.count - 1){
            if(choose == drinkMessage.size[i]){
                print("選擇 \(drinkMessage.size[i])")
                
                drinkHeatLabel.text = "\(drinkMessage.heat[i])\(HeatText)"
                drinkSugarLabel.text = "\(drinkMessage.sugar[i])\(SugarText)"
                drinkCaffeineLabel.text = "\(drinkMessage.caffeine[i])\(CaffeineText)"
                
                drinkPrice = Int(drinkMessage.price[i]) ?? 0
            }
        }
        
        self.updateShopViewValue() //更新數據
    }
    

    @IBAction func quantityAction(_ sender: UIButton) {
        //print("\(sender.tag)")
        switch sender.tag{
        case 0:
            print("減飲料")
            if(drinkQuantity < 1){
                drinkQuantity = 1
            }else{
                drinkQuantity -= 1
            }
            self.updateShopViewValue()//更新數據
        case 1:
            print("加飲料")
            drinkQuantity += 1
            self.updateShopViewValue()//更新數據
        default:
            print("nil")
        }
    }
    
    func updateShopViewValue(){
        drinkQuantityLabel.text = String(drinkQuantity)
        print("drinkPrice \(drinkPrice)")
        print("drinkQuantity \(drinkQuantity)")
        drinkPriceLabel.text = "\(drinkPrice * drinkQuantity)"
        
        userDrinkOrder.quantity = "\(drinkQuantity)" // 訂單飲料數量
        userDrinkOrder.price = "\(drinkPrice * drinkQuantity)" // 訂單飲料總價
    }
    
    @IBAction func addDrinkButtonAction(_ sender: Any) {
        print("加入購物車")
        
        print("userDrinkOrder \(userDrinkOrder)")
        //userOrderList.append(userDrinkOrder)
        userOrderList.append(userDrinkOrder) // 儲存飲料清單
        print("userOrderList \(userOrderList)")
        
        print(userOrderList.count)
        
        let orderFields = Order.Records.Fields(drinkName: userDrinkOrder.drinkName, size: userDrinkOrder.size, price: userDrinkOrder.price, caffeine: userDrinkOrder.caffeine, heat: userDrinkOrder.heat, sugar: userDrinkOrder.sugar, drinkImage: userDrinkOrder.drinkImage, quantity: userDrinkOrder.quantity)
        let orderRecords = Order.Records(fields: orderFields)
        let order = Order(records: [orderRecords])
        
        let uploadURL = URL(string: "https://api.airtable.com/v0/appYY0o7fiRNpJDPF/Order")!
        let apiKey = "Bearer keyU9Ueumx1YzPC06"
        let httpHeaderField = "Authorization"
        let orderController = OrderController(url: uploadURL, apiKey: apiKey, header: httpHeaderField)
        
        print("order \(order)")
        
        orderController.uploadOrder(data: order){result in
            switch result{
            case .success(let result):
                print("訂購成功 \(result)")
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
