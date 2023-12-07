//
//  RemedyTableViewCell.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import UIKit

protocol RemedyTableViewCellDelegate: AnyObject {
    func remedyCellDidTapped(_: RemedyTableViewCell, remedy: Remedy)
}

class RemedyTableViewCell: UITableViewCell {
    
    //MARK: Proprieties
    weak var delegate: RemedyTableViewCellDelegate?
    var remedy: Remedy?
    
    //MARK: IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var remedyNameLabelView: UILabel!
    @IBOutlet weak var remedyLastDoseLabelView: UILabel!
    @IBOutlet weak var remedyNextDoseTimerLabelView: UILabel!
    
    static let identifier = UsefulStrings.remedyTableViewCellidentifier
    static func nib() -> UINib {
        return UINib(nibName: UsefulStrings.remedyTableViewCellidentifier,
                     bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureRemedyTableViewCell(delegate: RemedyTableViewCellDelegate?, remedy: Remedy, index: Int){
        self.remedy = remedyList[index]
        self.delegate = delegate
        self.remedyNameLabelView.text = remedy.name
        self.remedyLastDoseLabelView.text = remedy.lastDoseToStringAndIntro()
        self.remedyNextDoseTimerLabelView.text = remedy.nextDoseToString()
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellDidTapped(_:))))
    }
    
    @objc func cellDidTapped(_ sender: UITapGestureRecognizer){
        guard let remedy = self.remedy else { return }
        delegate?.remedyCellDidTapped(self, remedy: remedy)
    }
    
}
