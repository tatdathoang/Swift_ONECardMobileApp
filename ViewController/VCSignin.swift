//
//  VCSignin.swift
//  ONECard
//
//  Created by Dat Hoang on 10-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit
import LocalAuthentication

class VCSignin: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var viewMoved = false
    var movedDistance:CGFloat = 0
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var IVTopBanner: UIImageView!
    @IBOutlet weak var TFUsername: UITextField!
    @IBOutlet weak var TFPassword: UITextField!
    @IBOutlet weak var LBLBannerLine: UILabel!
    @IBOutlet weak var SWParentSignin: UISwitch!
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func ToggleParentSignin(_ sender: UISwitch) {
        if(sender.isOn){
            TFUsername.placeholder = "Student number"
            TFUsername.keyboardType = UIKeyboardType.numberPad
            TFPassword.placeholder = "Date of birth (YYYY-MM-DD)"
        }
        else{
            TFUsername.placeholder = "Network ID"
            TFUsername.keyboardType = UIKeyboardType.default
            TFPassword.placeholder = "Password"
        }
    }
    
    @IBAction func SigninClicked(_ sender: Any) {
        //Temp code
        if(TFUsername.text != ""){
            DataHelper.SetToUserDefault(key: "UserId", value: Int(TFUsername.text!)!)
        }else{
            DataHelper.SetToUserDefault(key: "UserId", value: 1)
        }
        
        
        if(SWParentSignin.isOn){
            DataHelper.SetToUserDefault(key: "UserType", value: 3)
        }else{
            DataHelper.SetToUserDefault(key: "UserType", value: 1)
        }
        //Swapped for easier testing
        //TODO: reverse when finished login code
        if TFPassword.text == ""{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainTab")
            self.present(newViewController, animated: true, completion: nil)
        }
        else{
            authenticationWithTouchID()
        }
    }

    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    @objc func KeyboardWillShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        MoveViewWithKeyboard(showKeyboard: true, keyboardHeight: ((keyboardSize?.height)!/2))
    }
    
    @objc func KeyboardWillHide(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        MoveViewWithKeyboard(showKeyboard: false, keyboardHeight: ((keyboardSize?.height)!/2))
    }
    
    func MoveViewWithKeyboard(showKeyboard:Bool, keyboardHeight:CGFloat)
    {
        if showKeyboard == true, viewMoved == false {
            movedDistance = keyboardHeight;
            MoveView(moveUp: true, moveValue: keyboardHeight)
            viewMoved = true
        }
        else if showKeyboard == false, viewMoved == true{
            MoveView(moveUp: false, moveValue: movedDistance)
            viewMoved = false
        }
    }
    
    func MoveView (moveUp:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movementDistance:CGFloat = ( moveUp ? -moveValue : moveValue)
        
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movementDistance)
        UIView.commitAnimations()
    }
    
    func HideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.DismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissKeyboard() {
        view.endEditing(true)
    }
    
    //Local authentication helper
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use password"
        
        var authError: NSError?
        let reasonString = "To login to your account"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    //TODO: User authenticated successfully, take appropriate action
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainTab")
                    self.present(newViewController, animated: true, completion: nil)
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    
                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
            
        } else {
            
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, *) {
            switch errorCode {
            case Int(kLAErrorBiometryNotAvailable):
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case Int(kLAErrorBiometryLockout):
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case Int(kLAErrorBiometryNotEnrolled):
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case Int(kLAErrorBiometryNotAvailable):
                message = "Too many failed attempts."
                
            case Int(kLAErrorBiometryLockout):
                message = "TouchID is not available on the device"
                
            case Int(kLAErrorBiometryNotEnrolled):
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case Int(kLAErrorAuthenticationFailed):
            message = "The user failed to provide valid credentials"
            
        case Int(kLAErrorAppCancel):
            message = "Authentication was cancelled by application"
            
        case Int(kLAErrorInvalidContext):
            message = "The context is invalid"
            
        case Int(kLAErrorNotInteractive):
            message = "Not interactive"
            
        case Int(kLAErrorPasscodeNotSet):
            message = "Passcode is not set on the device"
            
        case Int(kLAErrorSystemCancel):
            message = "Authentication was cancelled by the system"
            
        case Int(kLAErrorUserCancel):
            message = "The user did cancel"
            
        case Int(kLAErrorUserFallback):
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        return message
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (DataHelper.GetBooleanFromPList(pListName: "AppData", key: "UseBiometric"))
        //Design banner line
        self.LBLBannerLine.layer.masksToBounds = false
        self.LBLBannerLine.layer.shadowColor = UIColor.lightGray.cgColor
        self.LBLBannerLine.layer.shadowOpacity = 0.8
        self.LBLBannerLine.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.LBLBannerLine.layer.shadowRadius = 2
        
        //Hide keyboard when tap around
        self.HideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
