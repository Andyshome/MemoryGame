//
//  timeGameController.swift
//  Ziang_Qiu_MemoryGame
//
//  Created by Qiu Ziang on 2018/4/23.
//  Copyright © 2018年 skylove. All rights reserved.
//

import UIKit

class timeGameController: UIViewController {
    
    let pic = [#imageLiteral(resourceName: "ali"),#imageLiteral(resourceName: "ali"),#imageLiteral(resourceName: "bitnami"),#imageLiteral(resourceName: "bitnami"),#imageLiteral(resourceName: "atom"),#imageLiteral(resourceName: "atom"),#imageLiteral(resourceName: "aws"),#imageLiteral(resourceName: "aws"),#imageLiteral(resourceName: "azure"),#imageLiteral(resourceName: "azure"),#imageLiteral(resourceName: "gcp"),#imageLiteral(resourceName: "gcp"),#imageLiteral(resourceName: "qiniu"),#imageLiteral(resourceName: "qiniu"),#imageLiteral(resourceName: "tencent"),#imageLiteral(resourceName: "tencent")]
    
    var gameImage:[UIImage] = []
    
    var temp1:UIButton? = nil
    var temp2:UIButton? = nil
    var tryTimes = 0
    var resultMark = 0
    var flag = 0
    var pairedNumber = 0
    var playerName:String = ""
    var second = 60
    var TIMER = Timer()
    @IBOutlet weak var nameTextLable: UILabel!
    @IBOutlet weak var TimesLable: UILabel!
    @IBOutlet weak var pointValueText: UILabel!
    @IBOutlet weak var giveUpButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
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
    
    
    // define the function of clock, use objective-c
    @objc func clock() {
        // when we call this fuction the second decrease 1
        second -= 1
        // change the textview of the time
        TimesLable.text = String(second)
        // when times up do these actions
        if (second==0) {
            // set an alert
            let alert = UIAlertController(title: "Finish", message: "Times up!You loss!", preferredStyle: .alert)
            // set an alert
            let action = UIAlertAction(title: "Try again!", style: .default, handler: nil)
            // send the alert
            alert.addAction(action)
            //present it
            self.present(alert, animated: true,completion: nil)
            // set the game button could use
            newGameButton.isUserInteractionEnabled = true
            //change the color
            newGameButton.alpha = 1
            //set the give up button cloud not be used
            giveUpButton.isUserInteractionEnabled = false
            // change the color of button
            giveUpButton.alpha = 0.4
            // set the game button could not be used
            let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
                ,button12,button13,button14,button15,button16]
            for i in 0...15 {
                // set the button
                buttons[i].isUserInteractionEnabled = false
            }
            // stop the time
            TIMER.invalidate()
        }
        
    }
    
    
    
    
    
    // give the extra value base on different time
    func timeExtraScore() -> Int {
        switch second {
            // give 6 times of value
        case 50...60:
            // return
            return 6
            // give 5 times of value
        case 40...50:
            //return
            return 5
            //give 4 times value
        case 30...40:
            //return
            return 4
            //give 3 times value
        case 20...30:
            // return
            return 3
            //give 2 times value
        case 10...20:
            //return
            return 2
            // do not have extra score
        default:
            // return
            return 1
        }
        
    }
    
    
    // when the image is the same change the pair numebr
    func matchButtonScore(firstButton:UIButton,secondButton:UIButton) -> Int {
        // compare the two images
        if firstButton.image(for: .normal) == secondButton.image(for: .normal) {
            // return 1 if the two iamges are exactly same
            return 1
        }
        // it is not same
        return 0
    }
    
    
    
    // to find which button is clicked then you can change the image
    func findButtonClick(buttonInput:UIButton) -> Int {
        // set the array of buttons
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        //give a flag to return
        var flagFunc = 0
        // return the value when the button is found
        while flagFunc < buttons.count {
            
            // find the position
            if buttons[flagFunc] == buttonInput {
                return flagFunc
            }
            //flag + 1
            flagFunc += 1
        }
        // if it is not found(impossible)
        return 0
    }
    
    // when the view is loarded prepare for the game
    override func viewDidLoad() {
        // load it
        super.viewDidLoad()
        // set the player name
        nameTextLable.text=playerName
        // set the array of buttons
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        //set the button could not used until the start
        for i in 0...15 {
            // set
            buttons[i].isUserInteractionEnabled = false
        }
        // set the new game button could not be used
        newGameButton.isUserInteractionEnabled = false
        //change the colour
        newGameButton.alpha = 0.4
        // set the give up button could not be used
        giveUpButton.isUserInteractionEnabled = false
        // change the colour
        giveUpButton.alpha = 0.4
        // set the time mode save memory defualt
        if UserDefaults.standard.object(forKey: "timeMode") == nil {
            // set the arraylist
            let arrayList = [String]()
            //test
            print("success to add a key")
            // save the value
            UserDefaults.standard.set(arrayList,forKey: "timeMode")
        }
    }

        
    
    // when there are 2 buttons clicked, we should 
    func compare(firstButton:UIButton,secondButton:UIButton)  {
        // find the position which i have to change button
        let position = findButtonClick(buttonInput: secondButton)
        //change the image of the button
        UIView.transition(with: secondButton, duration: 0.3, options: .transitionFlipFromBottom, animations: {secondButton.setImage(self.gameImage[position], for: .normal)}, completion: nil)
        // do this thing a little bit after
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            // compare the image if it is same
            if secondButton.image(for: .normal)  == firstButton.image(for: .normal){
                // hide the button
                secondButton.isHidden = true
                // hide the button
                firstButton.isHidden = true
                // flag += 1
                self.flag += 1
                //give the mark base on time
                self.resultMark += 2 * self.flag * self.timeExtraScore()
                // give the point to the text view
                self.pointValueText.text = String(self.resultMark)
            } else {
                // if it is not same , just change back
                secondButton.setImage(#imageLiteral(resourceName: "Github"), for: .normal)
                // change back
                firstButton.setImage(#imageLiteral(resourceName: "Github"), for: .normal)
                // reset the flag
                self.flag = 0
            }
        }
    }
    
    
    // find the button is clicked
    @IBAction func buttonClicked(_ sender:UIButton) {
        // when it is first click the button
        if temp1 == nil {
            // if it is not the first time play this game
            if tryTimes > 1 {
                // return if the last turn change is not finished
                guard temp2!.image(for: .normal) == #imageLiteral(resourceName: "Github")||temp2!.isHidden else {return}
                // set the temp1 is this button
                temp1 = sender
                //change the image for this program
                UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromBottom, animations: {sender.setImage(self.gameImage[self.findButtonClick(buttonInput: sender)], for: .normal)}, completion: nil)
                // plus one more time
                tryTimes += 1
                // if it is the first tme play the game
            } else {
                // do not have protection of change image
                temp1 = sender
                //change the image of the button
                UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromBottom, animations: {sender.setImage(self.gameImage[self.findButtonClick(buttonInput: sender)], for: .normal)}, completion: nil)
                //plus one more time
                tryTimes += 1
            }
        } else {
            // could not click one button two times
            guard sender != temp1! else {return}
            //compare the two sender
            compare(firstButton: temp1!, secondButton: sender)
            // plus pair number
            pairedNumber += matchButtonScore(firstButton: temp1!, secondButton: sender)
            print(pairedNumber)
            // if finish
            if pairedNumber == 8 {
                //delay
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    print("finish")
                    // change the button
                    self.giveUpButton.isUserInteractionEnabled = false
                    //same
                    self.newGameButton.isUserInteractionEnabled = true
                    //set alert
                    let alert = UIAlertController(title: "Finish", message: "You got \(self.resultMark) in this game", preferredStyle: .alert)
                    //set alert
                    let action = UIAlertAction(title: "Try again!", style: .default, handler: nil)
                    //do it
                    alert.addAction(action)
                    // present
                    self.present(alert, animated: true,completion: nil)
                    // change the new game button
                    self.newGameButton.isUserInteractionEnabled = true
                    // change the colour
                    self.newGameButton.alpha = 1
                    // change the give up button
                    self.giveUpButton.isUserInteractionEnabled = false
                    // change the colout
                    self.giveUpButton.alpha = 0.4
                    // save data , call the functoon
                    self.saveData(data: self.playerName+":"+String(self.resultMark))
                    // stop the clock
                    self.TIMER.invalidate()
                }
            }
            // set the temp as the sender
            temp2 = sender
            //reset the t
            temp1 = nil
            // plus one trytimes
            tryTimes += 1
        }
    }
    
    
    // give up button
    @IBAction func giveUp(_ sender: Any) {
        // set a button array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // set a delay
        var delay = 0.3
        // change the image for every buttons
        for i in 0...7 {
            // one by one
            DispatchQueue.main.asyncAfter(deadline: .now()+delay){
                // change image from first
                UIView.transition(with: buttons[i], duration: 0.5, options:.transitionFlipFromBottom, animations: {buttons[i].setImage(self.gameImage[i], for : .normal)}, completion: nil)
                // change image from last
                UIView.transition(with: buttons[15-i], duration: 0.5, options:.transitionFlipFromBottom, animations: {buttons[15-i].setImage(self.gameImage[15-i], for : .normal)}, completion: nil)
                
            }
            // set the button could not be used
            buttons[15-i].isUserInteractionEnabled = false
            //same
            buttons[i].isUserInteractionEnabled = false
            // plus delay time
            delay += 0.3
            
        }
        // set the give up button could not be used
        giveUpButton.isUserInteractionEnabled = false
        //change the colour
        giveUpButton.alpha = 0.4
        //after every image is changed , you can use the new game button
        DispatchQueue.main.asyncAfter(deadline: .now()+delay){
            self.newGameButton.isUserInteractionEnabled = true
            self.newGameButton.alpha = 1
        }
        // stop clock
        TIMER.invalidate()
        
    }
    // new game button
    @IBAction func newGame(_ sender: Any) {
        // get the tool from function set
        let functionTools = functools()
        // set the button array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // show every button
        for i in 0...15 {
            buttons[i].isHidden = false
            buttons[i].setImage(#imageLiteral(resourceName: "Github"), for: .normal)
        }
        // change the give up button
        giveUpButton.isUserInteractionEnabled = true
        //change the game image set
        gameImage = functionTools.shuffle(origin: pic)
        // reset score text
        pointValueText.text = "0"
        // reset try times
        tryTimes = 0
        //reset the mark
        resultMark = 0
        //reset the flag
        flag = 0
        // reset paired number
        pairedNumber = 0
        //reset
        newGameButton.isUserInteractionEnabled = false
        //reset
        newGameButton.alpha = 0.4
        //reset
        giveUpButton.isUserInteractionEnabled = false
        //reset
        giveUpButton.alpha = 0.4
        //reset
        startButton.isUserInteractionEnabled = true
        //reset
        startButton.alpha = 1
        //reset
        second = 60
        //reset
        TimesLable.text = String(second)
    }
    
    
    
    @IBAction func startGame(_ sender: Any) {
        // set the buttons array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // get the image set
        let functiontools = functools()
        //shuffle the image
        gameImage = functiontools.shuffle(origin: pic)
        //set the game button could be used
        for i in 0...15 {
            buttons[i].isUserInteractionEnabled = true
        }
        // set the clock
        TIMER = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(timeGameController.clock), userInfo: nil, repeats: true)
        // change the button
        startButton.isUserInteractionEnabled = false
        //change the color
        startButton.alpha = 0.4
        
        // change the button
        giveUpButton.isUserInteractionEnabled = true
        // change the color
        giveUpButton.alpha = 1
        // change the button
        newGameButton.isUserInteractionEnabled = false
        //change the colour
        newGameButton.alpha = 0.4
       
    }
    
    
    // save the data
    func saveData(data:String) {
        // prevent there is empty timeMode
        guard let arrayListObject = UserDefaults.standard.object(forKey: "timeMode") else {
            //test
            print("error")
            //return
            return
        }
        // make sure the list is a array string
        guard var arrayList = arrayListObject as? Array<String> else {
            return
        }
        // input data
        arrayList.append(data)
        // save
        UserDefaults.standard.set(arrayList, forKey: "timeMode")
        // let leaderboard know there is new data
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "time"), object: nil)
        print("success")
    
    
    

    }

    

}

