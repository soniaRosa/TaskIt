//
//  TaskModel.swift
//  Taskit
//
//  Created by Sónia Rosa on 02/04/15.
//  Copyright (c) 2015 Sónia Rosa. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)

class TaskModel: NSManagedObject {

    @NSManaged var task: String
    @NSManaged var subtask: String
    @NSManaged var date: NSDate
    @NSManaged var completed: NSNumber

}
