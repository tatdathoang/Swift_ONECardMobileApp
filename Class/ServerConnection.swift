//
//  ServerConnection.swift
//  ONECard
//
//  Created by Dat Hoang on 06-07-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class ServerConnection: NSObject, Decodable {
    //////////////////////////////////////
    //Input encodeable object
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //Output decodeable object
    //////////////////////////////////////
    struct ConnectionStatus: Decodable {
        var isConnected: Bool = false
    }
    
    //////////////////////////////////////
    //Function
    //////////////////////////////////////
    static func TestConnectionWithSever() -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        
        var connectionStatus = ConnectionStatus()
        
        //Build request
        let apiUrl =  DataHelper.GetStringFromPList(pListName: "AppData", key: "Scheme")
            + DataHelper.GetStringFromPList(pListName: "AppData", key: "Host")
            + DataHelper.GetStringFromPList(pListName: "AppData", key: "TestConnection")
        guard let request = URL(string: apiUrl) else { return false }

        //Establish request
        URLSession.shared.dataTask(with: request) { (dataJson, response, error) in
        
            if (error == nil){
                guard let respondData = dataJson else { return }
                do {
                    connectionStatus = try JSONDecoder().decode(ConnectionStatus.self, from: respondData)
                } catch {
                    print("Error decode json: \(error)")
                }
            }else{
                print("Error connect to server")
            }
            
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        return connectionStatus.isConnected
    }
}
