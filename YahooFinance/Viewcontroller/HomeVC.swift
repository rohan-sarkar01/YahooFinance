//
//  HomeVC.swift
//  YahooFinance
//
//  Created by Rohan Sarkar on 12/09/20.
//  Copyright © 2020 Rohan Sarkar. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate
{
    @IBOutlet weak var tableview: UITableView!
    var financeViewModel = FinanceViewModel()
    var stockTimer: Timer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initializeNavBar()
        self.tableview.tableFooterView = UIView()
        AnimatedLoader.sharedInstance.showAnimatedLoaer()
        self.loadFinaceList()
    }
    
    func initializeNavBar()
    {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "HeaderNav")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        self.navigationController!.navigationBar.isTranslucent = false
    }
    
    func loadFinaceList()
    {
        self.financeViewModel.clearAllData()
        let params :[String: Any] = [:]
        let urlPath: String = "https://query1.finance.yahoo.com/v7/finance/quote?symbols=API,VZ,AMD,AAPL,FB,AIRT,TCS,MSFT,GOOG"
        self.financeViewModel.loadFinaceList(params, urlString: urlPath) { (networkStatus, success, error) in
            AnimatedLoader.sharedInstance.hideAnimatedLoader()
            if networkStatus == "false"
            {
                self.showAlert(title: "Sorry", message: "Please check your internet connection and try again", tag: "-1", type: "loadFinaceList")
            }
            else
            {
                if success == "1"
                {
                    self.tableview.reloadData()
                    self.stockTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateStockValues), userInfo: nil, repeats: true)
                }
                else
                {
                    print("Something went wrong.")
                }
            }
        }
    }
    
    @objc func updateStockValues()
    {
        self.stockTimer?.invalidate()
        self.loadFinaceList()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.financeViewModel.getTotalNumberOfInformations()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "cell") as! FinanceInfoCell
        cell.populateCellData(infos: self.financeViewModel.getAllFinanceObjectsArray(), tagValue: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func showAlert(title: String, message: String, tag: String, type: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if tag == "-1"
        {
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            if tag == "-1"
            {
                if type == "loadFinaceList"
                {
                    self.loadFinaceList()
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func valueUpdated()
    {
        //print("valueUpdated called")
        //self.tableview.reloadData()
    }

}
