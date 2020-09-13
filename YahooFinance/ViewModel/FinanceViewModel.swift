//
//  FinanceViewModel.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 12/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FinanceViewModel
{
    var financeInfoLists = [FinanceInfo]()
    var data: JSON
    
    init()
    {
        data = []
    }
    
    func loadFinaceList(_ parameters: [String : Any], urlString: String, _ completeHandler: @escaping(String, String, String) -> ()) -> Void
    {
        let connection = ServerConnection.init()
        connection.startByGet(urlString , parameters: parameters) { (networkStatus, response, error) in
            if networkStatus == "false"
            {
                completeHandler("false", "", "")
            }
            else
            {
                if error != nil
                {
                    let httpError: NSError = error!
                    completeHandler("true", "-1", httpError.localizedDescription)
                    return
                }
                else
                {
                    if response["quoteResponse"]["result"].count > 0
                    {
                        self.populateData(data: response["quoteResponse"]["result"])
                        completeHandler("true", "1", "")
                        return
                    }
                    else
                    {
                        let error: String = "Oops! Something went wrong."
                        completeHandler("true", "0", error)
                        return
                    }
                }
            }
        }
    }
    
    func populateData(data: JSON)
    {
        for (_,value):(String, JSON) in data
        {
            let obj = FinanceInfo(data: value)
            self.financeInfoLists.append(obj)
        }
    }
    
    func getFinanceList(_ index: Int) -> FinanceInfo
    {
        return self.financeInfoLists[index]
    }
    
    func getTotalNumberOfInformations() -> Int
    {
        return self.financeInfoLists.count
    }
    
    func getAllFinanceObjectsArray() -> [FinanceInfo]
    {
        return self.financeInfoLists
    }
    
    func clearAllData()
    {
        self.financeInfoLists.removeAll()
    }
}

