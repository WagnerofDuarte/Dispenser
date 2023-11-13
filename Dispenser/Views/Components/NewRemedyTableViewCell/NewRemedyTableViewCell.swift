//
//  NewRemedyTableViewCell.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import UIKit

class NewRemedyTableViewCell: UITableViewCell {
    
    static let identifier = UsefulStrings.newRemedyTableViewCellidentifier
    static func nib() -> UINib {
        return UINib(nibName: UsefulStrings.newRemedyTableViewCellidentifier,
                     bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
