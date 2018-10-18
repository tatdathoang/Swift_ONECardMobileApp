//
//  VCLaunchScreen.swift
//  ONECard
//
//  Created by Dat Hoang on 10-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCSplashScreen: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var isConnected:Bool = false
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var AIConnectToServer: UIActivityIndicatorView!
    @IBOutlet weak var LBLVersion: UILabel!
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func DisplayErrorPopUp(title:String, message:String, buttonTitle:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load version from plist file
        LBLVersion.text = "Version " + DataHelper.GetStringFromPList(pListName: "AppData", key: "Version")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isConnected = ServerConnection.TestConnectionWithSever()
        
        if(self.isConnected){
            self.AIConnectToServer.stopAnimating()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Signin")
            self.present(controller, animated: true, completion: nil)
        }else{
            self.DisplayErrorPopUp(title: "Cannot connect to server", message: "Please check your internet connection", buttonTitle: "OK")
        }
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////

