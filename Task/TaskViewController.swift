//
//  TaskViewController.swift
//  Task
//
//  Created by Erick Serejo on 27/07/24.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var task: String?
    var taskIndex: Int?
    var update: (() -> Void)?
     

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))

    }
    
    @objc func deleteTask() {
          guard let taskIndex = taskIndex else {
              return
          }
          
          guard var count = UserDefaults().value(forKey: "count") as? Int else {
              return
          } 
          for x in taskIndex..<count-1 {
              if let nextTask = UserDefaults().value(forKey: "task_\(x+2)") as? String {
                  UserDefaults().set(nextTask, forKey: "task_\(x+1)")
              }
          }
          
          UserDefaults().removeObject(forKey: "task_\(count)")
          count -= 1
          UserDefaults().set(count, forKey: "count")
          
          update?()
          
          navigationController?.popViewController(animated: true)
      }


}
