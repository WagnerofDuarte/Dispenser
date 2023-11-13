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
    
    func eventOcurred(with type: Int) {
        
    }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.configureHomeViewController(delegate: self)
        navigationController?.setViewControllers([homeViewController], animated: false)
    }
    
    func end() {
        
    }
}

extension MainCoordinator: HomeViewControllerDelegate {
    
}
