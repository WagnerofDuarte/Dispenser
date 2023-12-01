//
//  EditRemedyViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 29/11/23.
//

import UIKit

protocol EditRemedyViewControllerDelegate: AnyObject {
    func saveChangesButtonDidTap(_: EditRemedyViewController)
    func cancelButtonDidTap(_: EditRemedyViewController)
    func deleteButtonDidTap(_: EditRemedyViewController, index: Int)
}

class EditRemedyViewController: UIViewController {
    
    var delegate: EditRemedyViewControllerDelegate?
    
    class func instantiate(delegate: EditRemedyViewControllerDelegate) -> EditRemedyViewController {
        let editRemedyViewController = EditRemedyViewController(nibName: String(describing: self), bundle: nil)
        editRemedyViewController.delegate = delegate
        return editRemedyViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveChangesToRemedyButtonPressed(_ sender: UIButton) {
        delegate?.saveChangesButtonDidTap(self)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.cancelButtonDidTap(self)
    }
    
    @IBAction func deleteRemedyButtonPressed(_ sender: UIButton) {
        //delegate?.deleteButtonDidTap(self)
    }
    
}
