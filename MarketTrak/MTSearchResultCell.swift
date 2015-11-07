//
//  MTSearchResultCell.swift
//  
//
//  Created by Jonathon Toon on 10/10/15.
//
//

import UIKit
import SDWebImage
import MGSwipeTableCell

class MTSearchResultCell: MGSwipeTableCell {

    var imageOperation: SDWebImageOperation?
    
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
    
    var topSeparator: UIView!
    var separator: UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageOperation?.cancel()
        imageOperation = nil
        
        itemImageView.removeFromSuperview()
        itemImageView = nil
        itemPriceLabel.removeFromSuperview()
        itemPriceLabel = nil
        itemNameLabel.removeFromSuperview()
        itemNameLabel = nil
        itemMetaLabel.removeFromSuperview()
        itemMetaLabel = nil
        
        if itemCategoryLabel != nil {
            itemCategoryLabel.removeFromSuperview()
            itemCategoryLabel = nil
        }

        if itemQualityLabel != nil {
            itemQualityLabel.removeFromSuperview()
            itemQualityLabel = nil
        }

        if topSeparator != nil {
            topSeparator.removeFromSuperview()
            topSeparator = nil
        }
        
        if separator != nil {
            separator.removeFromSuperview()
            separator = nil
        }
    }
}
