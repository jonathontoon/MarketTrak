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

extension String {
    
    init(unescapeSpecialCharacters: String!) {
        self = unescapeSpecialCharacters.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
}

class ViewController: UIViewController {

    let marketCommunicator: SteamMarketCommunicator = SteamMarketCommunicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = MTSearch(
            query: "Fade",
            category: .StatTrak™
        )
        
        marketCommunicator.searchMarketPlace(search)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

