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
    private var refreshControl: UIRefreshControl?
    private var isRequesting = false
    
    override func setupUI() {
        title = "List"
        listPlacesTable.delegate = self
        listPlacesTable.dataSource = self
        
        refreshControl = UIRefreshControl()
        listPlacesTable.alwaysBounceVertical = true
        refreshControl?.tintColor = UIColor.blue
        refreshControl?.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        listPlacesTable.addSubview(refreshControl!)
        listPlacesTable.estimatedRowHeight = 170
        listPlacesTable.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func refreshData() {
        startRequestService()
    }
    
    
    override func startRequestService() {
        if !isRequesting {
            isRequesting = true
            //Start request and callback with isRuesting = false to start new request
            if ASLocationManager.shared.isLocationServiceAvailable() {
                if let curLocaiton = CoordinatorManager.shared.currentLocation {
                    let location = Location(lat: curLocaiton.latitude, long: curLocaiton.longitude)
                    APIConnectionManager.shared.getPlacesNear(location: location, type: "bar", radius: 2000, success: { [weak self] places in
                        self?.replaceNewDatas(places: places)
                    })
                }
            } else {
                if let input = CoordinatorManager.shared.currentText {
                    APIConnectionManager.shared.searchPlaces(input: input, success: { [weak self] (places) in
                        self?.replaceNewDatas(places: places)
                    })
                }
            }
        }
    }
    
    private func replaceNewDatas(places: [Place]) {
        Utils.runOnMainThread {
            isRequesting = false
            CoordinatorManager.shared.places = places
            listPlacesTable.reloadData()
            refreshControl?.endRefreshing()
        }
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
        return 170
    }
    
}
