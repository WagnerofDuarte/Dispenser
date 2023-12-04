//
//  EditRemedyViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 29/11/23.
//

import UIKit

protocol EditRemedyViewControllerDelegate: AnyObject {
    func saveChangesButtonDidTap(_: EditRemedyViewController, data: (Remedy?, Int?))
    func cancelButtonDidTap(_: EditRemedyViewController)
    func deleteButtonDidTap(_: EditRemedyViewController, index: Int)
}

class EditRemedyViewController: UIViewController {
    
    @IBOutlet weak var remedyNameTextField: UITextField!
    @IBOutlet weak var remedyFrequencyTextField: UITextField!
    @IBOutlet weak var remedyAmoutPerDoseTextField: UITextField!
    @IBOutlet weak var remedyLastDoseTextField: UITextField!
    @IBOutlet weak var remedyAvailableDosesTextField: UITextField!
    @IBOutlet weak var remedyNotesTextField: UITextField!
    
    
    var delegate: EditRemedyViewControllerDelegate?
    var remedy: Remedy?
    var index: Int?
    
    class func instantiate(delegate: EditRemedyViewControllerDelegate, index: Int) -> EditRemedyViewController {
        let editRemedyViewController = EditRemedyViewController(nibName: String(describing: self), bundle: nil)
        editRemedyViewController.delegate = delegate
        editRemedyViewController.index = index
        editRemedyViewController.remedy = remedyMock[index]
        return editRemedyViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutConfig()
    }
    
    func layoutConfig(){
        guard let remedy = self.remedy else { return }
        remedyNameTextField.text = remedy.name
        remedyFrequencyTextField.text = String(remedy.dosesFrequecy)
        remedyAmoutPerDoseTextField.text = String(remedy.amountPerDose)
        remedyLastDoseTextField.text = String(remedy.lastDose.timeToString())
        remedyAvailableDosesTextField.text = String(remedy.remainingDoses)
        remedyNotesTextField.text = String(remedy.remedyNotes)
    }
    
    func saveChangesToRemedy() -> (Remedy?, Int?){
        let remedyName = remedyNameTextField.text ?? ""
        let dosesFrequecy = Int(remedyFrequencyTextField.text ?? "") ?? 0
        let amountPerDose = Int(remedyAmoutPerDoseTextField.text ?? "") ?? 0
        let lastDose = Time.stringToTime(time: remedyLastDoseTextField.text ?? "")
        let remainingDoses = Int(remedyAvailableDosesTextField.text ?? "") ?? 0
        let remedyNotes = remedyNotesTextField.text ?? ""
        
        self.remedy?.name = remedyName
        self.remedy?.dosesFrequecy = dosesFrequecy
        self.remedy?.amountPerDose = amountPerDose
        self.remedy?.lastDose = lastDose
        self.remedy?.remainingDoses = remainingDoses
        self.remedy?.remedyNotes = remedyNotes
        
        guard let index = self.index else { return (nil, nil) }
        guard let remedy = self.remedy else { return (nil, nil) }
        
        return (remedy, index)
    }
    
    @IBAction func saveChangesToRemedyButtonPressed(_ sender: UIButton) {
        let savedChanges:(Remedy?, Int?) = saveChangesToRemedy()
        delegate?.saveChangesButtonDidTap(self, data:savedChanges)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.cancelButtonDidTap(self)
    }
    
    @IBAction func deleteRemedyButtonPressed(_ sender: UIButton) {
        delegate?.deleteButtonDidTap(self, index: self.index ?? 0)
    }
    
}
