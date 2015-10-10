//
//  MTSearchViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna
import UIColor_Hex_Swift
import SDWebImage

class MTSearchViewController: UIViewController, MTSteamMarketCommunicatorDelegate, UITableViewDelegate, UITableViewDataSource {

    var marketCommunicator: MTSteamMarketCommunicator!
    var searchResultsDataSource: [MTListingItem]!
    
    var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        
        marketCommunicator.getResultsForSearch(
            MTSearch(
                query: "",
                //type: Type.Pistol,
                count: 1000
            )
        )
        
        searchResultsTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.registerClass(MTSearchResultCell.self, forCellReuseIdentifier: "MTSearchResultCell")
        searchResultsTableView.backgroundColor = UIColor(rgba: "#1F1F1F")
        searchResultsTableView.separatorColor = UIColor(rgba: "#303030")
        self.view.addSubview(searchResultsTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MTSteamMarketCommunicatorDelegate
    
    func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!) {
        
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResultsDataSource = searchResults
            self.searchResultsTableView.reloadData()
        })
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MTSearchResultCell = tableView.dequeueReusableCellWithIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
            cell.textLabel?.text = searchResultsDataSource[indexPath.row].name
            cell.textLabel?.textColor = UIColor(rgba: searchResultsDataSource[indexPath.row].textColor!)
        
            cell.imageView!.image = searchResultsDataSource[indexPath.row].imageView.image
        
            cell.backgroundColor = UIColor(rgba: "#171717")
        
        return cell
        
    }
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsDataSource == nil ? 0 : searchResultsDataSource.count
    }
}

