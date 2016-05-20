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
        return UIColor.backgroundColor()
    }

    class func tabBarColor() -> UIColor {
        return UIColor.backgroundColor()
    }
    
    class func backgroundColor() -> UIColor {
        return UIColor(rgba: "#1F2326") //UIColor.navigationBarColor()
    }
    
    class func searchResultCellColor() -> UIColor {
        return UIColor(rgba: "#252B2E")
    }
    
    class func tableViewCellHighlightedColor() -> UIColor {
        return UIColor(rgba: "#0F1214")
    }
    
    class func tableViewSeparatorColor() -> UIColor {
        return UIColor.blackColor().colorWithAlphaComponent(0.2)
    }
    
    class func priceTintColor() -> UIColor {
        return UIColor(rgba: "#76C93B")
    }
    
    class func appTintColor() -> UIColor {
        return UIColor(rgba: "#0CA0F0")
    }
    
    class func appTintColorSelected() -> UIColor {
        return UIColor(rgba: "#075C8A")
    }
    
    class func metaTextColor() -> UIColor {
        return UIColor(rgba: "#A9AAAF")
    }
    
    class func rowActionShareButtonColor() -> UIColor {
        return UIColor.appTintColor()
    }
    
    class func searchBarPlaceholderColor() -> UIColor {
        return UIColor.appTintColor()
    }
    
    // Item Category Colors
    
    class func normalItemColor() -> UIColor {
        return UIColor(rgba: "#B2B2B2")
    }
    
    class func statTrak™ItemColor() -> UIColor {
        return UIColor(rgba: "#F07734")
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
        return UIColor(rgba: "#5E98D9")
    }
    
    class func restrictedItemColor() -> UIColor {
        return UIColor(rgba: "#A06CFF")
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
