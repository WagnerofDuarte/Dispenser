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
        let homeViewController = HomeViewController.instantiate(delegate: self)
        homeViewController.configureHomeViewController(delegate: self)
        navigationController?.setViewControllers([homeViewController], animated: false)
    }
    
    func eventOcurred(with type: Action, index: Int? = nil) {
        
        guard let homeVC = navigationController?.viewControllers.first as? HomeViewController else {
            fatalError()
        }
        
        switch type {
        case .addNewRemedyScreen:
            let newRemedyViewController = NewRemedyViewController.instantiate(delegate: self)
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(newRemedyViewController, animated: true)
        case .editExistingRemedyScreen:
            guard let index = index else { return }
            let editRemedyViewController = EditRemedyViewController.instantiate(delegate: self, index: index)
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(editRemedyViewController, animated: true)
        case .seeExistingRemedyScreen:
            let remedyDetailsScreen = RemedyDetailsViewController.instantiate(delegate: self, index: index ?? 0)
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
            guard let index = index else { return }
            homeVC.refreshTableView(command: .delete, index: index)
            navigationController?.popViewController(animated: false)
            navigationController?.popViewController(animated: true)
        case .cancelButtonDidTapped:
            navigationController?.popViewController(animated: true)
        }
    }
    
    func end() {
        
    }
}

extension MainCoordinator: HomeViewControllerDelegate {
    
    func remedyCellDidTapped(_: HomeViewController, index: Int) {
        self.eventOcurred(with: .seeExistingRemedyScreen, index: index)
    }
    
    func addNewRemedyButtonDidTap(_: HomeViewController) {
        self.eventOcurred(with: .addNewRemedyScreen)
    }
}

extension MainCoordinator: NewRemedyDetailsViewControllerDelegate {
    func saveButtonDidTapped(_: NewRemedyViewController, _ newRemedy: Remedy) {
        RemedyManager.saveRemedy(newRemedy: newRemedy)
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
    
    func editRemedyButtonDidTap(_: RemedyDetailsViewController, index: Int) {
        self.eventOcurred(with: .editExistingRemedyScreen, index: index)
    }
}

extension MainCoordinator: EditRemedyViewControllerDelegate {
    
    func deleteButtonDidTap(_: EditRemedyViewController, index: Int) {
        RemedyManager.deleteRemedy(index: index)
        self.eventOcurred(with: .deleteRemedyButtonDidTapped, index: index)
    }
    
    func saveChangesButtonDidTap(_: EditRemedyViewController, data: (Remedy?, Int?)) {
        RemedyManager.editRemedy(data: data)
        self.eventOcurred(with: .saveChangesToExistingRemedy)
    }
    
    func cancelButtonDidTap(_: EditRemedyViewController) {
        self.eventOcurred(with: .cancelButtonDidTapped)
    }
}
