//
//  Notification.swift
//  ONECard
//
//  Created by Dat Hoang on 29-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class Notification: NSObject {
    //////////////////////////////////////
    //Input encodeable object
    //////////////////////////////////////

    
    //////////////////////////////////////
    //Output decodeable object
    //////////////////////////////////////
    struct NotificationItem: Decodable {
        var itemId:Int = 0
        var title:String = ""
        var photoURL:String = ""
        var body:String = ""
        var dateTime:String = String()
        var typeId:Int = 0
        
        enum CodingKeys: String, CodingKey {
            case itemId = "notificationId"
            case title
            case photoURL
            case body = "description"
            case dateTime = "notificationTime"
            case typeId = "notificationTypeId"
        }
    }
    
    //////////////////////////////////////
    //Function
    //////////////////////////////////////
    
    static func GetNotification(userId:Int) -> [NotificationItem] {
        let semaphore = DispatchSemaphore(value: 0)
        
        var notificationList = [NotificationItem]()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetNotification") + "?userId=" + String(userId)
        
        print(apiUrl)
        
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "GET"
        
        //Establish request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: \(String(describing: responseError))")
                return
            }
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("Error: No readable data received in GetFirstLastName response")
            }
            
            do {
                notificationList = try JSONDecoder().decode([NotificationItem].self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return notificationList
    }
}
