//
//  FinanceInfoCell.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 12/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func valueUpdated()
}

class FinanceInfoCell: UITableViewCell
{

    @IBOutlet weak var lblStockname: UILabel!
    @IBOutlet weak var lblStockprice: UILabel!
    @IBOutlet weak var btnStockpercentage: UIButton!
    @IBOutlet weak var lblStockfullname: UILabel!
    
    var isChecked = true
    var delegate: CellDelegate!
    var infos = [FinanceInfo]()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func populateCellData(infos: [FinanceInfo], tagValue: Int)
    {
        self.infos = infos
        let info = self.infos[tagValue]
        self.lblStockname.text = info.getData(key: "symbol")
        self.lblStockprice.text = Util.sharedInstance.convertToFloatValue(val: info.getData(key: "regularMarketPrice"))
        self.lblStockfullname.text = info.getData(key: "longName")
        //self.btnStockpercentage.setTitle(Util.sharedInstance.convertToFloatValue(val: info.getData(key: "regularMarketChangePercent")) + "%", for: .normal)
        let regularMarketChangePercent: String = Util.sharedInstance.convertToFloatValue(val: info.getData(key: "regularMarketChangePercent"))
        self.btnStockpercentage.setTitle(regularMarketChangePercent + "%", for: .normal)
        self.btnStockpercentage.tag = tagValue
        
        if Float(Float(regularMarketChangePercent)!) < 0.0
        {
            self.btnStockpercentage.backgroundColor = UIColor(red: 235.0/255.0, green: 15.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
        else
        {
            self.btnStockpercentage.backgroundColor = UIColor(red: 0.0/255.0, green: 135.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        }
        
        self.btnStockpercentage.addTarget(self, action: #selector(toggleValue), for: .touchUpInside)
    }
    
    @objc func toggleValue(sender: UIButton)
    {
        let info = self.infos[sender.tag]
        isChecked = !isChecked
        var stockValue: String = ""
        if isChecked {
            let regularMarketChangePercent: String = Util.sharedInstance.convertToFloatValue(val: info.getData(key: "regularMarketChangePercent"))
            stockValue = regularMarketChangePercent
            sender.setTitle(regularMarketChangePercent + "%", for: .normal)
        } else {
            let regularMarketChange: String = Util.sharedInstance.convertToFloatValue(val: info.getData(key: "regularMarketChange"))
            stockValue = regularMarketChange
            sender.setTitle(regularMarketChange + "$", for: .normal)
        }
        if Float(Float(stockValue)!) < 0.0
        {
            sender.backgroundColor = UIColor(red: 235.0/255.0, green: 15.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
        else
        {
            sender.backgroundColor = UIColor(red: 0.0/255.0, green: 135.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        }
        /*if let buttonTitle = sender.title(for: .normal) {
          print("buttonTitle => \(buttonTitle)")
        }*/
        self.delegate.valueUpdated()
    }
    
}
