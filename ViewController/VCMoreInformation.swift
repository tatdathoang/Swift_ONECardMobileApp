//
//  VCMoreInformation.swift
//  ONECard
//
//  Created by Dat Hoang on 15-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit
import WebKit

class VCMoreInformation: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var LBLNavigationbar: UILabel!
    @IBOutlet weak var LBLBrowsingBar: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var WVMoreInformation: WKWebView!
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func GoBack(_ sender: Any) {
        self.WVMoreInformation.goBack()
    }
    @IBAction func GoForward(_ sender: Any) {
        self.WVMoreInformation.goForward()
    }
    @IBAction func Reload(_ sender: Any) {
        self.WVMoreInformation.reload()
    }
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    //Observe ưebpage loaded value
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress:Float = Float(self.WVMoreInformation.estimatedProgress)
            self.progressBar.progress = progress
            
            //Hide progressbar after loaded page
            if progress == 1{
                self.progressBar.isHidden = true
            }else{
                self.progressBar.isHidden = false
            }
        }
    }
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Design navigation bar
        self.LBLNavigationbar.layer.masksToBounds = false
        self.LBLNavigationbar.layer.shadowColor = UIColor.lightGray.cgColor
        self.LBLNavigationbar.layer.shadowOpacity = 0.8
        self.LBLNavigationbar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.LBLNavigationbar.layer.shadowRadius = 2
        
        //Load webpage
        let url = URL(string: "https://www.conestogac.on.ca/onecard/")
        let request = URLRequest(url: url!)
        WVMoreInformation.load(request)
        
        //Add observer to get estimated progress value
        self.WVMoreInformation.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//////////////////////////////////////
//Extension
//////////////////////////////////////

