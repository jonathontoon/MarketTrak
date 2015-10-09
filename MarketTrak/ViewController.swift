//
//  ViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna

class ViewController: UIViewController, MTSteamMarketCommunicatorDelegate {

    var marketCommunicator: MTSteamMarketCommunicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        
        marketCommunicator.getResultsForSearch(
            MTSearch(
                query: "silver",
                type: Type.Pistol
            )
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!) {
        dump(searchResults)
    }
}

