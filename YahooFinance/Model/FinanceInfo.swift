//
//  FinanceInfo.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 12/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import Foundation
import SwiftyJSON

class FinanceInfo
{
    private var _data:JSON
    
    init(data:JSON)
    {
        _data = data
    }
    
    func getData(key:String = "") -> String
    {
        return self._data[key].stringValue
    }
    
    func getJSONData(_ key: String = "") -> JSON
    {
        return self._data[key]
    }
}
