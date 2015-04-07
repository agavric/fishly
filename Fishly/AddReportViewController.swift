//
//  AddReportViewController.swift
//  Fishly
//
//  Created by Aleksandar Gavric on 5/04/2015.
//  Copyright (c) 2015 Aleksandar Gavric. All rights reserved.
//

import UIKit
import CoreData

class AddReportViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated (true)
    }
    
    @IBAction func addReportButtonTapped(sender: UIBarButtonItem) {

        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("ReportModel", inManagedObjectContext: managedObjectContext!)
        let report = ReportModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        report.location = locationTextField.text
        report.date = datePicker.date
        report.archived = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "ReportModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        self.navigationController?.popViewControllerAnimated (true)
    }
}
 