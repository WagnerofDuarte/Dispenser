//
//  Coordinator.swift
//  Dispenser
//
//  Created by Wagner Duarte on 06/11/23.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator]? { get set }
    
    func eventOcurred(with type: Action, index: Int?)
    func start()
    func end()
    
}

enum Action {
    case addNewRemedyScreen
    case editExistingRemedyScreen
    case seeExistingRemedyScreen
    case cancelButtonDidTapped
    case saveNewRemedyButtonDidTapped
    case saveChangesToExistingRemedy
    case deleteRemedyButtonDidTapped
}
