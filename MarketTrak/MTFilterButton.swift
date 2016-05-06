//
//  MTFilterButton.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/4/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTFilterButton: UIButton {
    
    override var highlighted: Bool {

        didSet {
            if highlighted == true {
                backgroundColor = UIColor.appTintColorSelected()
            } else {
                backgroundColor = UIColor.appTintColor()
            }
        }
    }
    
}
