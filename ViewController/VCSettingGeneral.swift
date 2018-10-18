//
//  VCSettingGeneral.swift
//  ONECard
//
//  Created by Dat Hoang on 01-08-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCSettingGeneral: UITableViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var currentUserId:Int = 0
    public var generalSettingList = [String]()
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func UpdateGeneralSetting(){
        //Lazy code
        let cellList = tableView.visibleCells
        let useBiometric = (cellList[0] as! GeneralSettingTableViewCell).SWStatus.isOn
        DataHelper.SetToUserDefault(key: "UseBiometric", value: useBiometric)
    }
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generalSettingList.append("Biometric signin")
        
        //Get user ID from UserDefault
        currentUserId = DataHelper.GetIntFromUserDefault(key: "UserId")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generalSettingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! GeneralSettingTableViewCell

        // Configure the cell...
        cell.LBLDescription.text = generalSettingList[indexPath.row]
        cell.SWStatus.isOn = DataHelper.GetBooleanFromUserDefault(key: "UseBiometric")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UpdateGeneralSetting()
    }

}

//////////////////////////////////////
//Helper class
//////////////////////////////////////
class GeneralSettingTableViewCell: UITableViewCell {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var LBLDescription: UILabel!
    @IBOutlet weak var SWStatus: UISwitch!
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
}
