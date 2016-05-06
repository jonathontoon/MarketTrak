//
//  MTSearchQuery.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearch {

    var filters    : [MTFilter]!
    var start      : Int!
    var count      : Int!
    var searchURL  : String = "http://steamcommunity.com/market/search/render?appid=730"
    
    init(
        filters : [MTFilter] = [],
        start: Int = 0,
        count: Int = 1000
    ) {
        self.filters = filters
        self.start = start
        self.count = count
        
        constructSearchURL()
    }
    
    func constructSearchURL() -> String {
   
        for filter in filters {
            for option in filter.options! {
                searchURL += "&"+filter.category!+"="+option.tag
            }
        }

            searchURL += "&start="+start.description
            searchURL += "&count="+count.description
            searchURL += "&language=english"
            searchURL = searchURL.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
       return searchURL
    }
}
