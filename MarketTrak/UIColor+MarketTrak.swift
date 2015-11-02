//
//  UIColor+MarketTrak.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/31/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

extension UIColor {

    // Main UI Colors
    
    class func navigationBarColor() -> UIColor {
        return UIColor(rgba: "#181A1A")
    }
    
    class func backgroundColor() -> UIColor {
        return UIColor(rgba: "#050302")
    }
    
    class func itemImageViewColor() -> UIColor {
        return UIColor(rgba: "#151717")
    }
    
    class func tableViewCellColor() -> UIColor {
        return UIColor(rgba: "#121414")
    }
    
    class func tableViewCellHighlightedColor() -> UIColor {
        return UIColor(rgba: "#0E0F0F")
    }
    
    class func tableViewSeparatorColor() -> UIColor {
        return UIColor(rgba: "#37373B")
    }
    
    class func greenTintColor() -> UIColor {
        return UIColor(rgba: "#8ac33e")
    }
    
    class func metaTextColor() -> UIColor {
        return UIColor(rgba: "#A9AAAF")
    }
    
    // Item Category Colors
    
    class func normalItemColor() -> UIColor {
        return UIColor(rgba: "#B2B2B2")
    }
    
    class func statTrak™ItemColor() -> UIColor {
        return UIColor(rgba: "#CF6A32")
    }
    
    class func souvenirItemColor() -> UIColor {
        return UIColor(rgba: "#FFD700")
    }
    
    class func starItemColor() -> UIColor {
        return UIColor(rgba: "#8A50AC")
    }
    
    class func starStatTrak™ItemColor() -> UIColor {
        return UIColor.starItemColor()
    }
    
    // Item Exterior Color
    
    class func exteriorItemColor() -> UIColor {
        return UIColor(rgba: "#D2D2D2")
    }
    
    // Item Quality Colors
    
    class func consumerGradeItemColor() -> UIColor {
        return UIColor(rgba: "#B0C3D9")
    }
    
    class func milSpecGradeItemColor() -> UIColor {
        return UIColor(rgba: "#4B69FF")
    }
    
    class func industrialGradeItemColor() -> UIColor {
        return UIColor(rgba: "#8847FF")
    }
    
    class func restrictedItemColor() -> UIColor {
        return UIColor(rgba: "#8847FF")
    }
    
    class func classifiedItemColor() -> UIColor {
        return UIColor(rgba: "#D32CE6")
    }
    
    class func baseGradeItemColor() -> UIColor {
        return UIColor.consumerGradeItemColor()
    }
    
    class func covertItemColor() -> UIColor {
        return UIColor(rgba: "#EB4B4B")
    }
    
    class func highGradeItemColor() -> UIColor {
        return UIColor.milSpecGradeItemColor()
    }
    
    class func exoticItemColor() -> UIColor {
        return UIColor.classifiedItemColor()
    }
    
    class func remarkableItemColor() -> UIColor {
        return UIColor.restrictedItemColor()
    }
    
    class func contrabandItemColor() -> UIColor {
        return UIColor(rgba: "#E4AE39")
    }
}