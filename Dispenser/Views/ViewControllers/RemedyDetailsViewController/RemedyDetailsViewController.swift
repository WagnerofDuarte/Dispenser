//
//  RemedyDetailsViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import UIKit

protocol RemedyDetailsViewControllerDelegate: AnyObject {
    func backButtonDidTap(_: RemedyDetailsViewController)
    func editRemedyButtonDidTap(_: RemedyDetailsViewController, index: Int)
}

class RemedyDetailsViewController: UIViewController {
    
    //MARK: Proprieties
    var delegate: RemedyDetailsViewControllerDelegate?
    var remedy: Remedy?
    var index: Int?
    
    //MARK: IBOutlets
    
    @IBOutlet weak var remedyNameLabel: UILabel!
    @IBOutlet weak var remedyfrequencyLabel: UILabel!
    @IBOutlet weak var remedyAmoutPerDoseLabel: UILabel!
    @IBOutlet weak var remedyLastDoseLabel: UILabel!
    @IBOutlet weak var remedyAvailableDosesLabel: UILabel!
    @IBOutlet weak var remedyNotesLabel: UILabel!
    
    class func instantiate(delegate: RemedyDetailsViewControllerDelegate, index: Int) -> RemedyDetailsViewController {
        let remedyDetailsViewController = RemedyDetailsViewController(nibName: String(describing: self), bundle: nil)
        remedyDetailsViewController.delegate = delegate
        remedyDetailsViewController.remedy = remedyMock[index]
        remedyDetailsViewController.index = index
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
        remedyfrequencyLabel.text = String(remedy.dosesFrequecy)
        remedyAmoutPerDoseLabel.text = String(remedy.amountPerDose)
        remedyLastDoseLabel.text = remedy.lastDose.timeToString()
        remedyAvailableDosesLabel.text = String(remedy.remainingDoses)
        remedyNotesLabel.text = remedy.remedyNotes
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        delegate?.backButtonDidTap(self)
    }
    
    @IBAction func editRemedyButtonPress(_ sender: Any) {
        delegate?.editRemedyButtonDidTap(self, index: self.index ?? 0)
    }
    

}
