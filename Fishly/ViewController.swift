//
//  ViewController.swift
//  Fishly
//
//  Created by Aleksandar Gavric on 5/04/2015.
//  Copyright (c) 2015 Aleksandar Gavric. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil) // add error handling

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showReportDetail" {
            let detailVC: ReportDetailViewController = segue.destinationViewController as ReportDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisReport = fetchedResultsController.objectAtIndexPath(indexPath!) as ReportModel
            detailVC.detailReportModel = thisReport
        } else if segue.identifier == "showAddReport" {
            let addReportVC:AddReportViewController = segue.destinationViewController as AddReportViewController
        }
    }


    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showAddReport", sender: self)
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisReport = fetchedResultsController.objectAtIndexPath(indexPath) as ReportModel
        
        var cell: ReportCell = tableView.dequeueReusableCellWithIdentifier("reportCell") as
        ReportCell
        
        cell.locationLabel.text = thisReport.location
        cell.dateLabel.text = Date.toString(date: thisReport.date)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println(indexPath.row)
        
        performSegueWithIdentifier("showReportDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Recent"
        } else {
            return "Archived"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        let thisReport = fetchedResultsController.objectAtIndexPath(indexPath) as ReportModel
        
        if indexPath.section == 0 {
            thisReport.archived = true
        } else {
            thisReport.archived = false
        }
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    
    }
    
    //NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    //Helper
    
    func reportFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "ReportModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let archivedDescriptor = NSSortDescriptor(key: "archived", ascending: true)
        fetchRequest.sortDescriptors = [archivedDescriptor, sortDescriptor]
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: reportFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "archived", cacheName: nil)
        return fetchedResultsController
    }
    
}

