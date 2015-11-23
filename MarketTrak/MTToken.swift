//
//  MTToken.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 11/23/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import TITokenField

class MTToken: TIToken {
    
    init!(title aTitle: String!, representedObject object: AnyObject!, color aColor: UIColor!) {
        
        super.init(title: aTitle, representedObject: object, font: UIFont.systemFontOfSize(14.0, weight: UIFontWeightRegular))
        
        tintColor = aColor
        textColor = aColor
        highlightedTextColor = textColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
