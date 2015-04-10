//
//  AddTaskViewController.swift
//  Taskit
//
//  Created by Sónia Rosa on 28/03/15.
//  Copyright (c) 2015 Sónia Rosa. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    func addTask(message: String)
    func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: AddTaskViewControllerDelegate?
    
    //var mainVC: ViewController!
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task Was Not Added")

    }
    @IBAction func addTaskButtonPressed(sender: UIButton) {
        
//        let newTask = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
//        mainVC.baseArray[0].append(newTask)
//        self.dismissViewControllerAnimated(true, completion: nil)
//        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = ModelManager.instance.managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
            
            task.task = taskTextField.text.capitalizedString
        }
        else {
            
            task.task = taskTextField.text
        }
        
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
            
            task.completed = true
        }
        else {
            
            task.completed = false
        }
        
        
        //appDelegate.saveContext()
        
        ModelManager.instance.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        
        var error: NSError? = nil
        
        var results: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task Added")
    }

}
