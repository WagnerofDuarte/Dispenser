//
//  RemedyDetailsViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import UIKit

protocol RemedyDetailsViewControllerDelegate: AnyObject {
    
}

class RemedyDetailsViewController: UIViewController {
    
    var delegate: RemedyDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
