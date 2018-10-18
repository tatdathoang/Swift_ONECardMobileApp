//
//  VCMore.swift
//  ONECard
//
//  Created by Dat Hoang on 17-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCMore: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    
    @IBOutlet weak var IVUploadPhoto: UIImageView!
    @IBOutlet weak var BTNUploadPhoto: UIButton!
    @IBOutlet weak var IVDisplayCard: UIImageView!
    @IBOutlet weak var BTNDisplayCard: UIButton!
    @IBOutlet weak var IVSuspendCard: UIImageView!
    @IBOutlet weak var BTNSuspendCard: UIButton!
    
    
    
    @IBOutlet weak var Signout: UIButton!

    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func SignoutButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Signin")
        self.present(controller, animated: true, completion: nil)
    }
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func SetupViewForParent(){
        IVUploadPhoto.alpha = 0.5
        BTNUploadPhoto.isEnabled = false
        IVDisplayCard.alpha = 0.5
        BTNDisplayCard.isEnabled = false
        IVSuspendCard.alpha = 0.5
        BTNSuspendCard.isEnabled = false
    }
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        //Deisgn signout button
        Signout.backgroundColor = .clear
        Signout.layer.borderWidth = 1
        Signout.layer.borderColor = UIColor(red: 193/255, green: 161/255, blue: 104/255, alpha: 1).cgColor
        
        //Design navigation bar
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        if(DataHelper.GetIntFromUserDefault(key: "UserType") == 3){
            SetupViewForParent()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////
