//
//  VCTransactionDetail.swift
//  ONECard
//
//  Created by Dat Hoang on 25-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCTransactionDetail: UIViewController{
    
    
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    let dateFormatter = DateFormatter()
    var filter:Transaction.Filter = Transaction.Filter()
    var transactionList:[Transaction.TransactionDetail] = [Transaction.TransactionDetail]()
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var AILoadTransactionList: UIActivityIndicatorView!
    @IBOutlet weak var IVSeparateLine: UIImageView!
    @IBOutlet weak var LBLDateRange: UILabel!
    @IBOutlet weak var LBLTotalExpense: UILabel!
    @IBOutlet weak var LBLTotalDeposit: UILabel!
    @IBOutlet weak var TVTransactionList: UITableView!

    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func LoadTransactionList(){
        //Request transaction list
        transactionList.removeAll()
        transactionList =  Transaction.GetTransactionWithFilter(filter: filter)
        
        //Sort base on date. Newest first
        transactionList = transactionList.sorted(by: { $0.date > $1.date })

        //Finish setup information banner
        let (totalDeposit, totalExpense) = CalculateTotalAmount()
        LBLTotalDeposit.text = "$" + String(format: "%.2f", totalDeposit)
        LBLTotalExpense.text = "$" + String(format: "%.2f", totalExpense)
        TVTransactionList.reloadData()

        AILoadTransactionList.stopAnimating()
    }
    
    func CalculateTotalAmount()-> (totalDeposit: Float, totalExpense:Float){
        var totalDeposit = Float(0.00)
        var totalExpense = Float(0.00)
        
        for transaction in transactionList {
            if (transaction.amount >= 0){
                totalDeposit += transaction.amount
            }else{
                totalExpense += transaction.amount
            }
        }
        
        //Make total expense possitive
        if(totalExpense < 0){
            totalExpense = totalExpense * -1
        }
        return (totalDeposit, totalExpense)
    }
    
    func DisplayDateRange(){
        LBLDateRange.text = dateFormatter.string(from:filter.fromDate)
                            + " - "
                            + dateFormatter.string(from:filter.toDate)
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "MMMM dd, YYYY"
        
        //Get user ID from UserDefault
        filter.userId = DataHelper.GetIntFromUserDefault(key: "UserId")
        
        //Design IVGreyBackgroundTop
        self.IVSeparateLine.layer.masksToBounds = false
        self.IVSeparateLine.layer.shadowColor = UIColor.lightGray.cgColor
        self.IVSeparateLine.layer.shadowOpacity = 0.8
        self.IVSeparateLine.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.IVSeparateLine.layer.shadowRadius = 2
        
        //Setup information banner
        DisplayDateRange()
        LBLTotalDeposit.text = ""
        LBLTotalExpense.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LoadTransactionList()
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////
extension VCTransactionDetail:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransactionTableViewCell
        
        cell.LBLDescription.text = transactionList[indexPath.row].transDescription
        cell.LBLDate.text = transactionList[indexPath.row].date
        
        //Check for Deposit/Expense
        if (transactionList[indexPath.row].amount < 0){
            cell.LBLAmount.text = String(format: "-$%.02f", transactionList[indexPath.row].amount * -1)
        }else {
            cell.LBLAmount.text = String(format: "+$%.02f", transactionList[indexPath.row].amount)
            cell.LBLAmount.font = UIFont.boldSystemFont(ofSize: cell.LBLAmount.font.pointSize)
        }
        
        //Check for Condor Cash/Print Credit
        if (transactionList[indexPath.row].transactionType == 1){
            cell.LBLIndicator.backgroundColor = UIColor(red: 193/255, green: 161/255, blue: 104/255, alpha: 1)
            
        }else {
            cell.LBLIndicator.backgroundColor = UIColor(red: 110/255, green: 111/255, blue: 116/255, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//////////////////////////////////////
//Helper class
//////////////////////////////////////
//This class is used by both for table views in Home Sence and Transaction Detail Scene
class TransactionTableViewCell: UITableViewCell {
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var LBLDescription: UILabel!
    @IBOutlet weak var LBLAmount: UILabel!
    @IBOutlet weak var LBLDate: UILabel!
    @IBOutlet weak var LBLIndicator: UILabel!
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
}

