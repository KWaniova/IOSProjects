//
//  MyViewController.swift
//  Calculator
//
//  Created by Krystyna Waniova on 25/10/2020.
//

import UIKit

class MyViewController: UIViewController {
    
    var displayedText = "" {
        didSet {
            display?.text = String(displayedText);
        }
    }

    @IBOutlet weak var display: UILabel!
    
//    @IBOutlet weak var display0: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //display.text = "9"
        // Do any additional setup after loading the view.
//        display0?.addTarget(self, action: #selector(handleTapNumber(_:)), for: .touchUpInside)
    }
    
    
    @IBAction func handleTapNumber(_ sender: UIButton) {
        display.text = sender.currentTitle
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
