//
//  TaskListTVCell.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import UIKit

class TaskListTVCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI(modelData: IncompleteTaskListModelData){
        addressLabel.text = modelData.address
        roleLabel.text = modelData.role_name
        propertyNameLabel.text = modelData.propertyname
        taskNameLabel.text = "\(modelData.unit ?? "") • \(modelData.taskname ?? "")"//1-A • Task-New QA 1
        
        
        
        
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
    }
}
