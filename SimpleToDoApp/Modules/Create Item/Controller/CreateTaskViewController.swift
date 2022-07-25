//
//  CreateTaskViewController.swift
//  SimpleToDoApp
//
//  Created by Isagulov urmat on 21/7/22.
//

import UIKit

protocol CreateTaskDelegate{
    func taskCreated(task: TaskModel)
}



class CreateTaskViewController: UIViewController{
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var mainTitleTextField: UITextField!
    @IBOutlet weak var BackButton: UIImageView!
    @IBOutlet weak var subTitle: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var titleCreate: String?
    var subTitleCreate: String?
    var id: Int = Int.random(in: 1..<100)
    var date: String?
    var currentTask: TaskModel?
    
    var delegate: CreateTaskDelegate?
    
//    init(task: TaskModel?){
//        self.currentTask = task
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerSetup()
        backButtonSetup()
        topBarSetup()
        createButtonSetup()
        mainTitleSetup()
        subTitleSetup()
        initialSetup()
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        if let title = mainTitleTextField.text{
            if !title.isEmpty{
                self.titleCreate = title
            }
        }
        
        if let subTitle = subTitle.text{
            if !subTitle.isEmpty{
                self.subTitleCreate = subTitle
            }
        }
        
        guard let titleString = self.titleCreate, let subTitleString = self.subTitleCreate, let taskDate = self.date else {
            return
        }
        
        let task = TaskModel(id: self.id, title: titleString, subTitle: subTitleString, date: taskDate, isDone: false)
        
        delegate?.taskCreated(task: task)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        if Date() < sender.date{
            self.date = formatDate(date: sender.date)
        }else{
            self.date = nil
        }

    }
    
    func initialSetup(){
        if let currentTask = currentTask {
            self.id = currentTask.id
            mainTitleTextField.text = currentTask.title
            subTitle.text = currentTask.subTitle
            if let date = getDate(taskDate: currentTask.date){
                datePicker.date = date
            }
            
            createButton.setTitle("Редактировать ", for: .normal)
        }
    }
    
    func formatDate(date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a | dd.MM.yyyy"
        let selectedDate: String = formatter.string(from: date)
        return selectedDate
    }
    
    func getDate(taskDate: String) -> Date?{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a | dd.MM.yyyy"
        let date = formatter.date(from: taskDate)
        return date
        
    }
    
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
}


//MARK: UI Setups
extension CreateTaskViewController{
    
    fileprivate func topBarSetup() {
        topBarView.clipsToBounds = true
        topBarView.layer.cornerRadius = 22
        topBarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    fileprivate func createButtonSetup() {
        createButton.layer.cornerRadius = createButton.frame.size.height / 2
        createButton.layer.masksToBounds = true
    }
    
    fileprivate func mainTitleSetup() {
        mainTitleTextField.layer.cornerRadius = 18
        mainTitleTextField.layer.masksToBounds = true
        mainTitleTextField.layer.borderWidth = 1
        mainTitleTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    fileprivate func subTitleSetup() {
        subTitle.layer.cornerRadius = 18
        subTitle.layer.masksToBounds = true
        subTitle.layer.borderWidth = 1
        subTitle.layer.borderColor = UIColor.black.cgColor
       
    }
    
    fileprivate func backButtonSetup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        BackButton.isUserInteractionEnabled = true
        BackButton.addGestureRecognizer(tap)
    }
    
    fileprivate func datePickerSetup() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        self.date = formatDate(date: Date())
    }
}
