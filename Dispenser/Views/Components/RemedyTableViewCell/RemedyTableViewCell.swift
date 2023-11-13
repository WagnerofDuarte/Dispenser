//
//  RemedyTableViewCell.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import UIKit

class RemedyTableViewCell: UITableViewCell {
    
    static let identifier = UsefulStrings.remedyTableViewCellidentifier
    static func nib() -> UINib {
        return UINib(nibName: UsefulStrings.remedyTableViewCellidentifier,
                     bundle: nil)
    }
    
    func configureRemedyTableViewCell() {
        
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
