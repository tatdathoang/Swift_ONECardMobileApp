//
//  VCContact.swift
//  ONECard
//
//  Created by Dat Hoang on 25-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class VCContact: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var IVGreyBackgroundTop: UIImageView!
    @IBOutlet weak var LBLVersionRelease: UILabel!
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func OpenMap(_ sender: Any) {
        let coordinates = CLLocationCoordinate2DMake( Double(DataHelper.GetStringFromPList(pListName: "AppData", key: "ContactLongitude"))!,
                                                      Double(DataHelper.GetStringFromPList(pListName: "AppData", key: "ContactLatitude"))!)
        let regionSpan = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Conestoga College"
        
        mapItem.openInMaps(launchOptions:[MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)] as [String : Any])
    }
    
    @IBAction func OpenEmail(_ sender: Any) {
        let url: NSURL = URL(string: "mailto://" + DataHelper.GetStringFromPList(pListName: "AppData", key: "ContactEmail"))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    @IBAction func CallPhone(_ sender: Any) {
        let url: NSURL = URL(string: "tel://" + DataHelper.GetStringFromPList(pListName: "AppData", key: "ContactPhone"))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    @IBAction func OpenFacebook(_ sender: Any) {
        let url: NSURL = URL(string: DataHelper.GetStringFromPList(pListName: "AppData", key: "ContactFacebook"))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    @IBAction func OpenTwitter(_ sender: Any) {
        let url: NSURL = URL(string: DataHelper.GetStringFromPList(pListName: "AppData", key: "ContactTwitter"))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    @IBAction func OpenInstagram(_ sender: Any) {
        let url: NSURL = URL(string: DataHelper.GetStringFromPList(pListName: "AppData", key: "ContactInstagram"))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }

    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Design IVGreyBackgroundTop
        self.IVGreyBackgroundTop.layer.masksToBounds = false
        self.IVGreyBackgroundTop.layer.shadowColor = UIColor.lightGray.cgColor
        self.IVGreyBackgroundTop.layer.shadowOpacity = 0.8
        self.IVGreyBackgroundTop.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.IVGreyBackgroundTop.layer.shadowRadius = 2
        
        //Get version and release date from AppData.plist
        LBLVersionRelease.text = "Version: " + DataHelper.GetStringFromPList(pListName: "AppData", key: "Version") +
                                 " Release date: " + DataHelper.GetStringFromPList(pListName: "AppData", key: "ReleaseDate") 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////

