//
//  timeModeNameController.swift
//  Ziang_Qiu_MemoryGame
//
//  Created by Qiu Ziang on 2018/4/23.
//  Copyright © 2018年 skylove. All rights reserved.
//

import UIKit

class timeModeNameController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
   
    
    
    // send the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // send the name data to the destination
        let send = segue.destination as? timeGameController
        // send data
        send?.playerName = self.nameText.text!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
