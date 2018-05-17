//
//  oneVsOneGameController.swift
//  Ziang_Qiu_MemoryGame
//
//  Created by Qiu Ziang on 2018/4/27.
//  Copyright © 2018年 skylove. All rights reserved.
//
import UIKit

class oneVsOneGameController: UIViewController {
    
    let pic = [#imageLiteral(resourceName: "ali"),#imageLiteral(resourceName: "ali"),#imageLiteral(resourceName: "bitnami"),#imageLiteral(resourceName: "bitnami"),#imageLiteral(resourceName: "atom"),#imageLiteral(resourceName: "atom"),#imageLiteral(resourceName: "aws"),#imageLiteral(resourceName: "aws"),#imageLiteral(resourceName: "azure"),#imageLiteral(resourceName: "azure"),#imageLiteral(resourceName: "gcp"),#imageLiteral(resourceName: "gcp"),#imageLiteral(resourceName: "qiniu"),#imageLiteral(resourceName: "qiniu"),#imageLiteral(resourceName: "tencent"),#imageLiteral(resourceName: "tencent")]
    
    @IBOutlet weak var user2Arrow: UIImageView!
    @IBOutlet weak var user1Arrow: UIImageView!
    var gameImage:[UIImage] = []
    var playerMode = 1
    var temp1:UIButton? = nil
    var temp2:UIButton? = nil
    var tryTimes = 0
    var resultMark1 = 0
    var resultMark2 = 0
    var flag = 0
    var pairedNumber = 0
    var playerName1:String = ""
    var playerName2:String = ""
    var winner = ""
    
    
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    
    @IBOutlet weak var nameTextLable1: UILabel!
    @IBOutlet weak var nameTextLable2: UILabel!
    @IBOutlet weak var pointValueText1: UILabel!
    @IBOutlet weak var pointValueText2: UILabel!
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
    
    
    
    
    
    // compare two button's image
    func matchButtonScore(firstButton:UIButton,secondButton:UIButton) -> Int {
        // if there are the same image return 1
        if firstButton.image(for: .normal) == secondButton.image(for: .normal) {
                return 1
        }
        // if they are not same ,return 0
        return 0
    }
    
    
    
    // find the button where is clicked
    func findButtonClick(buttonInput:UIButton) -> Int {
        // set the buttons array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // set the flag
        var flagFunc = 0
        // find the button
        while flagFunc < buttons.count {
            // give the position of the button
            if buttons[flagFunc] == buttonInput {
                // return the positoon of the button
                return flagFunc
            }
            // flag plus one
            flagFunc += 1
        }
        // defualt
        return 0
    }
    
    
    override func viewDidLoad() {
        // set the function tools
        let functiontools = functools()
        // load view
        super.viewDidLoad()
        // set the text table of name
        nameTextLable1.text = playerName1
        // set the text table of name2
        nameTextLable2.text = playerName2
        // shuffle the game image array
        gameImage = functiontools.shuffle(origin: pic)
        // set the new game button could not be used
        newGameButton.isUserInteractionEnabled = false
        // change the new game button color
        newGameButton.alpha = 0.4
        // when is player 1 turn , set its colour as red
        name1.textColor = UIColor.red
        // set the player mode
        playerMode = 1
        // let user2 arrow could not be seen
        user2Arrow.alpha = 0
    }
    
    
    // compare two buttons picture
    func compare(firstButton:UIButton,secondButton:UIButton)  {
        // find the positon of second button
        let position = findButtonClick(buttonInput: secondButton)
        // change the image of second button with animation
        UIView.transition(with: secondButton, duration: 0.3, options: .transitionFlipFromBottom, animations: {secondButton.setImage(self.gameImage[position], for: .normal)}, completion: nil)
        //delay the actions
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            // compare the two images
            if secondButton.image(for: .normal)  == firstButton.image(for: .normal){
                // hide two buttons
                secondButton.isHidden = true
                firstButton.isHidden = true
                // flag plus one
                self.flag += 1
                
                // select mode and change mdoe
                if self.playerMode == 1 {
                    // mode 1
                    self.resultMark1 += 2 * self.flag
                    //mode 1
                    self.pointValueText1.text = String(self.resultMark1)
                } else {
                    //mode 2
                    self.resultMark2 += 2 * self.flag
                    //mode 2
                    self.pointValueText2.text = String(self.resultMark2)
                }
                
            } else {
                //change image to onriginal
                secondButton.setImage(#imageLiteral(resourceName: "Github"), for: .normal)
                firstButton.setImage(#imageLiteral(resourceName: "Github"), for: .normal)
                self.flag = 0
                // change the player mode
                if self.playerMode == 1 {
                    // change the mode to 2
                    self.playerMode = 2
                    // change the mode to 2
                    self.name1.textColor = UIColor.black
                    // change the mode to 2
                    self.name2.textColor = UIColor.red
                    // change the mode to 2
                    self.user1Arrow.alpha = 0
                    // change the mode to 2
                    self.user2Arrow.alpha = 1
                    // change the mode to 2
                } else {
                    // change the mode to 1
                    self.playerMode = 1
                    // change the mode to 1
                    self.name1.textColor = UIColor.red
                    // change the mode to 1
                    self.name2.textColor = UIColor.black
                    // change the mode to 1
                    self.user1Arrow.alpha = 1
                    // change the mode to 1
                    self.user2Arrow.alpha = 0
                }
            }
        }
    }
    
    
    // click the button to change image and compare
    @IBAction func buttonClicked(_ sender:UIButton) {
        // first time click
        if temp1 == nil {
            // not the first time play the game
            if tryTimes > 1 {
                // pretend do not finish before game
                guard temp2!.image(for: .normal) == #imageLiteral(resourceName: "Github")||temp2!.isHidden else {return}
                // send the sender to temp1
                temp1 = sender
                // change the image of the button
                UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromBottom, animations: {sender.setImage(self.gameImage[self.findButtonClick(buttonInput: sender)], for: .normal)}, completion: nil)
                // try times plus one
                tryTimes += 1
            } else {
                // first play this game , let the sender equal to temp1
                temp1 = sender
                // change the image of the butoon
                UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromBottom, animations: {sender.setImage(self.gameImage[self.findButtonClick(buttonInput: sender)], for: .normal)}, completion: nil)
                // plus one tryTimes
                tryTimes += 1
            }
        } else {
            // pretend use the same button of first one
            guard sender != temp1! else {return}
            // try times plus one
            tryTimes += 1
            // compare two buttons , get score
            compare(firstButton: temp1!, secondButton: sender)
            
            // change the paired number if match plus one , if it is not match plus 0
            pairedNumber += matchButtonScore(firstButton: temp1!, secondButton: sender)
            //test
            print(pairedNumber)
            // if pairedNumber is 8 means the game is over
            if pairedNumber == 8 {
                // delay 0.8 seconds
                DispatchQueue.main.asyncAfter(deadline: .now()+0.8){
                    // test
                    print("finish")
                    // find who wins this game
                    if self.resultMark1 > self.resultMark2 {
                        // player1 win
                        self.winner = "player1 win this game!"
                    } else if self.resultMark2 > self.resultMark1 {
                        // player2 win
                        self.winner = "player2 win this game!"
                        // set another position
                    } else {
                        // if they get the same score , shows tie
                        self.winner = "tie!"
                    }
                    // set the alert
                    let alert = UIAlertController(title: "Finish", message: "\(self.winner) \n \(self.playerName1) got \(self.resultMark1) in this game\n \(self.playerName2) got \(self.resultMark2) in this game", preferredStyle: .alert)
                    // set the alert
                    let action = UIAlertAction(title: "Try again!", style: .default, handler: nil)
                    // alert it
                    alert.addAction(action)
                    // present the alert
                    self.present(alert, animated: true,completion: nil)
                    // change the new game button could be used
                    self.newGameButton.isUserInteractionEnabled = true
                    // change the new game button colour
                    self.newGameButton.alpha = 1
                    // change the give up button could not be used
                    self.giveUpButton.isUserInteractionEnabled = false
                    // change the give up button colour
                    self.giveUpButton.alpha = 0.4
                }
            }
            // make the temp2 as the sender
            temp2 = sender
            // reset the temp1
            temp1 = nil
            
            
        }
    }
    
    
    // give up button action
    @IBAction func giveUp(_ sender: Any) {
        // set the array of the buttons
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // set a delay
        var delay = 0.3
        //change the image
        for i in 0...7 {
            // delay to get the one by one
            DispatchQueue.main.asyncAfter(deadline: .now()+delay){
                // change the image one by one
                UIView.transition(with: buttons[i], duration: 0.5, options:.transitionFlipFromBottom, animations: {buttons[i].setImage(self.gameImage[i], for : .normal)}, completion: nil)
                // change the image one by one
                UIView.transition(with: buttons[15-i], duration: 0.5, options:.transitionFlipFromBottom, animations: {buttons[15-i].setImage(self.gameImage[15-i], for : .normal)}, completion: nil)
                
            }
            // set the buttons are not used
            buttons[15-i].isUserInteractionEnabled = false
            //set the buttons are not used
            buttons[i].isUserInteractionEnabled = false
            // give it a delay
            delay += 0.3
            
        }
        // set the give up button could not be used
        giveUpButton.isUserInteractionEnabled = false
        // change the colour of the button
        giveUpButton.alpha = 0.4
        ///delay to set the new game button could be used
        DispatchQueue.main.asyncAfter(deadline: .now()+delay){
            // set the new game button could be used
            self.newGameButton.isUserInteractionEnabled = true
            // change the bew game button colour
            self.newGameButton.alpha = 1
        }
    }
    // new game button
    @IBAction func newGame(_ sender: Any) {
        // get the fuctions tools
        let functionTools = functools()
        // set the buttons array
        let buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11
            ,button12,button13,button14,button15,button16]
        // show every buttons
        for i in 0...15 {
            // show the buttons
            buttons[i].isHidden = false
            // set the image for each buttons
            buttons[i].setImage(#imageLiteral(resourceName: "Github"), for: .normal)
        }
        // set the give up button could be used
        giveUpButton.isUserInteractionEnabled = true
        // shuffle the image to make the game image array
        gameImage = functionTools.shuffle(origin: pic)
        // reset
        pointValueText1.text = "0"
        // reset
        pointValueText2.text = "0"
        // reset
        tryTimes = 0
        // reset
        resultMark1 = 0
        // reset
        resultMark2 = 0
        // reset
        flag = 0
        // reset
        pairedNumber = 0
        // reset
        newGameButton.isUserInteractionEnabled = false
        // change the colour of the button
        newGameButton.alpha = 0.4
        // change the button could be used
        giveUpButton.isUserInteractionEnabled = true
        //change the colour of the button
        giveUpButton.alpha = 1
        // change the mode to palyer1
        playerMode = 1
        // change the text colour of name 1 text
        name1.textColor = UIColor.red
        // change the colour of player 2 name
        name2.textColor = UIColor.black
        // set the user2 arrow could not be seen
        user2Arrow.alpha = 0
        // set the user 1 arrow could be used
        user1Arrow.alpha = 1
    }
    
    
    
    
    
    
    
}
