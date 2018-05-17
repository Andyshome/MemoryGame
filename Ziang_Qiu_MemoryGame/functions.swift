//
//  functions.swift
//  Ziang_Qiu_MemoryGame
//
//  Created by Qiu Ziang on 2018/4/18.
//  Copyright © 2018年 skylove. All rights reserved.
//
import UIKit
class functools: UIViewController {
    
    
    // shuffle the function
    func shuffle(origin:Array<UIImage>)->Array<UIImage>{
        //determine a empty array
        var result:[UIImage]=[]
        // give the pic to another array
        var arrayToChange = origin
        //give a random number to change the order
        var random = 0
        // finish when array to change is empty
        while arrayToChange.count != 0 {
            // give the value to another array
            random = Int(arc4random_uniform(UInt32(arrayToChange.count)))
            // put the value to the array
            result.append(arrayToChange[random])
            // remove the origin pictures
            arrayToChange.remove(at: random)
            
        }
        // return the value
        return result
    }

}
