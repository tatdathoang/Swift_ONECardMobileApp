//
//  VCSuspendCard.swift
//  ONECard
//
//  Created by Dat Hoang on 17-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCSuspendCard: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var currentUserId:Int = 0
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var IVSeparateLine: UIImageView!
    @IBOutlet weak var LBLInformation: UILabel!
    @IBOutlet weak var BTNConfirm: UIButton!
    @IBOutlet weak var AILoadCardStatus: UIActivityIndicatorView!
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func ConfirmButtonClicked(_ sender: Any) {
        AILoadCardStatus.startAnimating()
        LBLInformation.text = ""
        
        if (Card.SuspendCardGET(userId: currentUserId)){
            _ = navigationController?.popToRootViewController(animated: true)
        }else{
            AILoadCardStatus.startAnimating()
            let alert = UIAlertController(title: "Cannot suspend your card", message: "Please try again later", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get user ID from UserDefault
        currentUserId = DataHelper.GetIntFromUserDefault(key: "UserId")
        
        //Design IVSeparateLine
        self.IVSeparateLine.layer.masksToBounds = false
        self.IVSeparateLine.layer.shadowColor = UIColor.lightGray.cgColor
        self.IVSeparateLine.layer.shadowOpacity = 0.8
        self.IVSeparateLine.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.IVSeparateLine.layer.shadowRadius = 2
        
        //Setup UI
        LBLInformation.text = ""
        BTNConfirm.isEnabled = false
        BTNConfirm.alpha = 0.5
        BTNConfirm.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let cardStatus = Card.GetCardStatusGET(userId: currentUserId)
        if(cardStatus == false){
            LBLInformation.text = "You don't have any active card"
            BTNConfirm.isEnabled = false
            BTNConfirm.alpha = 0.5
            BTNConfirm.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        }else{
            LBLInformation.text = "Please tap CONFIRM to suspend your card"
            BTNConfirm.isEnabled = true
            BTNConfirm.alpha = 1
            BTNConfirm.setTitleColor(UIColor.red, for: UIControl.State.normal)
        }
        
        AILoadCardStatus.stopAnimating()
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////
