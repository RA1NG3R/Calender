//
//  EventTableViewCell.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEvent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
