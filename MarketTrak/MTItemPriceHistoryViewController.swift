//
//  MTItemPriceHistoryViewController.swift
//  
//
//  Created by Jonathon Toon on 6/19/16.
//
//

import UIKit

class MTItemPriceHistoryViewController: MTViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerTitleView = UIView(frame: CGRectMake(0, 0, 200, 33))
        self.navigationItem.titleView = containerTitleView
        containerTitleView.sizeToFit()
        
        let titleLabel = UILabel()
        titleLabel.text = "Search Results"
        titleLabel.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(0, -1, containerTitleView.frame.size.width, 17)
        containerTitleView.addSubview(titleLabel)
        
        let subTitleLabel = UILabel()
            subTitleLabel.text = ""
            subTitleLabel.font = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
            subTitleLabel.textColor = UIColor.subTextColor()
            subTitleLabel.textAlignment = .Center
            subTitleLabel.frame = CGRectMake(0, 18, containerTitleView.frame.size.width, 12)
        containerTitleView.addSubview(subTitleLabel)
    }
}
