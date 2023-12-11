//
//  MainCoordinator.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import Foundation
import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    
}

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]?
    var delegate: MainCoordinatorDelegate?
    
    init(navigationController: UINavigationController? = nil, parentCoordinator: Coordinator? = nil, childCoordinators: [Coordinator]? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        let notificationManager = NotificationManager()
        notificationManager.askPermition()
        //MainManager.testAPI()
        MainManager.fetchDataFromInternalStorage()
        MainManager.fetchDataFromExternalDB()
        let homeViewController = HomeViewController.instantiate(delegate: self)
        homeViewController.configureHomeViewController(delegate: self)
        navigationController?.setViewControllers([homeViewController], animated: false)
    }
    
    func eventOcurred(with type: Action, remedy: Remedy? = nil, index: Int? = nil) {
        
        guard let homeVC = navigationController?.viewControllers.first as? HomeViewController else {
            fatalError()
        }
        
        switch type {
        case .addNewRemedyScreen:
            let newRemedyViewController = NewRemedyViewController.instantiate(delegate: self)
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(newRemedyViewController, animated: true)
        case .editExistingRemedyScreen:
            guard let remedy = remedy else { return }
            let editRemedyViewController = EditRemedyViewController.instantiate(delegate: self, remedy: remedy)
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(editRemedyViewController, animated: true)
        case .seeExistingRemedyScreen:
            homeVC.refreshTableView(command: .edit)
            guard let remedy = remedy else { return }
            let remedyDetailsScreen = RemedyDetailsViewController.instantiate(delegate: self, remedy: remedy)
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(remedyDetailsScreen, animated: true)
        case .saveNewRemedyButtonDidTapped:
            homeVC.refreshTableView(command: .add)
            navigationController?.popViewController(animated: true)
        case .saveChangesToExistingRemedy:
            homeVC.refreshTableView(command: .edit)
            navigationController?.popViewController(animated: false)
            navigationController?.popViewController(animated: true)
        case .deleteRemedyButtonDidTapped:
            guard let remedy = remedy else { return }
            guard let index = index else { return }
            homeVC.refreshTableView(command: .delete, remedy: remedy, index: index)
            navigationController?.popViewController(animated: false)
            navigationController?.popViewController(animated: true)
        case .cancelButtonDidTapped:
            navigationController?.popViewController(animated: true)
        case .refresh:
            homeVC.refreshTableView(command: .edit)
        }
    }
    
    func end() {
        
    }
}

extension MainCoordinator: HomeViewControllerDelegate {
    
    func refreshPageTapped(_: HomeViewController) {
        MainManager.fetchDataFromExternalDB()
        //self.eventOcurred(with: .refresh)
    }
    
    func remedyCellDidTapped(_: HomeViewController, remedy: Remedy) {
        self.eventOcurred(with: .seeExistingRemedyScreen, remedy: remedy)
    }
    
    func addNewRemedyButtonDidTap(_: HomeViewController) {
        self.eventOcurred(with: .addNewRemedyScreen)
        // Modal informando que nao tem espaco
    }
}

extension MainCoordinator: NewRemedyDetailsViewControllerDelegate {
    func saveButtonDidTapped(_: NewRemedyViewController, _ newRemedy: Remedy) {
        MainManager.saveRemedy(newRemedy: newRemedy)
        self.eventOcurred(with: .saveNewRemedyButtonDidTapped)
    }
    
    func cancelButtonDidTapped(_: NewRemedyViewController) {
        self.eventOcurred(with: .cancelButtonDidTapped)
    }
}

extension MainCoordinator: RemedyDetailsViewControllerDelegate {
    
    func backButtonDidTap(_: RemedyDetailsViewController) {
        self.eventOcurred(with: .cancelButtonDidTapped)
    }
    
    func editRemedyButtonDidTap(_: RemedyDetailsViewController, remedy: Remedy) {
        self.eventOcurred(with: .editExistingRemedyScreen, remedy: remedy)
    }
}

extension MainCoordinator: EditRemedyViewControllerDelegate {
    
    func deleteButtonDidTap(_: EditRemedyViewController, remedy: Remedy) {
        let index = MainManager.deleteRemedy(remedy: remedy)
        self.eventOcurred(with: .deleteRemedyButtonDidTapped, remedy: remedy, index: index)
    }
    
    func saveChangesButtonDidTap(_: EditRemedyViewController, data: (Remedy?, Int?)) {
        MainManager.editRemedy(data: data)
        self.eventOcurred(with: .saveChangesToExistingRemedy)
    }
    
    func cancelButtonDidTap(_: EditRemedyViewController) {
        self.eventOcurred(with: .cancelButtonDidTapped)
    }
}
