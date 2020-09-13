//
//  Util.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 12/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation

class Util
{
    static let sharedInstance = Util()
    
    func convertToFloatValue(val: String) -> String
    {
        var result = val
        //print("result => \(result)")
        if Int(result) != 0
        {
            result = String(format: "%.2f", (result as NSString).floatValue)
        }
        return result
    }
}
