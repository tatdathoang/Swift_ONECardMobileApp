//
//  VCDisplayCard.swift
//  ONECard
//
//  Created by Dat Hoang on 19-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit
import CoreImage

class VCDisplayCard: UIViewController {
    
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var currentUserId:String = ""
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var IVQRCode: UIImageView!
    @IBOutlet weak var IVBarcode128: UIImageView!
    @IBOutlet weak var IVBarcode417: UIImageView!
    

    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func CreateImageCode(filterName : String) -> UIImage? {
        let userID = currentUserId
        let data = userID.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: filterName) {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get user ID from AppData.plist
        currentUserId = DataHelper.GetStringFromPList(pListName: "AppData", key: "UserId")
        
        IVQRCode.image = CreateImageCode(filterName: "CIQRCodeGenerator")
        IVBarcode128.image = CreateImageCode(filterName: "CICode128BarcodeGenerator")
        IVBarcode417.image = CreateImageCode(filterName: "CIPDF417BarcodeGenerator")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////
