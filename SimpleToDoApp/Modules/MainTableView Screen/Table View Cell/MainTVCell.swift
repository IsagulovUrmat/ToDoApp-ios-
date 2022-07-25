//
//  MainTVCell.swift
//  SimpleToDoApp
//
//  Created by Isagulov urmat on 17/7/22.
//

import UIKit

class MainTVCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var taskView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup(){
        
        mainView.layer.cornerRadius = 22
        mainView.layer.masksToBounds = true
        
        taskView.layer.cornerRadius = 22
        taskView.layer.masksToBounds = true
    }

}
