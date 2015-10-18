//
//  MTSearchResultCell.swift
//  
//
//  Created by Jonathon Toon on 10/10/15.
//
//

import UIKit
import SDWebImage

class MTSearchResultCell: UITableViewCell {

    var imageOperation: SDWebImageOperation?
    
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView!.frame = CGRectMake(10.0, 10.0, self.imageView!.frame.size.width + 10.0, self.imageView!.frame.size.height + 10.0)
        self.imageView!.contentMode = UIViewContentMode.Center
        
        self.textLabel!.frame = CGRectMake(self.textLabel!.frame.origin.x + 5.0, self.textLabel!.frame.origin.y, self.textLabel!.frame.size.width, self.textLabel!.frame.size.height)
    }
    
    deinit {
        imageOperation?.cancel()
        imageOperation = nil
        self.imageView?.image = nil
    }
}
