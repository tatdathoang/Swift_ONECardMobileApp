//
//  VCSettingNotification.swift
//  ONECard
//
//  Created by Dat Hoang on 20-07-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCSettingNotification: UITableViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var currentUserId:Int = 0
    public var subscriptionList = [User.Subscription]()
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func UpdateSubcription(){
        var subcriptionTo = ""
        let cellList = tableView.visibleCells
        
        for cell in cellList as! [SubscriptionTableViewCell] {
            if (cell.SWSubscribe.isOn){
                subcriptionTo += "\(cell.notificationTypeID)_"
            }
        }
        //Remove last underscore
        subcriptionTo = String(subcriptionTo.dropLast())
        User.UpdateSubscription(userId: currentUserId, subscriptionList: subcriptionTo)
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get user ID from UserDefault
        currentUserId = DataHelper.GetIntFromUserDefault(key: "UserId")

        subscriptionList = User.GetSubscription(userId: currentUserId)
        subscriptionList = subscriptionList.sorted(by: { $0.notificationTypeId < $1.notificationTypeId })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptionList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  as! SubscriptionTableViewCell

        // Configure the cell...
        cell.LBLDescription.text = subscriptionList[indexPath.row].notificationType
        cell.SWSubscribe.isOn = subscriptionList[indexPath.row].isSubscribed
        cell.notificationTypeID = subscriptionList[indexPath.row].notificationTypeId
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UpdateSubcription()
    }
}

//////////////////////////////////////
//Helper class
//////////////////////////////////////
class SubscriptionTableViewCell: UITableViewCell {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var notificationTypeID:Int = -1
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var LBLDescription: UILabel!
    @IBOutlet weak var SWSubscribe: UISwitch!
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
}
