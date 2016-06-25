//
//  MTModalViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 11/7/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTModalViewController: MTViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(MTSettingsViewController.dismissSettingsViewController))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissSettingsViewController() {
   
        dispatch_async(dispatch_get_main_queue(),{
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}
