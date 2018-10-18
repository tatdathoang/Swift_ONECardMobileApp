//
//  VCHome.swift
//  ONECard
//
//  Created by Dat Hoang on 15-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCHome: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var currentUserId:Int = 0
    var filter:Transaction.Filter = Transaction.Filter()
    var transactionList:[Transaction.TransactionDetail] = [Transaction.TransactionDetail]()
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var AILoadTransactionList: UIActivityIndicatorView!
    @IBOutlet weak var TVTransactionList: UITableView!
    @IBOutlet weak var IVCashBoard: UIImageView!
    @IBOutlet weak var IVBannerLine: UIImageView!
    @IBOutlet weak var LBLName: UILabel!
    @IBOutlet weak var LBLCondorCash: UILabel!
    @IBOutlet weak var LBLPrintCredit: UILabel!
    @IBOutlet weak var LBLLastTransaction: UILabel!
    
    
    //////////////////////////////////////
    //UI elelment - Action
    //////////////////////////////////////
    

    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func LoadTransactionList(){
        //Request transaction list
        transactionList.removeAll()
        transactionList =  Transaction.GetLatestTransaction(userId: currentUserId)
    }
    
    func SetupViewData(){
        //Load fullname
        LBLName.text = User.GetFirstLastName(userId: currentUserId)
        
        //Load balance
        let userBalance = User.GetBalance(userId: currentUserId)
        LBLCondorCash.text = String(format: "$%.02f", userBalance.condorCash)
        LBLPrintCredit.text = String(format: "$%.02f", userBalance.printCredit)
        
        //Load latest transaction list
        LoadTransactionList()
        
        //Finish setup information
        TVTransactionList.reloadData()
        AILoadTransactionList.stopAnimating()
    }
    
    func SetupViewDataForParent(){
        //Load fullname
        LBLName.text = User.GetFirstLastName(userId: currentUserId) + "'s parent"
        
        //Load balance
        let userBalance = User.GetBalance(userId: currentUserId)
        LBLCondorCash.text = String(format: "$%.02f", userBalance.condorCash)
        LBLPrintCredit.text = String(format: "$%.02f", userBalance.printCredit)
        
        //Hide transaction list
        LBLLastTransaction.isHidden = true
        TVTransactionList.isHidden = true
        
        //Finish setup information
        AILoadTransactionList.stopAnimating()
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        //Get user ID from UserDefault
        currentUserId = DataHelper.GetIntFromUserDefault(key: "UserId")
        
        
        //Design IVBannerLine
        self.IVBannerLine.layer.masksToBounds = false
        self.IVBannerLine.layer.shadowColor = UIColor.lightGray.cgColor
        self.IVBannerLine.layer.shadowOpacity = 0.8
        self.IVBannerLine.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.IVBannerLine.layer.shadowRadius = 2
        
        //Design IVCashBoard
        IVCashBoard.layer.cornerRadius = 8.0
        IVCashBoard.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(DataHelper.GetIntFromUserDefault(key: "UserType") != 3){
                SetupViewData()
        }else{
            SetupViewDataForParent()
            if  let arrayOfTabBarItems = self.tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[1] as? UITabBarItem {
                tabBarItem.isEnabled = false
            }
        }
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////
extension VCHome:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransactionTableViewCell
        cell.LBLDescription.text = transactionList[indexPath.row].transDescription
        cell.LBLDate.text = transactionList[indexPath.row].date
        if (transactionList[indexPath.row].amount < 0){
            cell.LBLAmount.text = String(format: "-$%.02f", transactionList[indexPath.row].amount * -1)
        }else {
            cell.LBLAmount.text = String(format: "+$%.02f", transactionList[indexPath.row].amount)
            cell.LBLAmount.font = UIFont.boldSystemFont(ofSize: cell.LBLAmount.font.pointSize)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
