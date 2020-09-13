//
//  ServerConnection.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 12/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerConnection
{
    init() {}
    
    func startByGet(_ url:String, parameters:[String:Any], completeHandler:@escaping (String, JSON, NSError?)->())
    {
        if CheckReachability.sharedInstance.isConnectedToNetwork() == true
        {
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                switch response.result
                {
                    case .success:
                        let json = JSON(response.value!)
                        completeHandler("true", json, nil)
                    case let .failure(error):
                        print("AF Error : \(error)")
                }
            }
        }
        else
        {
            completeHandler("false", JSON.null, nil)
        }
    }
    
}
