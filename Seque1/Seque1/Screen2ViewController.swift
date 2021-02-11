//
//  Screen2ViewController.swift
//  Seque1
//
//  Created by Krystyna Waniova on 27/10/2020.
//

import UIKit

class Screen2ViewController: UIViewController {

    @IBOutlet weak var display2: UILabel!
    
    var intNumber2 = 0 {
        didSet{
            display2?.text = String(intNumber2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        display2.text = String(intNumber2);
        print("Screen2 viewController allocated");

    }
    

    @IBAction func increaseByOne() {
        intNumber2 = intNumber2 + 1;
    }
    
    @IBAction func decreaseByOne() {
        intNumber2 = intNumber2 - 1;
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        print("Scree2 viewController deallocated")
    }

}
