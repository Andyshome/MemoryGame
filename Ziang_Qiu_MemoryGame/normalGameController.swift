//
//  normalGameController.swift
//  Ziang_Qiu_MemoryGame
//
//  Created by Qiu Ziang on 2018/4/19.
//  Copyright © 2018年 skylove. All rights reserved.
//

import UIKit

class normalGameController: normalModeNameController {
    
    let pic = [#imageLiteral(resourceName: "ali"),#imageLiteral(resourceName: "ali"),#imageLiteral(resourceName: "bitnami"),#imageLiteral(resourceName: "bitnami"),#imageLiteral(resourceName: "atom"),#imageLiteral(resourceName: "atom"),#imageLiteral(resourceName: "aws"),#imageLiteral(resourceName: "aws"),#imageLiteral(resourceName: "azure"),#imageLiteral(resourceName: "azure"),#imageLiteral(resourceName: "gcp"),#imageLiteral(resourceName: "gcp"),#imageLiteral(resourceName: "qiniu"),#imageLiteral(resourceName: "qiniu"),#imageLiteral(resourceName: "tencent"),#imageLiteral(resourceName: "tencent")]
    
    var gameImage:[UIImage] = []
    
    var temp1:UIButton? = nil
    var temp2:UIButton? = nil
    var tryTimes = 0
    var resultMark = 0
    var flag = 0
    var pairedNumber = 0
    var playerName:String = ""
    @IBOutlet weak var nameTextLable: UILabel!
    @IBOutlet weak var tryTimesLable: UILabel!
    @IBOutlet weak var pointValueText: UILabel!
    @IBOutlet weak var giveUpButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    
    
    
    
    // function for match buttons
    func matchButtonScore(firstButton:UIButton,secondButton:UIButton) -> Int {
        // if the image is exactly same
        if firstButton.image(for: .normal) == secondButton.image(for: .normal) {
            // you get 1
            return 1
        }
        // you get 0
        return 0
    }
    
    
    
    // find the button which is clicked
    func findButtonClick(buttonInput:UIButton) -> Int {
        // set the buttons array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
        ,button12,button13,button14,button15,button16]
        // set the flag which is needed return
        var flagFunc = 0
        // find it
        while flagFunc < buttons.count {
            if buttons[flagFunc] == buttonInput {
                // retrun value
                return flagFunc
            }
            // change flag
            flagFunc += 1
        }
        // defualt
        return 0
    }
    
    
    override func viewDidLoad() {
        // get the function tool set
        let functiontools = functools()
        super.viewDidLoad()
        // set the name
        nameTextLable.text=playerName
        // change the gameimage array
        gameImage = functiontools.shuffle(origin: pic)
        // change the new game button
        newGameButton.isUserInteractionEnabled = false
        // change the colour
        newGameButton.alpha = 0.4
        // set the save data place if do not creat
        if UserDefaults.standard.object(forKey: "nomalMode") == nil {
            // set array list
            let arrayList = [String]()
            // print
            print("success")
            // set the default
            UserDefaults.standard.set(arrayList, forKey: "nomalMode")
        }
    }
    
    
    // compare when second the button is clicked
    func compare(firstButton:UIButton,secondButton:UIButton)  {
        // find the position
        let position = findButtonClick(buttonInput: secondButton)
        
        //change the image
        
        UIView.transition(with: secondButton, duration: 0.3, options: .transitionFlipFromBottom, animations: {secondButton.setImage(self.gameImage[position], for: .normal)}, completion: nil)
        // do these actions with a delay
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            // if success
            if secondButton.image(for: .normal)  == firstButton.image(for: .normal){
                // set the button is hidden
                secondButton.isHidden = true
                // set the button
                firstButton.isHidden = true
                // plus one flag
                self.flag += 1
                // get the score
                self.resultMark += 2 * self.flag
                // set the pointvalue text
                self.pointValueText.text = String(self.resultMark)
            } else {
                // fail then change the image
                secondButton.setImage(#imageLiteral(resourceName: "Github"), for: .normal)
                firstButton.setImage(#imageLiteral(resourceName: "Github"), for: .normal)
                // set the flag is 0
                self.flag = 0
            }
        }
    }
    
    
    // find the button click result
    @IBAction func buttonClicked(_ sender:UIButton) {
        // if the first time try
        if temp1 == nil {
            // if it is not the first time play this game
            if tryTimes > 1 {
                // pretend to change image that do not exist
                guard temp2!.image(for: .normal) == #imageLiteral(resourceName: "Github")||temp2!.isHidden else {return}
                // set sender to temp1
                temp1 = sender
                // change the image of the button
                UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromBottom, animations: {sender.setImage(self.gameImage[self.findButtonClick(buttonInput: sender)], for: .normal)}, completion: nil)
                // try times plus one
                tryTimes += 1
                // set the text lable
                tryTimesLable.text = String(tryTimes)
            } else {
                // set the sender as temp
                temp1 = sender
                // change image
                UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromBottom, animations: {sender.setImage(self.gameImage[self.findButtonClick(buttonInput: sender)], for: .normal)}, completion: nil)
                // try times plus one
                tryTimes += 1
                // change the try times lable
                tryTimesLable.text = String(tryTimes)
            }
        } else {
            // pretend to click twice
            guard sender != temp1! else {return}
            // plus one try times
            tryTimes += 1
            // change the text lable
            tryTimesLable.text = String(tryTimes)
            // compare
            compare(firstButton: temp1!, secondButton: sender)
            // change the paired number
            pairedNumber += matchButtonScore(firstButton: temp1!, secondButton: sender)
            // test
            print(pairedNumber)
            //finish the game, and give alert
            if pairedNumber == 8 {
                // delay to present
                DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
                    // test
                    print("finish")
                    // change the button
                    self.giveUpButton.isUserInteractionEnabled = false
                    // change the button
                    self.newGameButton.isUserInteractionEnabled = true
                    // alert
                    let alert = UIAlertController(title: "Finish", message: "You got \(self.resultMark) in this game", preferredStyle: .alert)
                    // alert
                    let action = UIAlertAction(title: "Try again!", style: .default, handler: nil)
                    // act the alert
                    alert.addAction(action)
                    //present
                    self.present(alert, animated: true,completion: nil)
                    // change the button
                    self.newGameButton.isUserInteractionEnabled = true
                    //change the colour
                    self.newGameButton.alpha = 1
                    // change the button
                    self.giveUpButton.isUserInteractionEnabled = false
                    // change the colour
                    self.giveUpButton.alpha = 0.4
                    // save the data
                    self.saveData(data: self.playerName+":"+String(self.resultMark))
                }
                
            }
            // save the sender to temp
            temp2 = sender
            //reset the temp1
            temp1 = nil
            
            
        }
    }
    
    @IBAction func giveUp(_ sender: Any) {
        // set the button array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // set the delay
        var delay = 0.3
        // set the give up button could not be used
        giveUpButton.isUserInteractionEnabled = false
        //set the colour
        giveUpButton.alpha = 0.4
        // translate the image
        for i in 0...7 {
            // change the image
            DispatchQueue.main.asyncAfter(deadline: .now()+delay){
                // translate the image with animation
                UIView.transition(with: buttons[i], duration: 0.5, options:.transitionFlipFromBottom, animations: {buttons[i].setImage(self.gameImage[i], for : .normal)}, completion: nil)
                // same
                UIView.transition(with: buttons[15-i], duration: 0.5, options:.transitionFlipFromBottom, animations: {buttons[15-i].setImage(self.gameImage[15-i], for : .normal)}, completion: nil)
                
            }
                //set the buttons could not be used
                buttons[15-i].isUserInteractionEnabled = false
                // set the buttons could not be used
                buttons[i].isUserInteractionEnabled = false
                // get the delay
                delay += 0.3
            
        }
        // set the delay
        DispatchQueue.main.asyncAfter(deadline: .now()+delay ){
            // change the button
        self.newGameButton.isUserInteractionEnabled = true
            //change the colour
        self.newGameButton.alpha = 1
        }
    }
    // new game button
    @IBAction func newGame(_ sender: Any) {
        // get the function tools set
        let functionTools = functools()
        // set the array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // for loorp to change the image of each button and set them could be used
        for i in 0...15 {
            // show the buttons
            buttons[i].isHidden = false
            // set the image
            buttons[i].setImage(#imageLiteral(resourceName: "Github"), for: .normal)
            // set the button could be used
            buttons[i].isUserInteractionEnabled = true
        }
        // set the give up button
        giveUpButton.isUserInteractionEnabled = true
        // shuffle the pictures array
        gameImage = functionTools.shuffle(origin: pic)
        // reset
        tryTimesLable.text = "0"
        // reset
        pointValueText.text = "0"
        // reset
        tryTimes = 0
        // reset
        resultMark = 0
        // reset
        flag = 0
        // reset
        pairedNumber = 0
        // reset
        newGameButton.isUserInteractionEnabled = false
        // reset
        newGameButton.alpha = 0.4
        // reset
        giveUpButton.isUserInteractionEnabled = true
        // reset
        giveUpButton.alpha = 1
        // reset
    }
    
    
    func saveData(data:String) {
        // load the data before
        guard let arrayListObject = UserDefaults.standard.object(forKey: "nomalMode") else {
            print("error")
            return
        }
        // get the array
        guard var arrayList = arrayListObject as? Array<String> else {
            return
        }
        // append the data
        arrayList.append(data)
        // save the data to user defaults
        UserDefaults.standard.set(arrayList, forKey: "nomalMode")
        // call the notification center
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nomal"), object: nil)
        // print
        print("success")
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
