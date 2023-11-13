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
    
}

//MARK: Class Definition
class HomeTableController: NSObject{
    
    //MARK: Atributes
    weak var delegate: HomeTableControllerDelegate?
    var remedyList: [Remedy]
    
    //MARK: Initializer
    init(delegate: HomeTableControllerDelegate?, remedyList: [Remedy]) {
        self.delegate = delegate
        self.remedyList = remedyList
    }
    
    //MARK: TableView setUp
    func setUpRemedyTableView(tableView: UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RemedyTableViewCell.identifier, bundle: nil),
                                  forCellReuseIdentifier: RemedyTableViewCell.identifier)
        tableView.register(UINib(nibName: NewRemedyTableViewCell.identifier, bundle: nil),
                                  forCellReuseIdentifier: NewRemedyTableViewCell.identifier)
    }
}

//MARK: UITableViewDataSource
extension HomeTableController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if remedyList.count < 5 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return remedyList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let remedyCell = tableView.dequeueReusableCell(withIdentifier: RemedyTableViewCell.identifier) as? RemedyTableViewCell else {
            fatalError()
        }
        
        remedyCell.configureRemedyTableViewCell()
        
        
        
        print("teste")
        
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
