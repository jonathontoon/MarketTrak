//
//  MTItemViewController.swift
//  
//
//  Created by Jonathon Toon on 10/11/15.
//
//

import UIKit

class MTItemViewController: UIViewController {

    var listingItem: MTListingItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.redColor()
        
        dump(listingItem)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
