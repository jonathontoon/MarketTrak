//
//  MTItemViewController.swift
//  
//
//  Created by Jonathon Toon on 10/11/15.
//
//

import UIKit

class MTItemViewController: UIViewController, MTSteamMarketCommunicatorDelegate {

    var marketCommunicator: MTSteamMarketCommunicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.redColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func largeItemResultReturnedSuccessfully(largeItemResult: MTLargeItem!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

}
