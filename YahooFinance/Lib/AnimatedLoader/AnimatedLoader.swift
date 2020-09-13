//
//  AnimatedLoader.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 13/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class AnimatedLoader:UIViewController, NVActivityIndicatorViewable
{
    static let sharedInstance = AnimatedLoader()
    let animatedLoaderSize = CGSize(width: 30, height: 30)
    
    func showAnimatedLoaer()
    {
        self.startAnimating(self.animatedLoaderSize, message: "Please wait...", messageFont: nil, type: .ballSpinFadeLoader, color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil, fadeInAnimation: nil)
    }
    
    func hideAnimatedLoader()
    {
        self.stopAnimating()
    }
}
