//
//  Card.swift
//  ONECard
//
//  Created by Dat Hoang on 13-07-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class Card: NSObject {
    //////////////////////////////////////
    //Input encodeable object
    //////////////////////////////////////

    
    //////////////////////////////////////
    //Output decodeable object
    //////////////////////////////////////
    struct CardStatus: Decodable {
        var cardStatus: Bool = false
    }
    
    struct SuspendStatus: Decodable {
        var isSuccessful: Bool = false
    }
    
    //////////////////////////////////////
    //Function
    //////////////////////////////////////
    static func GetCardStatus(userId:Int)->Bool{
        let semaphore = DispatchSemaphore(value: 0)
        
        var currentCardStatus = CardStatus()
        let userIdStruct = User.UserId(userId: userId)
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetCardStatus")
        print(apiUrl)
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        //Encode JSON and attach to request
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(userIdStruct)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            print ("Error: can not encode userId")
        }
        
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
                currentCardStatus = try JSONDecoder().decode(CardStatus.self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return currentCardStatus.cardStatus
    }
    
    static func GetCardStatusGET(userId:Int) -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        
        var currentCardStatus = CardStatus()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetCardStatus") + "?userId=" + String(userId)
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
                currentCardStatus = try JSONDecoder().decode(CardStatus.self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return currentCardStatus.cardStatus
    }
    
    static func SuspendCard(userId:Int)->Bool{
        let semaphore = DispatchSemaphore(value: 0)
        
        var currentSuspendStatus = SuspendStatus()
        let userIdStruct = User.UserId(userId: userId)
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "SuspendCard")
        print(apiUrl)
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        //Encode JSON and attach to request
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(userIdStruct)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            print ("Error: can not encode userId")
        }
        
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
                currentSuspendStatus = try JSONDecoder().decode(SuspendStatus.self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return currentSuspendStatus.isSuccessful
    }
    
    static func SuspendCardGET(userId:Int) -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        
        var currentSuspendStatus = SuspendStatus()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "SuspendCard") + "?userId=" + String(userId)
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
                currentSuspendStatus = try JSONDecoder().decode(SuspendStatus.self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return currentSuspendStatus.isSuccessful
    }
}
