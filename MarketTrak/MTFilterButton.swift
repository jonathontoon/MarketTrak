//
//  MTButton.swift
//  Pods
//
//  Created by Jonathon Toon on 5/4/16.
//
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
