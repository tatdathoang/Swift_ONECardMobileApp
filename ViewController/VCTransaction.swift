//
//  VCTransaction.swift
//  ONECard
//
//  Created by Dat Hoang on 24-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCTransaction: UIViewController {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var DPFromDate: UIDatePicker!
    @IBOutlet weak var DPToDate: UIDatePicker!
    @IBOutlet weak var SWIncludeDeposit: UISwitch!
    @IBOutlet weak var SWIncludeExpense: UISwitch!
    @IBOutlet weak var SWIncludeCondorCash: UISwitch!
    @IBOutlet weak var SWIncludePrintCredit: UISwitch!
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func FromDateChanged(_ sender: Any) {
        DPToDate.minimumDate = DPFromDate.date
    }
    @IBAction func ToDateChanged(_ sender: Any) {
        DPFromDate.maximumDate = DPToDate.date
    }
    
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    func GetFilter() -> Transaction.Filter{
        var filter : Transaction.Filter = Transaction.Filter()
        
        //Get date range
        filter.fromDate = DPFromDate.date
        filter.toDate = DPToDate.date
        
        //Get option
        filter.includeDeposit = SWIncludeDeposit.isOn ? 1 : 0
        filter.includeExpense = SWIncludeExpense.isOn ? 1 : 0
        filter.includeCondorCash = SWIncludeCondorCash.isOn ? 1 : 0
        filter.includePrintCredit = SWIncludePrintCredit.isOn ? 1 : 0

        return filter
    }
    
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Design navigation bar
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        DPFromDate.maximumDate = Date()
        DPToDate.maximumDate = Date()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VCTransactionDetail
        {
            let vc = segue.destination as? VCTransactionDetail
            vc?.filter = GetFilter()
        }
     }
}

//////////////////////////////////////
//Extension
//////////////////////////////////////

