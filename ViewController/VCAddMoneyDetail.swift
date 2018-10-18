//
//  VCAddMoneyDetail.swift
//  ONECard
//
//  Created by Dat Hoang on 11-07-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCAddMoneyDetail: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var addMoneySlip = Transaction.AddMoneySlip()
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var AIAddMoney: UIActivityIndicatorView!

    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func DisplayErrorPopUp(title:String, message:String, buttonTitle:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: buttonTitle, style: .default) { (action:UIAlertAction) in
             _ = self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)

    }
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Design navigation bar
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        //Get user ID from UserDefault
        addMoneySlip.userId = DataHelper.GetIntFromUserDefault(key: "UserId")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let result = Transaction.AddMoney(addMoneySlip: addMoneySlip)
        sleep(3)
        AIAddMoney.stopAnimating()
        
        if (result){
            let newBalance = User.GetBalance(userId: addMoneySlip.userId)
            DisplayErrorPopUp(title: "Succeed", message: "Your new Condor cash balance is: $\(newBalance.condorCash)", buttonTitle: "OK")
            
        }else{
            DisplayErrorPopUp(title: "Failed to add money", message: "An error happened. Please try again later", buttonTitle: "OK")
        }
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////

