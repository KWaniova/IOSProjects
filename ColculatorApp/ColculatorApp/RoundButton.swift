//
//  RoundButton.swift
//  ColculatorApp
//
//  Created by Krystyna Waniova on 10/11/2020.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

//    @IBInspectable var color: UIColor = UIColor.orange{
//        didSet {
//            self.backgroundColor = color;
//        }
//    }
    
    var roundButton: Bool = true {
        didSet{
            if roundButton {
                layer.cornerRadius = frame.height / 2;
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        
            if roundButton {
                layer.cornerRadius = frame.height / 2;
            }
//        self.backgroundColor = color;
    }
    

}
