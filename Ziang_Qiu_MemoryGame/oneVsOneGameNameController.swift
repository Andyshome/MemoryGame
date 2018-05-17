//
//  oneVsOneGameNameController.swift
//  Ziang_Qiu_MemoryGame
//
//  Created by Qiu Ziang on 2018/4/25.
//  Copyright © 2018年 skylove. All rights reserved.
//

import UIKit

class oneVsOneGameNameController: UIViewController {

    @IBOutlet weak var nameText1: UITextField!
    @IBOutlet weak var nameText2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // set the destination
        let send = segue.destination as? oneVsOneGameController
        // send the data 
        send?.playerName1 = self.nameText1.text!
        send?.playerName2 = self.nameText2.text!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
