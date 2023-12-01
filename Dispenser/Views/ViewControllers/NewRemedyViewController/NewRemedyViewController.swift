//
//  NewRemedyViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import UIKit

protocol NewRemedyDetailsViewControllerDelegate: AnyObject {
    func cancelButtonDidTapped(_: NewRemedyViewController)
    func saveButtonDidTapped(_: NewRemedyViewController, _ newRemedy: Remedy)
}

class NewRemedyViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var remedyNameTextField: UITextField!
    @IBOutlet weak var dosesFrequencyTextField: UITextField!
    @IBOutlet weak var amountPerDoseTextField: UITextField!
    @IBOutlet weak var lastDoseTextField: UITextField!
    @IBOutlet weak var remainingDosesTextField: UILabel!
    @IBOutlet weak var remedyNotesTextField: UITextField!
    
    //MARK: Proprieties
    var delegate: NewRemedyDetailsViewControllerDelegate?
    
    //MARK: Initializer
    class func instantiate(delegate: NewRemedyDetailsViewControllerDelegate) -> NewRemedyViewController {
        let newRemedyViewController = NewRemedyViewController(nibName: String(describing: self), bundle: nil)
        newRemedyViewController.delegate = delegate
        return newRemedyViewController
    }
    
    //MARK: IBActions
    @IBAction func saveNewRemedy(_ sender: Any) {
        
        let remedyName = remedyNameTextField.text ?? ""
        let dosesFrequecy = dosesFrequencyTextField.text ?? ""
        let amountPerDose = amountPerDoseTextField.text ?? ""
        let lastDose = lastDoseTextField.text ?? ""
        let remainingDoses = remainingDosesTextField.text ?? ""
        let remedyNotes = remedyNotesTextField.text ?? ""
        
        var newRemedy = Remedy(name: remedyName,
                               dosesFrequecy: Int(dosesFrequecy) ?? 1,
                               amountPerDose: Int(amountPerDose) ?? 1,
                               lastDose: Time.stringToTime(time: lastDose),
                               remainingDoses: Int(remainingDoses) ?? 1,
                               remedyNotes: remedyNotes)
        
        delegate?.saveButtonDidTapped(self, newRemedy)
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.cancelButtonDidTapped(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
