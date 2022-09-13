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
    
    //var drinkData = drinkOrder(drinkImage: http, drinkName: "", drinkInformation: "") // 空資料
    var drinkMessage = drinkOrder(drinkName: "", size: ["",""], price: ["",""], caffeine: ["",""], heat: ["",""], sugar: ["",""], drinkImage: URL(filePath: ""), drinkInformation: "nil")
    
    var HeatText = "大卡"
    var CaffeineText = "毫克"
    var SugarText = "公克"
    var ButtonGap = 5
    
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
