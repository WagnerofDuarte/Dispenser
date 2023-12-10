//
//  HomeViewController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.

import UIKit

//MARK: HomeViewControllerDelegate
protocol HomeViewControllerDelegate: AnyObject {
    func addNewRemedyButtonDidTap(_: HomeViewController)
    func refreshPageTapped(_: HomeViewController)
    func remedyCellDidTapped(_: HomeViewController, remedy: Remedy)
}

enum RefreshType{
    case add
    case delete
    case edit
}

//MARK: Class Definition
class HomeViewController: UIViewController {
    
    class func instantiate(delegate: HomeViewControllerDelegate) -> HomeViewController {
        let homeViewController = HomeViewController(nibName: String(describing: self), bundle: nil)
        homeViewController.delegate = delegate
        return homeViewController
    }

    
    //MARK: Atributtes
    var delegate: HomeViewControllerDelegate?
    var tableController: HomeTableController?
    
    //MARK: IBOutlets
    @IBOutlet weak var remedyListTableView: UITableView!
    @IBOutlet weak var addRemedyButton: UIView!
    @IBOutlet weak var titleView: UIView!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableController?.setUpRemedyTableView(tableView: remedyListTableView)
        configureAddRemedyButton()
    }
    
    //MARK: View Config
    func configureHomeViewController(delegate: HomeViewControllerDelegate?){
        self.delegate = delegate
        self.tableController = HomeTableController(delegate: self)
    }
    
    func configureAddRemedyButton(){
        addRemedyButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRemedyButtonPressed(_:))))
        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshPage(_:))))
        
    }
    
    func refreshTableView(command: RefreshType, remedy: Remedy? = nil, index: Int? = nil){
        switch command {
        case .add:
            remedyListTableView.insertRows(at: [IndexPath(row: (remedyList.count - 1),
                                                          section: 0)], with: .none)
        case .delete:
            guard let index = index else { return }
            remedyListTableView.deleteRows(at: [IndexPath(row: index,
                                                          section: 0)], with: .none)
        case .edit:
            remedyListTableView.reloadData()
        }
    }
    
    //MARK: Actions
    @objc func addRemedyButtonPressed(_ sender: UITapGestureRecognizer){
        delegate?.addNewRemedyButtonDidTap(self)
    }
    
    @objc func refreshPage(_ sender: UITapGestureRecognizer){
        delegate?.refreshPageTapped(self)
    }
    
}

//MARK: HomeTableControllerDelegate
extension HomeViewController: HomeTableControllerDelegate {
    func remedyCellDidTapped(_: HomeTableController, remedy: Remedy) {
        delegate?.remedyCellDidTapped(self, remedy: remedy)
    }
}
