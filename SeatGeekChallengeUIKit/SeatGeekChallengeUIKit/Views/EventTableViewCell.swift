//
//  EventTableViewCell.swift
//  SeatGeekChallengeUIKit
//
//  Created by Ronald Joubert on 5/12/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var EventImage: UIImageView!
    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventLocation: UILabel!
    @IBOutlet weak var EventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
