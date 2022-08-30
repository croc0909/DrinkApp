//
//  FrontPageViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/24.
//

import UIKit

class FrontPageViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    var activityImages = ["活動1","活動2","活動3","活動4","活動5"]
    
    @IBOutlet weak var ActivityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView(){
        ActivityTableView.delegate = self
        ActivityTableView.dataSource = self
        ActivityTableView.showsVerticalScrollIndicator = false // 不顯示垂直拉條
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell", for: indexPath) as! ActivityTableViewCell
        
        cell.activityImageView.image = UIImage(named: activityImages[indexPath.row])
        
        return cell
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
