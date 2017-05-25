//
//  ListPlaceViewController.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import UIKit



let cellIdentifier = "PlaceViewCell"
class ListPlaceViewController: BaseViewController {
    @IBOutlet weak var listPlacesTable: UITableView!
    
    
    override func setupUI() {
        title = "List"
        listPlacesTable.delegate = self
        listPlacesTable.dataSource = self
        
        listPlacesTable.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listPlacesTable.reloadData()
    }
}

extension ListPlaceViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoordinatorManager.shared.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PlaceViewCell
        let place = CoordinatorManager.shared.places[indexPath.row]
        cell.setBarItem(bar: place)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
