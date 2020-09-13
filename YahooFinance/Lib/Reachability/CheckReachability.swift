//
//  CheckReachability.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 12/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation

class CheckReachability
{
    static let sharedInstance = CheckReachability()
    
    func isConnectedToNetwork() -> Bool
    {
        let status = Reach().connectionStatus()
        var isConnected: Bool = false
        switch status
        {
            case .unknown, .offline:
                isConnected = false
                break
            case .online(.wwan):
                isConnected = true
                break
            case .online(.wiFi):
                isConnected = true
                break
        }
        return isConnected
    }
    
}
