//
//  MTFilterItemsViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/4/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTFilterItemsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Filters"
        view.backgroundColor = UIColor.redColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close_button"), style: .Done, target: self, action: "dismissViewController")
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}