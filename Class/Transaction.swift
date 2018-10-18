//
//  Transaction.swift
//  ONECard
//
//  Created by Dat Hoang on 06-07-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit
import Foundation

class Transaction: NSObject, Decodable {
    //////////////////////////////////////
    //Input encodeable object
    //////////////////////////////////////
    struct Filter:Encodable {
        var userId:Int = 0
        var fromDate:Date = Date()
        var toDate:Date = Date()
        var includeDeposit:Int = 1
        var includeExpense:Int = 1
        var includeCondorCash:Int = 1
        var includePrintCredit:Int = 1
    }
    
    struct AddMoneySlip:Encodable{
        var userId:Int = 0
        var amountToAdd:Float = Float (0.0)
    }
    
    //////////////////////////////////////
    //Output decodeable object
    //////////////////////////////////////
    struct TransactionDetail: Decodable {
        var date: String = ""
        var transDescription: String = ""
        var amount: Float = Float(0.0)
        var transactionType: Int = 0
        
        enum CodingKeys: String, CodingKey {
            case date = "transactionTime"
            case transDescription = "description"
            case amount
            case transactionType = "transactionTypeId"
        }
        
    }
    
    struct AddMoneyResponse:Decodable{
        var isSuccessful: Bool = false
    }
    
    //////////////////////////////////////
    //Function
    //////////////////////////////////////
    /*
    private func ConvertStringToDate(string:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)!
    }
    
    private func ConvertDateToString(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var dateString = dateFormatter.string(from:date)
        dateString += " 00:00:00"
        return dateString
        
    }
    */
    
    static func GetLatestTransaction(userId:Int) -> [TransactionDetail] {
        let semaphore = DispatchSemaphore(value: 0)
        
        var transactionList = [TransactionDetail]()
        
        //Build request
        let apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetLatestTransaction") + "?userId=" + String(userId)
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
                transactionList = try JSONDecoder().decode([TransactionDetail].self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return transactionList
    }
    
    static func GetTransactionWithFilter(filter:Filter) -> [TransactionDetail] {
        let semaphore = DispatchSemaphore(value: 0)
        var transactionList = [TransactionDetail]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        //Build request
        var apiUrl =
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "GetTransactionWithFilter")
        apiUrl += "?userId=" + String(filter.userId) + "&"
        apiUrl += "fromDate=" + "'" + dateFormatter.string(from:filter.fromDate) + "%2000:00:00" + "'" + "&"
        apiUrl += "toDate=" + "'" + dateFormatter.string(from:filter.toDate) + "%2000:00:00" + "'" + "&"
        apiUrl += "includeDeposit=" + String(filter.includeDeposit) + "&"
        apiUrl += "includeExpense=" + String(filter.includeExpense) + "&"
        apiUrl += "includeCondorCash=" + String(filter.includeCondorCash) + "&"
        apiUrl += "includePrintCredit=" + String(filter.includePrintCredit)
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
                transactionList = try JSONDecoder().decode([TransactionDetail].self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        
        semaphore.wait()
        return transactionList
    }
    
    static func AddMoney(addMoneySlip:AddMoneySlip) -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        var addMoneyResponse = AddMoneyResponse()
        
        //Build request
        var apiUrl =
            DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "Host") +
                DataHelper.GetStringFromPList(pListName: "AppData", key: "AddMoney")
        apiUrl += "?userId=" + String(addMoneySlip.userId) + "&"
        apiUrl += "amountToAdd=" + String(addMoneySlip.amountToAdd)
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
                addMoneyResponse = try JSONDecoder().decode(AddMoneyResponse.self, from: responseData!)
            } catch let jsonErr {
                print("Error decode respond: \(jsonErr)")
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return addMoneyResponse.isSuccessful
    }
}
