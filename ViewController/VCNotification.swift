//
//  VCNotification.swift
//  ONECard
//
//  Created by Dat Hoang on 29-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCNotification: UITableViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    var selectedNotification = Notification.NotificationItem()
    var notificationList = [Notification.NotificationItem]()
    var currentUserId:Int = 0
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    //In:  https://websitelink.com/photo001_l.jpg
    //Out: https://websitelink.com/photo001_s.jpg
    func CreateThumnailURL(photoURL:String) -> String{
        var thumnailURL = photoURL
        thumnailURL.removeLast(5)
        thumnailURL += "s.jpg"
        return thumnailURL
    }
    
    func LoadPhoto(photoURL:String) -> UIImage{
        let semaphore = DispatchSemaphore(value: 0)
        var thumbnailImage = UIImage()

        let thumbnailURL = URL(string: CreateThumnailURL(photoURL: photoURL))!
        print(thumbnailURL)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: thumbnailURL) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        thumbnailImage = UIImage(data: imageData)!
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
        return thumbnailImage
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get user ID from UserDefault
        currentUserId = DataHelper.GetIntFromUserDefault(key: "UserId")
        
        self.title = "...loading..."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        notificationList = Notification.GetNotification(userId: currentUserId)
        notificationList = notificationList.sorted(by: { $0.dateTime > $1.dateTime })
        tableView.reloadData()
        
        self.title = "Notification"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotificationTableViewCell

        // Configure the cell...
        cell.LBLNotificationTitle.text = notificationList[indexPath.row].title
        cell.LBLNotificationBody.text = notificationList[indexPath.row].body
        cell.IVNotificationImage.image = LoadPhoto(photoURL: notificationList[indexPath.row].photoURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            notificationList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNotification = notificationList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "NotificationDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VCNotificationDetail{
            let vc = segue.destination as? VCNotificationDetail
            vc?.currentNotification = selectedNotification
        }
    }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////

//////////////////////////////////////
//Helper class
//////////////////////////////////////
class NotificationTableViewCell: UITableViewCell {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////

    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var LBLNotificationTitle: UILabel!
    @IBOutlet weak var LBLNotificationBody: UILabel!
    @IBOutlet weak var IVNotificationImage: UIImageView!
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
}
