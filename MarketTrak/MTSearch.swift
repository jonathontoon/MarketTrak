//
//  MTSearchQuery.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearch {

    var filters             : [MTFilter]!
    var start               : Int!
    var count               : Int!
    var searchURL           : String = "http://steamcommunity.com/market/search/render?appid=730"
    
    init(
        filters : [MTFilter] = [],
        start: Int = 0,
        count: Int = 1000
    ) {
        self.filters = filters
        self.start = start
        self.count = count
    }
    
    func constructSearchURL() -> String {
        
        dump(filters)
        
        //var index: Int = 0
        //var noFiltersApplied: Bool = false

//        for filter in filters {
//            for option in filter.options! {
//                
//                if option.isApplied == true {
//                    
//                    noFiltersApplied = true
//                    
//                    let isQuery = filter.isKeyword == true ? "=" : "[]="
//                    
//                    var categoryString: String! = "&"+filter.category!+isQuery+option.tag
//                    
//                    if index == 0 {
//                        categoryString = "?"+filter.category!+isQuery+option.tag
//                    }
//            
//                    searchURL += categoryString
//                    index++
//                }
//            }
//        }
//        
//        if filters.count == 0 || !noFiltersApplied {
//            searchURL += "?appid=730"
//        } else {
//            searchURL += "&appid=730"
//        }
            searchURL += "&start="+start.description
            searchURL += "&count="+count.description
            searchURL += "&language=english"
            searchURL = searchURL.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
       return searchURL
    }
}
