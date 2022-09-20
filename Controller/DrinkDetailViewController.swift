//
//  DrinkDetailViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/24.
//

import UIKit
import Kingfisher

class DrinkDetailViewController: UIViewController, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    var DrinkDetailKeyArray = [String]()
    
    @IBOutlet weak var drinkDetaiTableView: UITableView!
    let featuredCoffeeScrollView: UIScrollView! = nil

    var drinkClassification = [String]() // 飲料類別
    var drinkData = [StoreItem]() // 準備接前一頁資訊的空資料
    var drinkDataForCell = [StoreItem]() // cell 存資料用
    var drinkMessage = drinkOrder(drinkName: "", size: ["",""], price: ["",""], caffeine: ["",""], heat: ["",""], sugar: ["",""], drinkImage: URL(filePath: ""), drinkInformation: "nil")

    var imageWidthGap = 10 // scrollView圖片左右間隔
    var imageHeightGap = 5 // Label與 Image 間隔
    var cellHeaderHeight = 60 // cell 標題高度
    var tableCellHeight = 360 //統一 Cell 高度
    var labelHight = 30 // label 高度
    var pickCell = 0 // 被選到的cell
    var pickButton = 0 // 被選到的按鈕
    
    // 初始化
    init?(coder: NSCoder, data: [StoreItem]) {
        super.init(coder: coder)
        drinkData = data
    }
    // 初始化失敗時
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDrinkMenu()
        self.setTableView()
        // Do any additional setup after loading the view.
    }
    
    func updateDrinkMenu(){
        for i in 0...(drinkData.count - 1){
            if(drinkClassification.count == 0){
                drinkClassification.append(drinkData[i].fields.type)
            }
            else{
                var classRepeat = false
                for x in 0...(drinkClassification.count - 1){ // 檢查是否有相同飲料類別
                    if(drinkClassification[x] == drinkData[i].fields.type){
                        classRepeat = true
                        break
                    }
                    else{
                    }
                }
                
                if(!classRepeat){ // 判斷沒有重複才加入
                    drinkClassification.append(drinkData[i].fields.type)
                }
            }
        }
        print(" Class \(drinkClassification)")
    }
    
    func viewReloadData(){
        DispatchQueue.main.async { // 畫面更新
            self.drinkDetaiTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkClassification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkDetaiCell", for: indexPath) as! DrinkDetaiCell
        
        
        let scrollView = UIScrollView() // 建立一個 scrollView
        let coffeeScrollView = scrollViewInit(scrollView: scrollView, row: indexPath.row)
        cell.addSubview(coffeeScrollView)
        
        let coffeeLabelView = labelViewInit(row: indexPath.row)
        cell.addSubview(coffeeLabelView)

        return cell
    }
    
    func setTableView(){
        drinkDetaiTableView.delegate = self
        drinkDetaiTableView.dataSource = self
        drinkDetaiTableView.rowHeight = CGFloat(tableCellHeight)
    }
    
    func labelViewInit(row:Int)->UILabel{
        let labelText = UILabel(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: cellHeaderHeight))
        labelText.text = drinkClassification[row]
        labelText.font = labelText.font.withSize(40)
        //labelText.backgroundColor = .darkGray
        return labelText
    }
    
    func scrollViewInit(scrollView:UIScrollView,row:Int) -> UIScrollView {
        
        drinkDataForCell = [StoreItem]() // 初始化
        
        for i in 0...(drinkData.count - 1){
            if(drinkClassification[row] == drinkData[i].fields.type) // 檢查同類別的飲料
            {
                drinkDataForCell.append(drinkData[i])
            }
        }
        
        scrollView.frame.size.width = self.view.frame.width // 設定 ScrollView 寬度
        scrollView.frame.size.height = CGFloat(tableCellHeight) // 設定  ScrollView 高度
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false // 不顯示垂直顯示條
        scrollView.showsHorizontalScrollIndicator = false // 不顯示水平顯示條

        let imageWidth = scrollView.frame.size.height - CGFloat(imageWidthGap) - CGFloat(labelHight) - CGFloat(cellHeaderHeight)
        let ScrollViewContentWidth = (imageWidth * CGFloat(drinkDataForCell.count)) + (CGFloat(imageWidthGap) * CGFloat(drinkDataForCell.count - 1))
        
        let ScrollViewContentHeight = scrollView.frame.size.height
        scrollView.contentSize = CGSize(width: ScrollViewContentWidth, height: ScrollViewContentHeight) // 設定 ScrollView 內容寬、高
        
        
        for i in 0...(drinkDataForCell.count - 1)
        {
            // 圖片部分
            let ImageViewHeight = scrollView.frame.size.height - (CGFloat(cellHeaderHeight) + CGFloat(imageWidthGap) + CGFloat(labelHight))
            let ImageViewX = (ImageViewHeight * CGFloat(i)) + (CGFloat(imageWidthGap) * CGFloat(i))
            //print("X \(ImageViewX)")

            let imageView = UIImageView(frame: CGRect(x:ImageViewX,y:CGFloat(0 + cellHeaderHeight),width: ImageViewHeight ,height:ImageViewHeight )) // 定義imageView 長寬

            imageView.kf.setImage(with: drinkDataForCell[i].fields.image[0].url) //顯示圖片
            imageView.contentMode = .scaleAspectFill // 圖片顯示模式
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            imageView.layer.cornerRadius = imageView.frame.size.height/2 // 圓角
            scrollView.addSubview(imageView) // 將圖片加入 ScrollView
            //print("X \(ImageViewX)")
            //print("scrollView \(scrollView.contentSize)")
            //print(ImageViewHeight)
            
            // 文字部分
            let labelHeight = labelHight
            let labelWidth = ImageViewHeight
            
            let labelX = labelWidth * CGFloat(i) + (CGFloat(imageWidthGap) * CGFloat(i))
            let labelY = ImageViewHeight + CGFloat(imageWidthGap) + CGFloat(cellHeaderHeight)
       
            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: labelWidth, height: CGFloat(labelHeight)))
            //label.backgroundColor = .blue // 確認排版用
            label.text = drinkDataForCell[i].fields.Name
            label.textAlignment = .center // 文字置中
            label.backgroundColor = .yellow // 測試用
            scrollView.addSubview(label)
            
            // 按鈕部分
            let buttonWidth = ImageViewHeight
            let buttonHight = scrollView.frame.size.height - CGFloat(cellHeaderHeight)
            
            let buttonX = (buttonWidth * CGFloat(i)) + (CGFloat(imageWidthGap) * CGFloat(i))
            
            let button = UIButton(frame: CGRect(x: buttonX, y: 0 + CGFloat(cellHeaderHeight), width: buttonWidth, height: buttonHight))
            button.backgroundColor = .white // 測試按鈕顏色用
            button.setTitle(drinkDataForCell[i].fields.Name, for: .normal)
            button.alpha = 0.1 // 將按鈕設為透明
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            scrollView.addSubview(button)
        }
        
        return scrollView // 回傳處理好的陣列
    }
    
    @objc func buttonAction(sender: UIButton!){
        // 判斷 button 來自第幾個cell
        let point = sender.convert(CGPoint.zero, to: drinkDetaiTableView)
        if let indexPath = drinkDetaiTableView.indexPathForRow(at: point) {
            pickCell = indexPath.row
            print("類別 \(drinkClassification[pickCell])")
        }
        
        // 判斷按鈕的位置 在scrollView 是第幾個
        let button = sender.convert(CGPoint.zero, to: sender.superview)
        //print("點到位置 \(button.x)")
        var drinkRow = [Int]()
        for i in 0...(drinkData.count - 1){
            if(drinkData[i].fields.type == drinkClassification[pickCell]){//篩選類別的資料
                drinkRow.append(i)
            }
        }
        
        for i in 0...(drinkRow.count - 1){
            let currentButton = sender.frame.size.width * CGFloat(i) + (CGFloat(imageWidthGap) * CGFloat(i))
            
            if(button.x == currentButton)//判斷點擊的是哪個 Button
            {
                drinkMessage.drinkName = drinkData[drinkRow[i]].fields.Name
                drinkMessage.size = drinkData[drinkRow[i]].fields.size
                drinkMessage.price = drinkData[drinkRow[i]].fields.price
                drinkMessage.caffeine = drinkData[drinkRow[i]].fields.caffeine
                drinkMessage.heat = drinkData[drinkRow[i]].fields.heat
                drinkMessage.sugar = drinkData[drinkRow[i]].fields.sugar
                drinkMessage.drinkImage = drinkData[drinkRow[i]].fields.image[0].url
                drinkMessage.drinkInformation = drinkData[drinkRow[i]].fields.content
                //print("show \(drinkData[drinkRow[i]].fields)")
            }
        }
        
        performSegue(withIdentifier: "toDrinkOrderViewSegue", sender: nil) // 跳頁
    }
    
    @IBSegueAction func toDrinkOrderSegue(_ coder: NSCoder) -> DrinkOrderViewController? {
        return DrinkOrderViewController(coder: coder,data: drinkMessage)
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


