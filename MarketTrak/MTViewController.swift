//
//  MTViewController.swift
//  Pods
//
//  Created by Jonathon Toon on 4/24/16.
//
//

import UIKit

class MTViewController: UIViewController {
 
    private var loadingOverlay = UIView.newAutoLayoutView()
    private let loadingIndicator = UIImageView.newAutoLayoutView()
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loadingOverlay)
        loadingOverlay.backgroundColor = UIColor.backgroundColor()
        loadingOverlay.alpha = 0
        loadingOverlay.autoPinEdge(.Top, toEdge: .Top, ofView: view)
        loadingOverlay.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        loadingOverlay.autoPinEdge(.Right, toEdge: .Right, ofView: view)
        loadingOverlay.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
        
        loadingOverlay.addSubview(loadingIndicator)
        loadingIndicator.image = UIImage(named: "loading_indicator")?.imageWithRenderingMode(.AlwaysTemplate)
        loadingIndicator.tintColor = .appTintColor()
        loadingIndicator.autoSetDimensionsToSize(CGSizeMake(40, 40))
        loadingIndicator.autoCenterInSuperview()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showLoadingIndicator() {
        view.bringSubviewToFront(loadingOverlay)
        
        loadingIndicator.layer.removeAllAnimations()
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
            rotation.fromValue = NSNumber(float: 0)
            rotation.toValue = NSNumber(float: Float(2 * M_PI))
            rotation.duration = 0.9
            rotation.repeatCount = Float.infinity
        loadingIndicator.layer.addAnimation(rotation, forKey: "spin")
        
        UIView.animateWithDuration(0.25, animations: {
            self.loadingOverlay.alpha = 0.85
        })
    }

    func hideLoadingIndicator() {
        view.sendSubviewToBack(loadingOverlay)
        UIView.animateWithDuration(0.25, animations: {
            self.loadingOverlay.alpha = 0
        })
    }
}
