//
//  VCNotificationDetail.swift
//  ONECard
//
//  Created by Dat Hoang on 29-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCNotificationDetail: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var currentNotification = Notification.NotificationItem()
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var LBLTitle: UILabel!
    @IBOutlet weak var IVSeperateLine: UIImageView!
    @IBOutlet weak var TVBody: UITextView!
    @IBOutlet weak var IVImage: UIImageView!
    @IBOutlet weak var LBLDate: UILabel!
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func LoadPhoto(photoPath:String) -> UIImage{
        let semaphore = DispatchSemaphore(value: 0)
        var downloadedImage = UIImage()
        
        let photoURL = URL(string: photoPath)!
        print(photoURL)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: photoURL) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        downloadedImage = UIImage(data: imageData)!
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
                semaphore.signal()
            }
        }
        
        task.resume()
        semaphore.wait()
        return downloadedImage
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Design IVSeperateLine
        self.IVSeperateLine.layer.masksToBounds = false
        self.IVSeperateLine.layer.shadowColor = UIColor.lightGray.cgColor
        self.IVSeperateLine.layer.shadowOpacity = 0.8
        self.IVSeperateLine.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.IVSeperateLine.layer.shadowRadius = 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LBLTitle.text = currentNotification.title
        LBLDate.text = currentNotification.dateTime
        TVBody.text = currentNotification.body
        IVImage.image = LoadPhoto(photoPath: currentNotification.photoURL)
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////
