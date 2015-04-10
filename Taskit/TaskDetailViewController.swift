//
//  TaskDetailViewController.swift
//  Taskit
//
//  Created by Sónia Rosa on 27/03/15.
//  Copyright (c) 2015 Sónia Rosa. All rights reserved.
//

import UIKit

@objc protocol TaskDetailViewControllerDelegate {
    optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var detailTaskModel: TaskModel!
    //var mainVC: ViewController!
    
    var delegate: TaskDetailViewControllerDelegate?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

        
        taskTextField.text = detailTaskModel.task
        subtaskTextField.text = detailTaskModel.subtask
        dueDatePicker.date = detailTaskModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
//        var newTask = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
//        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = newTask
//        
//        self.navigationController?.popViewControllerAnimated(true)
        
       // let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subtaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        
        //appDelegate.saveContext()
        
        ModelManager.instance.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.taskDetailEdited!()
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
          // Pass the selected object to the new view controller.
    }
    

}
