//
//  MTFilterCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 12/4/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTFilterCell: UITableViewCell {
    
    var separator: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.tableViewCellColor()
        
        textLabel?.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)
        textLabel?.textColor = UIColor.whiteColor()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderFilterCellForDataSource(dataSource: [Any]!, indexPath: NSIndexPath!, resultCount: Int!) {
        
        switch indexPath.section {
            case 0:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Collection>)[indexPath.row] as Collection).stringDescription()
            case 1:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<ProfessionalPlayer>)[indexPath.row] as ProfessionalPlayer).stringDescription()
            case 2:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Team>)[indexPath.row] as Team).stringDescription()
            case 3:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Weapon>)[indexPath.row] as Weapon).stringDescription()
            case 4:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Exterior>)[indexPath.row] as Exterior).stringDescription()
            case 5:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Category>)[indexPath.row] as Category).stringDescription()
            case 6:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Quality>)[indexPath.row] as Quality).stringDescription()
            case 7:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<StickerCollection>)[indexPath.row] as StickerCollection).stringDescription()
            case 8:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<StickerCategory>)[indexPath.row] as StickerCategory).stringDescription()
            case 9:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Tournament>)[indexPath.row] as Tournament).stringDescription()
            case 10:
                textLabel?.text = ((dataSource[indexPath.section] as! Array<Type>)[indexPath.row] as Type).stringDescription()
            default:
                textLabel?.text = ""
        }

        
        if indexPath.row != resultCount-1 {
            
            separator = UIView(frame: CGRectMake(indexPath.row < resultCount-1 ? 15.0 : 0.0, frame.size.height - (1.0 / UIScreen.mainScreen().scale), frame.size.width, 1.0 / UIScreen.mainScreen().scale))
            separator.backgroundColor = UIColor.tableViewSeparatorColor()
            addSubview(separator)
            
        }
    }
    
}
