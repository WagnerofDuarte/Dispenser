//
//  HomeViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import UIKit

//MARK: HomeViewControllerDelegate
protocol HomeViewControllerDelegate: AnyObject {
    
}

//MARK: Class Definition
class HomeViewController: UIViewController {
    
    //MARK: Atributtes
    var delegate: HomeViewControllerDelegate?
    var tableController: HomeTableController?
    var remedyList: [Remedy]?
    
    //MARK: IBOutlets
    @IBOutlet weak var remedyListTableView: UITableView!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableController?.setUpRemedyTableView(tableView: remedyListTableView)
    }
    
    //MARK: View Config
    func configureHomeViewController(delegate: HomeViewControllerDelegate?){
        self.delegate = delegate
        self.tableController = HomeTableController(delegate: self, remedyList: [])
    }
    
}

//MARK: HomeTableControllerDelegate
extension HomeViewController: HomeTableControllerDelegate {
    
}
