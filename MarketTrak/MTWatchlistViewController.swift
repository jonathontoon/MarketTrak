//
//  MTWatchlistViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTWatchlistViewController: MTItemListViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSearch = MTSearch()
        //marketCommunicator.getResultsForSearch(currentSearch)
    
        title = nil
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        showLoadingIndicator()
    }
}