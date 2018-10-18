//
//  VCAddMoney.swift
//  ONECard
//
//  Created by Dat Hoang on 15-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCAddMoney: UIViewController {
    
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var addMoneySlip = Transaction.AddMoneySlip()
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var TFAmount: UITextField!
    @IBOutlet weak var IVSeparateLine: UIImageView!
    @IBOutlet weak var LBLAmountToAdd: UITextField!
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func FiftyDollar(_ sender: Any) {
        QuickSelectPressed(amount: 50)
    }
    
    @IBAction func OneHundredDollar(_ sender: Any) {
        QuickSelectPressed(amount: 100)
    }
    
    @IBAction func TwoHundredDollar(_ sender: Any) {
        QuickSelectPressed(amount: 200)
    }
    
    @IBAction func FiveHundredDollar(_ sender: Any) {
        QuickSelectPressed(amount: 500)
    }
    
    @IBAction func OneThoundsandDollar(_ sender: Any) {
        QuickSelectPressed(amount: 1000)
    }

    @IBAction func TypeAmount(_ sender: Any) {
        var amountString = LBLAmountToAdd.text
        
        //Remove previous $ sign
        amountString = amountString?.replacingOccurrences(of: "$", with: "")
        //Add $ sign
        amountString = "$" + amountString!
        
        //Set back to label
        LBLAmountToAdd.text = amountString
    }
    
    @IBAction func FinishedEdit(_ sender: Any) {
        AddDecimal()
    }
    
    //////////////////////////////////////
    //Helper
    //////////////////////////////////////
    func AddDecimal(){
        var amountString = LBLAmountToAdd.text
        //Add .00
        if(amountString?.contains(".") == false){
            amountString = amountString! + ".00"
        }
        
        //Set back to label
        LBLAmountToAdd.text = amountString
    }
    
    func QuickSelectPressed (amount:Int){
        TFAmount.text = ""
        TFAmount.text = "$\(amount)"
        AddDecimal()
    }
    
    func CheckAmountValidity() -> Bool{
        let amountToAdd = GetAmountToAdd()
        
        if (amountToAdd < 10){
            DisplayErrorPopUp(title: "Invalid amount", message: "Minimum amount is $10.00", buttonTitle: "OK")
            LBLAmountToAdd.text = "$10.00"
            return false
        }else{
            addMoneySlip.amountToAdd = amountToAdd
            return true
        }
    }
    
    func GetAmountToAdd()->Float{
        if(LBLAmountToAdd.text == ""){
            return 0.0
        }else{
            let processedAmount = (LBLAmountToAdd.text)?.replacingOccurrences(of: "$", with: "")
            //If the input string is not a valid number, ex: abc, this will return nil, which will be catched by the caller's if statement
            if(isNumber(stringNumber: processedAmount!)){
                return (processedAmount! as NSString).floatValue
            }else{
                return 0.0
            }
            
        }
    }
    
    func isNumber(stringNumber:String) -> Bool{
        let characters = CharacterSet.decimalDigits.inverted
        if(stringNumber.rangeOfCharacter(from: characters) != nil){
            return true
        }else{
            return false
        }
    }
    
    func DisplayErrorPopUp(title:String, message:String, buttonTitle:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.TFAmount.becomeFirstResponder()
        self.present(alert, animated: true, completion: nil)
    }
    
    //Hide keyboard helper
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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

        //Design IVBannerLine
        self.IVSeparateLine.layer.masksToBounds = false
        self.IVSeparateLine.layer.shadowColor = UIColor.lightGray.cgColor
        self.IVSeparateLine.layer.shadowOpacity = 0.8
        self.IVSeparateLine.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.IVSeparateLine.layer.shadowRadius = 2
        
        //Hide keyboard when tap around
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(CheckAmountValidity() == true){
            if segue.destination is VCAddMoneyDetail
            {
                let vc = segue.destination as? VCAddMoneyDetail
                vc?.addMoneySlip = addMoneySlip
            }
        }else{
            return
        }
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////
