//
//  Game.swift
//  Tic Tac Toe
//
//  Created by Gurjit Singh Ghangura on 2016-07-21.
//  Copyright © 2016 Gurjit Singh Ghangura. All rights reserved.
//

import UIKit

class Game: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var userSteps = [0,0,0,0,0,0,0,0,0]
    
    let winnigArray = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    var now = 1;
    
    var winner = ""
    
    var disabled = false;
    
    var circleImage : UIImage!
    
    var crossImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSteps = [0,0,0,0,0,0,0,0,0]
        if (BaseObject.sharedInstance.customImage == true) {
            if (BaseObject.sharedInstance.isCircle == true) {
                circleImage = BaseObject.sharedInstance.image
                now = 1
                crossImage = UIImage(named: "Cross.png")
            } else {
                circleImage = UIImage(named: "Circle.png")
                now = 2
                crossImage = BaseObject.sharedInstance.image
            }
        } else {
            circleImage = UIImage(named: "Circle.png")
            crossImage = UIImage(named: "Cross.png")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func userPressed(sender: UIButton) {
        if !disabled {
            switchImage(sender)
        }
    }
    
    func switchImage(button:UIButton) -> Void {
        if (userSteps[button.tag - 1] == 0) {
            if (now == 1) {
                button.setBackgroundImage(circleImage, forState: UIControlState.Normal)
                userSteps[button.tag - 1] = 1;
                now = 2
            } else {
                button.setBackgroundImage(crossImage, forState: UIControlState.Normal)
                userSteps[button.tag - 1] = 2;
                now = 1
            }
            if checkWinnig() {
                
            } else {
                if ((BaseObject.sharedInstance.isComputerPlaying) == true) {
                    disabled = true
                    if (BaseObject.sharedInstance.isDumb == true) {
                        self.performSelector(#selector(Game.ComputersTurnDumb), withObject: nil, afterDelay: 2.0)
                    } else{
                        self.performSelector(#selector(Game.ComputersTurnSmart), withObject: nil, afterDelay: 2.0)
                    }
                }
            }
        }
    }
    func checkWinnig() -> Bool {
        if winner == "" {
            var gameOver = false
            for internalArray in winnigArray {
                let zero = internalArray[0];
                let first = internalArray[1];
                let second = internalArray[2];
                if (userSteps[zero] != 0 && userSteps[zero] == userSteps[first] && userSteps[first] == userSteps[second]) {
                    if userSteps[zero] == 1 {
                        winner = "CIRCLE"
                        gameOver = true
                        resultLabel.text = "CIRCLE WON"
                        break
                    } else {
                        winner = "CROSS"
                        gameOver = true
                        resultLabel.text = "CROSS WON"
                        break
                    }
                }
            }
            if gameOver {
                Disable()
            }
            if gameComplete() {
                Disable()
                resultLabel.text = "DRAW"
            }
            return gameOver
        } else {
            return true
        }
    }
    func ComputersTurnDumb() -> Void {
        if winner == "" {
            var execute = false
            var anySpace = true
            var randomNumber = Int(arc4random_uniform(8))
            for num in userSteps {
                if num == 0 {
                    anySpace = true
                    break
                }
                else {
                    anySpace = false;
                }
            }
            while (execute == false) {
                if userSteps[randomNumber] == 0 {
                    execute = true
                } else {
                    if anySpace {
                        randomNumber = Int(arc4random_uniform(8))
                    } else {
                        execute = true
                    }
                }
            }
            
                let button = gameView.viewWithTag(randomNumber+1) as! UIButton
                if (now == 1) {
                    button.setBackgroundImage(circleImage, forState: UIControlState.Normal)
                    userSteps[randomNumber] = 1;
                    now = 2
                } else {
                    button.setBackgroundImage(crossImage, forState: UIControlState.Normal)
                    userSteps[randomNumber] = 2;
                    now = 1
                }
                checkWinnig()
            
        }
        disabled = false
    }
    func ComputersTurnSmart() -> Void {
        if winner == "" {
            var run = false
            let indexValues = NSMutableArray()
            let numbers = NSMutableArray()
            var count = 0
            var number = 0
            var o = 0
            for (o = 0 ;o < winnigArray.count;o += 1) {
                let internalArray = winnigArray[o]
                let zero = internalArray[0];
                let first = internalArray[1];
                let second = internalArray[2];
                if (userSteps[zero] != 0 && userSteps[zero] == userSteps[first]) {
                    if (userSteps[second] == 0) {
                        number = second + 1
                        run = true
                        indexValues.addObject(o)
                        numbers.addObject(number)
                        count += 1
                    }
                } else if (userSteps[zero] != 0 && userSteps[zero] == userSteps[second]) {
                    if (userSteps[first] == 0) {
                        number = first + 1
                        run = true
                        indexValues.addObject(o)
                        numbers.addObject(number)
                        count += 1
                    }
                } else if (userSteps[first] != 0 && userSteps[first] == userSteps[second]) {
                    if (userSteps[zero] == 0) {
                        number = zero + 1
                        run = true
                        indexValues.addObject(o)
                        numbers.addObject(number)
                        count += 1
                    }
                }
                if count > 1 {
                    var x = winnigArray[indexValues[0] as! Int]
                    if userSteps[x[0]] == 2 || userSteps[x[1]] == 2 || userSteps[x[2]] == 2 {
                        if (userSteps[x[0]] == 0) {
                            number = x[0] + 1
                        } else if (userSteps[x[1]] == 0) {
                            number = x[1] + 1
                        } else if (userSteps[x[2]] == 0) {
                            number = x[2] + 1
                        }
                    } else {
                        x = winnigArray[indexValues[1] as! Int]
                        if (userSteps[x[0]] == 0) {
                            number = x[0] + 1
                        } else if (userSteps[x[1]] == 0) {
                            number = x[1] + 1
                        } else if (userSteps[x[2]] == 0) {
                            number = x[2] + 1
                        }
                    }
                }
            }
            if (run == false) {
                if userSteps[4] == 0 {
                    run = true
                    number = 5
                } else {
                    if winner == "" {
                        ComputersTurnDumb()
                    }
                }
            }
            if run == true {
                let button = gameView.viewWithTag(number) as! UIButton
                if (now == 1) {
                    button.setBackgroundImage(circleImage, forState: UIControlState.Normal)
                    userSteps[number-1] = 1;
                    now = 2
                } else {
                    button.setBackgroundImage(crossImage, forState: UIControlState.Normal)
                    userSteps[number-1] = 2;
                    now = 1
                }
                checkWinnig()
            }
        }
        disabled = false
    }
    func ShowRedLine() -> Void {
        
    }
    func Disable() {
        var i : Int
        for (i = 1 ; i < 10 ; i += 1) {
            let button = gameView.viewWithTag(i) as! UIButton
            button.userInteractionEnabled = false
        }
        let button = self.view.viewWithTag(11) as! UIButton
        button.hidden = false;
    }
    func Enable() {
        var i : Int
        for (i = 1 ; i < 10 ; i += 1) {
            let button = gameView.viewWithTag(i) as! UIButton
            button.userInteractionEnabled = true
            button.setBackgroundImage(nil, forState: .Normal)
        }
        let button = self.view.viewWithTag(11) as! UIButton
        button.hidden = true;
    }
    func Reset()  {
        userSteps = [0,0,0,0,0,0,0,0,0]
        now = 1
        winner = ""
        resultLabel.text = ""
        if (BaseObject.sharedInstance.customImage == true) {
            if (BaseObject.sharedInstance.isCircle == true) {
                now = 1
            } else {
                now = 2
            }
        }
    }
    @IBAction func ResetGame(sender: UIButton) {
        Enable()
        Reset()
    }
    
    func gameComplete() -> Bool {
        var isComplete = true
        for number in userSteps {
            if (number == 0) {
                isComplete = false
                break
            }
        }
        return isComplete
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
