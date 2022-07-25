//
//  MainTableViewController.swift
//  SimpleToDoApp
//
//  Created by Isagulov urmat on 17/7/22.
//

import UIKit

class MainTableViewController: UIViewController{
    
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    var tasks: [TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTaskButtonSetup()
        topBarSetup()
        tableViewSetup()
        
    }
    
    @IBAction func createItemTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: StoryboardIDs.createVC) as! CreateTaskViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    fileprivate func tableViewSetup(){
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
    }
    
    fileprivate func topBarSetup(){
        
        topBar.clipsToBounds = true
        topBar.layer.cornerRadius = 22
        topBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    fileprivate func newTaskButtonSetup(){
        
        createTaskButton.layer.cornerRadius = createTaskButton.frame.size.height / 2
        createTaskButton.layer.masksToBounds = true
    }
}

extension MainTableViewController: CreateTaskDelegate{
    
    func taskCreated(task: TaskModel) {
        var oldTask = false
        for i in 0..<tasks.count{
            if task.id == tasks[i].id{
                tasks[i] = task
                oldTask = true
            }
        }
        if !oldTask{
            tasks.append(task)
            mainTableView.reloadData()
        }
        
    }
}



extension MainTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTVCell
        
        let task = tasks[indexPath.row]
        
        cell.taskLabel.text = "Task #\(task.id)"
        
        cell.mainLabel.text = "\(task.title)"
        
        cell.dateLabel.text = "\(task.date)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = tasks[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: StoryboardIDs.createVC) as! CreateTaskViewController
        vc.delegate = self
        vc.currentTask = task
        navigationController?.pushViewController(vc, animated: true)
    }
}




