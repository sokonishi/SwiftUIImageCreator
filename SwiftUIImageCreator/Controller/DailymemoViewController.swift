//
//  DailymemoViewController.swift
//  SwiftUIImageCreator
//
//  Created by 小西壮 on 2021/03/19.
//

import UIKit
import RealmSwift

class DailymemoViewController: UIViewController {

    let reportDatabase = ReportDatebase()
    
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var purposeTextField: UITextField!
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
    
        print("registerButton")
        if (placeTextField.text != "" && purposeTextField.text != "" && todoTextField.text != "" && detailTextField.text != ""){
            
            reportDatabase.create(placeName: placeTextField.text!, purposeText: purposeTextField.text!, todoText: todoTextField.text!, detailText: detailTextField.text!)
            
            reportDatabase.database.removeAll()
            reportDatabase.getAll()
            
            placeTextField.text = ""
            purposeTextField.text = ""
            todoTextField.text = ""
            detailTextField.text = ""
            
            print(reportDatabase.database)
        }
        
    }
    
}

extension DailymemoViewController {
    
    func setDismissKeyboard() {
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
