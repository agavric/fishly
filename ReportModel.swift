//
//  ReportModel.swift
//  Fishly
//
//  Created by Aleksandar Gavric on 6/04/2015.
//  Copyright (c) 2015 Aleksandar Gavric. All rights reserved.
//

import Foundation
import CoreData

@objc(ReportModel)
class ReportModel: NSManagedObject {

    @NSManaged var archived: NSNumber
    @NSManaged var location: String
    @NSManaged var date: NSDate

}
