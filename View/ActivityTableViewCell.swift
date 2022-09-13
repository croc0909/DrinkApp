//
//  ActivityTableViewCell.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/8/24.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var activityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
