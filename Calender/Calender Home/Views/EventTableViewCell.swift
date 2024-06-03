//
//  EventTableViewCell.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var lblEvent: UILabel!  // Label to display the event summary
    @IBOutlet weak var lblDate: UILabel!   // Label to display the event date and time
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Called when the cell is loaded from the nib file or storyboard
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        // Called when the cell is selected or deselected
    }
}
