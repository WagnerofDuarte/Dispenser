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
    func deleteButtonDidTap(_: EditRemedyViewController, remedy: Remedy)
}

class EditRemedyViewController: UIViewController {
    
    @IBOutlet weak var remedyNameTextField: UITextField!
    @IBOutlet weak var remedyFrequencyTextField: UITextField!
    @IBOutlet weak var remedyAmoutPerDoseTextField: UITextField!
    @IBOutlet weak var remedyLastDoseDatePicker: UIDatePicker!
    @IBOutlet weak var remedyAvailableDosesTextField: UITextField!
    @IBOutlet weak var remedyNotesTextField: UITextField!
    
    
    var delegate: EditRemedyViewControllerDelegate?
    var remedy: Remedy?
    
    class func instantiate(delegate: EditRemedyViewControllerDelegate, remedy: Remedy) -> EditRemedyViewController {
        let editRemedyViewController = EditRemedyViewController(nibName: String(describing: self), bundle: nil)
        editRemedyViewController.delegate = delegate
        editRemedyViewController.remedy = remedy
        return editRemedyViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutConfig()
    }
    
    func layoutConfig(){
        guard let remedy = self.remedy else { return }
        remedyNameTextField.text = remedy.name
        remedyFrequencyTextField.text = String(remedy.dosesHoursInterval)
        remedyAmoutPerDoseTextField.text = String(remedy.amountPerDose)
        remedyAvailableDosesTextField.text = String(remedy.remainingDoses)
        remedyNotesTextField.text = String(remedy.remedyNotes)
    }
    
    func saveChangesToRemedy() -> (Remedy?, Int?){
        let remedyName = remedyNameTextField.text ?? ""
        let dosesFrequecy = Int(remedyFrequencyTextField.text ?? "") ?? 0
        let amountPerDose = Int(remedyAmoutPerDoseTextField.text ?? "") ?? 0
        let lastDose = remedyLastDoseDatePicker.date
        let remainingDoses = Int(remedyAvailableDosesTextField.text ?? "") ?? 0
        let remedyNotes = remedyNotesTextField.text ?? ""
        
        self.remedy?.name = remedyName
        self.remedy?.dosesHoursInterval = dosesFrequecy
        self.remedy?.amountPerDose = amountPerDose
        self.remedy?.lastDose = lastDose
        self.remedy?.remainingDoses = remainingDoses
        self.remedy?.remedyNotes = remedyNotes
        self.remedy?.calculateNextDose()
        
        guard let remedy = self.remedy else { return (nil, nil) }
        guard let index = remedyList.firstIndex(where: {$0.id == remedy.id}) else { return (nil, nil) }
                
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
        guard let remedy = self.remedy else { return }
        delegate?.deleteButtonDidTap(self, remedy: remedy)
    }
    
}
