//
//  VCSetting.swift
//  ONECard
//
//  Created by Dat Hoang on 21-07-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCSetting: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var CVNotification: UIView!
    @IBOutlet weak var CVGeneral: UIView!
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func ChangeSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            CVNotification.isHidden = true
            CVGeneral.isHidden = false
        case 1:
            CVNotification.isHidden = false
            CVGeneral.isHidden = true
        default:
            break
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
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////

