//
//  RemedyDetailsViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import UIKit

protocol RemedyDetailsViewControllerDelegate: AnyObject {
    func backButtonDidTap(_: RemedyDetailsViewController)
    func editRemedyButtonDidTap(_: RemedyDetailsViewController, remedy: Remedy)
}

class RemedyDetailsViewController: UIViewController {
    
    //MARK: Proprieties
    var delegate: RemedyDetailsViewControllerDelegate?
    var remedy: Remedy?
    
    //MARK: IBOutlets
    
    @IBOutlet weak var remedyNameLabel: UILabel!
    @IBOutlet weak var remedyfrequencyLabel: UILabel!
    @IBOutlet weak var remedyAmoutPerDoseLabel: UILabel!
    @IBOutlet weak var remedyLastDoseLabel: UILabel!
    @IBOutlet weak var remedyAvailableDosesLabel: UILabel!
    @IBOutlet weak var remedyNotesLabel: UILabel!
    @IBOutlet weak var remedyTubeLabel: UILabel!
    
    class func instantiate(delegate: RemedyDetailsViewControllerDelegate, remedy: Remedy) -> RemedyDetailsViewController {
        let remedyDetailsViewController = RemedyDetailsViewController(nibName: String(describing: self), bundle: nil)
        remedyDetailsViewController.delegate = delegate
        remedyDetailsViewController.remedy = remedy
        return remedyDetailsViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutConfig()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Layout Config
    func layoutConfig(){
        guard let remedy = self.remedy else { return }
        remedyNameLabel.text = remedy.name
        remedyfrequencyLabel.text = String(remedy.dosesHoursInterval)
        remedyAmoutPerDoseLabel.text = String(remedy.amountPerDose)
        remedyLastDoseLabel.text = remedy.dateToString(date: remedy.lastDose)
        remedyAvailableDosesLabel.text = String(remedy.remainingDoses)
        remedyNotesLabel.text = remedy.remedyNotes
        remedyTubeLabel.text = String(remedy.tube)
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        delegate?.backButtonDidTap(self)
    }
    
    @IBAction func editRemedyButtonPress(_ sender: Any) {
        guard let remedy = self.remedy else { return }
        delegate?.editRemedyButtonDidTap(self, remedy: remedy)
    }
    

}
