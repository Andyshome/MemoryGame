//
//  normalModeNameBoard.swift
//  Ziang_Qiu_MemoryGame
//
//  Created by Qiu Ziang on 2018/4/18.
//  Copyright © 2018年 skylove. All rights reserved.
//

import UIKit

class normalModeNameController: UIViewController {
    
    @IBOutlet weak var start: UIButton!
    
    @IBOutlet weak var nameText: UITextField!
    
   // button to show the next view controller
    @IBAction func startAction(_ sender: Any) {
        // pretend to put a nil value which the user do not input anything
        guard nameText.text != nil else {return}
        // test
        print(nameText.text!)
        // perform segue
        performSegue(withIdentifier: "normal", sender: start)
        
    }
    // send the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // find the destination
        let send = segue.destination as? normalGameController
        
        // send the data 
        send?.playerName=self.nameText.text!
        
    }
    
    
    
}
