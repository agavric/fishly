//
//  ReportDetailViewController.swift
//  Fishly
//
//  Created by Aleksandar Gavric on 5/04/2015.
//  Copyright (c) 2015 Aleksandar Gavric. All rights reserved.
//

import UIKit

class ReportDetailViewController: UIViewController {

    var detailReportModel:ReportModel!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.locationTextField.text = detailReportModel.location
        self.datePicker.date = detailReportModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated (true)
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        detailReportModel.location = locationTextField.text
        detailReportModel.date = datePicker.date
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
