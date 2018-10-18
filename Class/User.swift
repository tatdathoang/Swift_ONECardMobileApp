//
//  User.swift
//  ONECard
//
//  Created by Dat Hoang on 29-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class User: NSObject, Decodable {
    //////////////////////////////////////
    //Input encodeable object
    //////////////////////////////////////
    struct UserId: Encodable {
        var userId: Int = 0
    }
    
    //////////////////////////////////////
    //Output decodeable object
    //////////////////////////////////////
    struct FirstLastName: Decodable {
        var firstName: String = ""
        var lastName: String = ""
    }
    
    struct Balance: Decodable{
        var condorCash: Float = Float(0.0)
        var printCredit: Float = Float(0.0)
    }
    
    struct Subscription: Decodable {
        var notificationType: String = ""
        var notificationTypeId: Int = 0
        var isSubscribed:Bool = false
    }
    
    //////////////////////////////////////
    //Function
    //////////////////////////////////////
    
    
    static func GetFirstLastName(userId:Int) -> String {
        let semaphore = DispatchSemaphore(value: 0)
        
        var firstLastName = FirstLastName()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetFirstLastName") + "?userId=" + String(userId)
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
                firstLastName = try JSONDecoder().decode(FirstLastName.self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return firstLastName.firstName + " " + firstLastName.lastName
    }
    
    static func GetBalance(userId:Int) -> Balance {
        let semaphore = DispatchSemaphore(value: 0)
        
        var userBalance = Balance()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetBalance") + "?userId=" + String(userId)
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
                userBalance = try JSONDecoder().decode(Balance.self, from: responseData!)
                print (userBalance.condorCash)
                print (userBalance.printCredit)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return userBalance
    }
    
    static func GetSubscription(userId:Int) -> [Subscription] {
        let semaphore = DispatchSemaphore(value: 0)
        
        var subscriptionList = [Subscription]()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetSubscription") + "?userId=" + String(userId)
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
                subscriptionList = try JSONDecoder().decode([Subscription].self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return subscriptionList
    }
    
    static func UpdateSubscription(userId:Int, subscriptionList:String) {
        let semaphore = DispatchSemaphore(value: 0)
        
        //var subscriptionList = [Subscription]()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "UpdateSubscription") + "?userId=" + String(userId) + "&updateIds=" + subscriptionList
        
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
            
            
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
    }
    
}
