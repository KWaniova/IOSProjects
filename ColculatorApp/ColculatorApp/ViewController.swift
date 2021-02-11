//
//  ViewController.swift
//  ColculatorApp
//
//  Created by Krystyna Waniova on 10/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        display?.text = String(12);
    }


}

