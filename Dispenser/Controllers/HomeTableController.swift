//
//  HomeTableController.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import Foundation
import UIKit

//MARK: HomeTableControllerDelegate
protocol HomeTableControllerDelegate: AnyObject {
    func remedyCellDidTapped(_: HomeTableController, index: Int)
}

//MARK: Class Definition
class HomeTableController: NSObject{
    
    //MARK: Atributes
    weak var delegate: HomeTableControllerDelegate?
    
    //MARK: Initializer
    init(delegate: HomeTableControllerDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: TableView setUp
    func setUpRemedyTableView(tableView: UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RemedyTableViewCell.identifier, bundle: nil),
                                  forCellReuseIdentifier: RemedyTableViewCell.identifier)
    }
    
}

//MARK: UITableViewDataSource
extension HomeTableController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remedyMock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let remedyCell = tableView.dequeueReusableCell(withIdentifier: RemedyTableViewCell.identifier) as? RemedyTableViewCell else {
                fatalError()
        }
        remedyCell.configureRemedyTableViewCell(delegate: self, remedy: remedyMock[indexPath.row], index: indexPath.row)
        return remedyCell
    }
    
}

//MARK: UITableViewDelegate
extension HomeTableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Criar um header
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Verificar tamanho ideal
        return 0
    }

}

extension HomeTableController: RemedyTableViewCellDelegate {
    func remedyCellDidTapped(_: RemedyTableViewCell, index: Int) {
        delegate?.remedyCellDidTapped(self, index: index)
    }
}
