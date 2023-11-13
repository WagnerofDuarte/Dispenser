//
//  NewRemedyViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import UIKit

protocol NewRemedyDetailsViewControllerDelegate: AnyObject {
    
}

class NewRemedyViewController: UIViewController {
    
    var delegate: NewRemedyDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
