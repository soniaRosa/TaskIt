//
//  ViewController.swift
//  Taskit
//
//  Created by Sónia Rosa on 24/03/15.
//  Copyright (c) 2015 Sónia Rosa. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, TaskDetailViewControllerDelegate, AddTaskViewControllerDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
   // MARK: - Properties
    
//    var tasks: [TaskModel] = []
    
    //let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
   // var baseArray: [[TaskModel]] = []
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
//        let date1 = Date.from(year: 2015, month: 03, day: 29)
//        let date2 = Date.from(year: 2015, month: 04, day: 28)
//        let date3 = Date.from(year: 2015, month: 03, day: 30)
//        let date4 = Date.from(year: 2015, month: 04, day: 01)
//        
//        let task1 = TaskModel(task: "Ivan", subtask: "study", date: date1, completed: false)
//        let task2 = TaskModel(task: "João", subtask: "study swift", date: date2, completed: false)
//        let task3 = TaskModel(task: "Sonia", subtask: "play with cats and dogs", date: date3, completed: false)
//        
//        var taskArray = [task1, task2, task3]
//        
//        var completedArray = [TaskModel(task: "Task Project", subtask: "Code", date: date4, completed: true)]
//        
//        baseArray = [taskArray, completedArray]
//        
//        tableView.reloadData()
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
     
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("icloudUpdated"), name: "coreDataUpdated", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        baseArray[0] = baseArray[0].sorted {
//            (taskOne: TaskModel, taskTwo: TaskModel) -> Bool in
//            
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        
//        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC = segue.destinationViewController as TaskDetailViewController
            let index = self.tableView.indexPathForSelectedRow()
            //let task = baseArray[index!.section][index!.row]
            let task = fetchedResultsController.objectAtIndexPath(index!) as TaskModel
            
            detailVC.detailTaskModel = task
            //detailVC.mainVC = self
            detailVC.delegate = self
        }
        
        if segue.identifier == "showTaskAdd" {
            let addTaskVC = segue.destinationViewController as AddTaskViewController
            //addTaskVC.mainVC = self
            addTaskVC.delegate = self
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func addBarButtonItemPressed(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // return baseArray.count
        return fetchedResultsController.sections!.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return baseArray[section].count
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // var task = baseArray[indexPath.section][indexPath.row]
        
        let task = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        

        var cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as TaskItCell
        
        
        cell.taskLabel.text = task.task
        cell.descriptionLabel.text = task.subtask
        cell.dateLabel.text = Date.dateToString(date: task.date)
        
        return cell
    
    }
    
    // // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if fetchedResultsController.sections?.count == 1 {
            
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            let testTask = fetchedObjects[0] as TaskModel
            
            if testTask.completed == true {
                return "Completed Task"
            }
            else {
                return " To Do Task"
            }
        }
        else {
            if section == 0 {
                return "To-Do Task"
            }
            else {
                return "Completed Task"
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        var thisTask = baseArray[indexPath.section][indexPath.row]
//        var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: true)
//        baseArray[indexPath.section].removeAtIndex(indexPath.row)
//        baseArray[1].append(newTask)
//        tableView.reloadData()
        
//        var thisTask = baseArray[indexPath.section][indexPath.row]
//        
//        if indexPath.section == 0 {
//            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: true)
//            baseArray[1].append(newTask)
//        }
//        else {
//            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: false)
//            baseArray[0].append(newTask)
//        }
//        
//        baseArray[indexPath.section].removeAtIndex(indexPath.row)
//        tableView.reloadData()
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
//        if indexPath.section == 0 {
//            thisTask.completed = true
//        }
//        else {
//            thisTask.completed = false
//        }
        
        if thisTask.completed == true {
            thisTask.completed = false
        }
        else {
            thisTask.completed = true
        }
        
        //(UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        ModelManager.instance.saveContext()
        
    }
    
    // MARK: - Helper Function
    func taskFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescription = NSSortDescriptor(key: "date", ascending: true)
        let completedDescription = NSSortDescriptor(key: "completed", ascending: true)
        
        fetchRequest.sortDescriptors = [completedDescription, sortDescription]
        
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: ModelManager.instance.managedObjectContext!, sectionNameKeyPath: "completed", cacheName: nil)
        
        return fetchedResultsController
    }
    
    func showAlert(message: String = "Congratulation") {
        
        var alert = UIAlertController(title: "Change Made!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // MARK: - TaskDetailViewControllerDelegate
    
   func taskDetailEdited() {
    
        // println("taskDetailEdited")
      showAlert()
   }
    
    // MARK: - AddTaskViewControllerDelegate
    
    func addTask(message: String) {
        
       showAlert(message: message)
    }
    
    func addTaskCanceled(message: String) {
        
        showAlert(message: message)
    }
    
    // MARK: icloud Notification
    
    func icloudUpdated () {
        
        tableView.reloadData()
    }
    
    
    
    


}

