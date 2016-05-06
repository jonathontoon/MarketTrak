//
//  MTFilterCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 12/4/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTFilterCell: UITableViewCell {
    
    //var topSeparator: UIView!
    var separator: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.searchResultCellColor()
        
        textLabel?.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)
        textLabel?.textColor = UIColor.whiteColor()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCellForFilter(dataSource: MTFilterDataSource!, indexPath: NSIndexPath!, resultCount: Int!) {
        
        //textLabel?.text = dataSource.filterOptionForSection(indexPath.section, row: indexPath.row).name
        
        accessoryType = .None
      
        backgroundColor = UIColor.searchResultCellColor()
        selectionStyle = UITableViewCellSelectionStyle.None
        
//        if indexPath.row == 0 {
//            
//            topSeparator = UIView(frame: CGRectMake(indexPath.row < resultCount-1 ? 15.0 : 0.0, (1.0 / UIScreen.mainScreen().scale), frame.size.width, 1.0 / UIScreen.mainScreen().scale))
//            topSeparator.backgroundColor = UIColor.tableViewSeparatorColor()
//            addSubview(topSeparator)
//            
//        }
        
        if indexPath.row != resultCount-1 {
            
            separator = UIView(frame: CGRectMake(indexPath.row < resultCount-1 ? 15.0 : 0.0, frame.size.height - (1.0 / UIScreen.mainScreen().scale), frame.size.width, 1.0 / UIScreen.mainScreen().scale))
            separator.backgroundColor = UIColor.tableViewSeparatorColor()
            addSubview(separator)
            
        }
    }
    
}
