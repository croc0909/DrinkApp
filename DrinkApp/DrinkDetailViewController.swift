//
//  DrinkDetailViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/24.
//

import UIKit

class DrinkDetailViewController: UIViewController, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    var images = ["每日精選咖啡","冰每日精選咖啡","咖啡密斯朵"]
    var DrinkDetailKeyArray = [String]()
    
    @IBOutlet weak var drinkDetaiTableView: UITableView!
    let featuredCoffeeScrollView: UIScrollView! = nil
    
    var alldrink = DrinkList //讀取飲料
    
    var DrinkDetail = [String : [[String : String]]]()
    var DrinkKeyArray = [String]() //key的陣列
    var Drinks = [[String : String]]()
    
    var imageWidthGap = 5 // scrollView圖片左右間隔
    var imageHeightGap = 5 // Label與 Image 間隔
    var tableCellHeight = 300 //統一 Cell 高度
    var labelHight = 30 // label 高度
    var pickCell = 0 // 被選到的cell
    var pickButton = 0 // 被選到的按鈕
    
    // 初始化
    init?(coder: NSCoder, type: [String : [[String : String]]]) {
        super.init(coder: coder)

        print("init \(type)")
        
        DrinkDetail = type
        self.getData()
    }
    // 初始化失敗時
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        // Do any additional setup after loading the view.
    }
    
    func getData(){
        for key in DrinkDetail.keys {
            print("key \(key)")
            DrinkKeyArray.append(String(key))
            print("DrinkKeyArray \(DrinkKeyArray)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DrinkKeyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkDetaiCell", for: indexPath) as! DrinkDetaiCell
        
        let scrollView = UIScrollView() // 建立一個 scrollView
        let coffeeScrollView = scrollViewInit(scrollView: scrollView, row: indexPath.row)
 
        cell.addSubview(coffeeScrollView)
        
        return cell
    }
    
    func setTableView(){
        drinkDetaiTableView.delegate = self
        drinkDetaiTableView.dataSource = self
        drinkDetaiTableView.rowHeight = CGFloat(tableCellHeight)
    }
    
    func scrollViewInit(scrollView:UIScrollView,row:Int) -> UIScrollView {
        
        if let coffee = DrinkDetail[DrinkKeyArray[row]] {
            Drinks = coffee
        }
        
        scrollView.frame.size.width = self.view.frame.width // 設定 ScrollView 寬度
        scrollView.frame.size.height = CGFloat(tableCellHeight) // 設定  ScrollView 高度
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false // 不顯示垂直顯示條
        scrollView.showsHorizontalScrollIndicator = false // 不顯示水平顯示條
        let ScrollViewContentWidth = (scrollView.frame.size.height * CGFloat(Drinks.count)) + (CGFloat(imageWidthGap) * CGFloat(Drinks.count - 1))
        
        //print("ScrollViewContentWidth \(ScrollViewContentWidth)")
        let ScrollViewContentHeight = scrollView.frame.size.height
        scrollView.contentSize = CGSize(width: ScrollViewContentWidth, height: ScrollViewContentHeight) // 設定 ScrollView 內容寬、高
        //imageScrollView.contentOffset = CGPoint(x: imageScrollView.frame.size.width, y: 0)
        
        //let coffieScroller =  setScrolloView(scrollView: scrollView) // 加入圖片與文字內容
        
        print("INT \(row)")
        
        for i in 0...(Drinks.count - 1){
            // 圖片部分
            let ImageViewX = (scrollView.frame.size.height * CGFloat(i)) + (CGFloat(imageWidthGap) * CGFloat(i))
            
            let ImageViewHeight = scrollView.frame.size.height - (CGFloat(imageHeightGap) + CGFloat(labelHight))
            
            //print("cell 高度 \(scrollView.frame.size.height)")
            //print("圖片高度 \(ImageViewHeight)")
            
            let imageView = UIImageView(frame: CGRect(x:ImageViewX,y:0,width: ImageViewHeight ,height:ImageViewHeight )) // 定義imageView 長寬
            
            var picName: String
            var name = Drinks[i]
            var value = name["drinkName"]
            print("value \(value)")
            print("Drinks Count \(Drinks.count)")
            print("Drinks \(Drinks)")
            
            picName = name["drinkName"] ?? "每日精選咖啡"// 圖片來自陣列資料
            
            imageView.image = UIImage(named: picName) // 圖片名稱
            imageView.contentMode = .scaleAspectFill // 圖片顯示模式
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            imageView.layer.cornerRadius = imageView.frame.size.height/2 // 圓角
            scrollView.addSubview(imageView) // 將圖片加入 ScrollView
            
            //print("圖寬 \(ImageViewHeight)")
            //print("加入圖片 X:\(ImageViewX) Y:\(0)")
            
            // 文字部分
            let labelX = scrollView.frame.size.height * CGFloat(i) + (CGFloat(imageWidthGap) * CGFloat(i))
            let labelY = scrollView.frame.size.height - (CGFloat(imageHeightGap) + CGFloat(labelHight)) + CGFloat(imageHeightGap)
            let labelHeight = labelHight
            let labelWidth = scrollView.frame.size.height - (CGFloat(imageHeightGap) + CGFloat(labelHight))
            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: labelWidth, height: CGFloat(labelHeight)))
            //label.backgroundColor = .blue // 確認排版用
            label.text = picName
            label.textAlignment = .center // 文字置中
            scrollView.addSubview(label)
            //print("字寬 \(labelWidth)")
            //print("加入文字 X:\(labelX) Y:\(labelY)")
            
            // 按鈕部分
            let buttonX = (scrollView.frame.size.height * CGFloat(i)) + (CGFloat(imageWidthGap) * CGFloat(i))
            
            let buttonHight = scrollView.frame.size.height
            
            let button = UIButton(frame: CGRect(x: buttonX, y: 0, width: scrollView.frame.size.height - (CGFloat(imageHeightGap) + CGFloat(labelHight)), height: buttonHight))
            button.backgroundColor = .blue
            button.alpha = 0.5 // 將按鈕設為透明
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            scrollView.addSubview(button)

            //print("圖片寬 \(ImageViewHeight) 圖片高 \(ImageViewHeight)")
            //print("按鈕寬 \(scrollView.frame.size.height - (CGFloat(imageHeightGap) + CGFloat(labelHight))) 按鈕高 \(buttonHight)")
        }
        
        return scrollView // 回傳處理好的陣列
    }
    
    @objc func buttonAction(sender: UIButton!){
        // 判斷 button 來自第幾個cell
        let point = sender.convert(CGPoint.zero, to: drinkDetaiTableView)
        if let indexPath = drinkDetaiTableView.indexPathForRow(at: point) {
            //print("第 \(indexPath.row) cell")
            pickCell = indexPath.row
        }
        
        // 判斷按鈕的位置 在scrollView 是第幾個
        let button = sender.convert(CGPoint.zero, to: sender.superview)
        print(button.x)
        
        for i in 0...(Drinks.count - 1){
            let buttonx = sender.frame.size.height * CGFloat(i) + (CGFloat(imageWidthGap) * CGFloat(i))
            //print("buttonX \(buttonx)")
            if(button.x == buttonx)
            {
                print("是第 \(i) 個按鈕")
                pickButton = i
            }
        }
        
        print("pickCell \(pickCell) pickButton \(pickButton)")
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
