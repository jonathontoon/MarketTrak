//
//  MTSearchQuery.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearch {

    var filterCategories    : [MTFilterCategory]!
    var start      : Int!
    var count      : Int!
    var baseURL    : String = "https://steamcommunity.com/market/search/render?"
    var searchURL  : String = ""
    
    init(
        filterCategories : [MTFilterCategory] = [],
        start: Int = 0,
        count: Int = 100
    ) {
        self.filterCategories = filterCategories
        self.start = start
        self.count = count
        
        constructSearchURL()
    }
    
    func constructSearchURL() {
   
        searchURL = baseURL
        
        for i in 0..<filterCategories.count {
            
            let filterCategory = filterCategories[i]
            
            if filterCategory.name == "Keyword" {
                
                searchURL += filterCategory.category! + "=" + filterCategory.options![0].tag
                
            } else {
                
                if filterCategory.options!.count == 0 {
                    searchURL += "&"+filterCategory.category!+"=any"
                } else {
                    for filterOption in filterCategory.options! {
                        searchURL += "&"+filterCategory.category!+"="+filterOption.tag
                    }
                }
            }
        }

            searchURL += "&start="+start.description
            searchURL += "&count="+count.description
            searchURL += "&appid=730&language=english"
            searchURL = searchURL.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            searchURL = searchURL.stringByReplacingOccurrencesOfString("[]", withString: "%5B%5D")
    }
}
