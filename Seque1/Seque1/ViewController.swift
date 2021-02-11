//
//  ViewController.swift
//  Seque1
//
//  Created by Krystyna Waniova on 27/10/2020.
//

import UIKit

class Screen1ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField1.delegate = self;
    }

    @IBAction func hideKeyboard(_ sender: UITextField) {
        
        sender.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    @IBAction func backgroundTapped() {
        view.endEditing(true);
    }
    
    @IBAction func onTextField1Change(_ sender: UITextField) {
        if let number = Int(sender.text)
    }
}

