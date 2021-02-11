//
//  ViewController.swift
//  Seque1
//
//  Created by Krystyna Waniova on 27/10/2020.
//

import UIKit

class Screen1ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var display1: UILabel!
    
    var intNumber1 = 0 {
        didSet {
            display1?.text = String(intNumber1)
        }
    }
    
    @IBOutlet weak var textField1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField1.delegate = self;
        print("Screen1 viewController allocated");
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
        if let text = sender.text, let number = Int(text){
            intNumber1 = number
            display1.text = String(intNumber1)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dVC = segue.destination as? Screen2ViewController{
        dVC.intNumber2 = intNumber1;
        }
    }
    
    @IBAction func comeBackFromScreen2(segue: UIStoryboardSegue){
        
        let sVC = segue.source as! Screen2ViewController;
        intNumber1 = sVC.intNumber2;
        textField1.text = String(intNumber1);
        
    }
    
    deinit {
        print("Screen1 viewController deallocated")
    }
}

