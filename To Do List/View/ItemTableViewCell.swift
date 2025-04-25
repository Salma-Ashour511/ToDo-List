//
//  ItemTableViewCell.swift
//  To Do List
//
//  Created by V17SAshour1 on 26/04/2025.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    var itemDone = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //checkmark.circle.fill
    //xmark.circle.fill
    @IBAction func checkmarkButtonPressed(_ sender: UIButton) {
        itemDone = !itemDone
        if itemDone {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
}
