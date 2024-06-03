//
//  NoEventsTableViewCell.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import UIKit

class NoEventsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var lblNoEvents: UILabel!  // Label to display a message when there are no events
    
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

