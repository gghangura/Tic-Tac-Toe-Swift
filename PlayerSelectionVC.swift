//
//  PlayerSelectionVC.swift
//  Tic Tac Toe
//
//  Created by Gurjit Singh Ghangura on 2016-07-21.
//  Copyright © 2016 Gurjit Singh Ghangura. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class PlayerSelectionVC: UIViewController, UIActionSheetDelegate {
    @IBOutlet weak var userNameTxtField: UITextField!
    
    var userData : NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
        //         Do any additional setup after loading the view.
    }
    
    @IBAction func facebookLogin(sender: UIButton) {
        
        BaseObject.sharedInstance.isComputerPlaying = true
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Use Profile Picture Instead of", message: "Note, this is a one player game", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Cross", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.customImage = true
            BaseObject.sharedInstance.isCircle = false
            self.onePlayerActionSheet()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Circle", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.customImage = true
            BaseObject.sharedInstance.isCircle = true
            self.onePlayerActionSheet()
        }
        actionSheetController.addAction(deleteActionButton)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func facebook() -> Void {
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
            req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
                if(error == nil)
                {
                    BaseObject.sharedInstance.userData = result as! NSMutableDictionary
                    let finishedUrl = BaseObject.sharedInstance.url.stringByReplacingOccurrencesOfString("userID", withString: "\(BaseObject.sharedInstance.userData.valueForKey("id")!)")
                    let data = NSData(contentsOfURL: NSURL(string: finishedUrl)!)
                    BaseObject.sharedInstance.image = UIImage(data: data!)
                    self.pushViewController()
                }
                else
                {
                    print("error \(error)")
                }
            })
        } else {
            let loginManager = FBSDKLoginManager();
            let isInstalled = UIApplication.sharedApplication().canOpenURL(NSURL(string: "fb://")!)
            if (isInstalled) {
                loginManager.loginBehavior = FBSDKLoginBehavior.Native
            } else {
                loginManager.loginBehavior = FBSDKLoginBehavior.Browser
            }
            
            //        print(FBSDKAccessToken.currentAccessToken())
            //        loginManager.logOut()
            FBSDKLoginManager().logInWithReadPermissions(["public_profile"],fromViewController:self ,handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
                if error != nil {
                    print("error")
                }else if(result.isCancelled){
                    print("result cancelled")
                }else{
                    let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters: nil);
                    fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
                        
                        if error == nil {
                            BaseObject.sharedInstance.userData = result as! NSMutableDictionary
                            let finishedUrl = BaseObject.sharedInstance.url.stringByReplacingOccurrencesOfString("userID", withString: "\(BaseObject.sharedInstance.userData.valueForKey("id")!)")
                            let data = NSData(contentsOfURL: NSURL(string: finishedUrl)!)
                            BaseObject.sharedInstance.image = UIImage(data: data!)
                            self.pushViewController()
                        } else {
                            
                        }
                    }
                }
            })
        }
    }
    
    @IBAction func setUserNameForGame(sender: UIButton) {
        if userNameTxtField.text == "" {
            let alert = UIAlertController.init(title: "Error", message: "Please enter your username", preferredStyle: .Alert)
            let ok = UIAlertAction.init(title: "OK", style: .Cancel, handler: { (alert : UIAlertAction) in
                
                }
            )
            alert.addAction(ok)
            
            //            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Title"
            //            message:@"Message"
            //            preferredStyle:UIAlertControllerStyleAlert];
            //
            //            UIAlertAction* yesButton = [UIAlertAction
            //            actionWithTitle:@"Yes, please"
            //            style:UIAlertActionStyleDefault
            //            handler:^(UIAlertAction * action) {
            //            //Handle your yes please button action here
            //            }];
            //
            //            UIAlertAction* noButton = [UIAlertAction
            //            actionWithTitle:@"No, thanks"
            //            style:UIAlertActionStyleDefault
            //            handler:^(UIAlertAction * action) {
            //            //Handle no, thanks button
            //            }];
            //
            //            [alert addAction:yesButton];
            //            [alert addAction:noButton];
            //
            //            [self presentViewController:alert animated:YES completion:nil];
            //            let alert = UIAlertView.init(title: "ALert", message: "Enter Name", delegate: nil, cancelButtonTitle: "OK")
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            BaseObject.sharedInstance.userName = userNameTxtField.text
        }
        
    }
    @IBAction func onePlayer(sender: UIButton) {
        BaseObject.sharedInstance.customImage = false
        BaseObject.sharedInstance.isComputerPlaying = true
        let actionSheetController: UIAlertController = UIAlertController(title: "iPhone is", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Dumb", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = true
            self.pushViewController()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Smart", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = false
            self.pushViewController()
        }
        actionSheetController.addAction(deleteActionButton)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    func onePlayerActionSheet() {
        let actionSheetController: UIAlertController = UIAlertController(title: "iPhone is", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Dumb", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = true
            self.facebook()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Smart", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = false
            self.facebook()
        }
        actionSheetController.addAction(deleteActionButton)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    @IBAction func twoPlayer(sender: UIButton) {
        BaseObject.sharedInstance.customImage = false
        BaseObject.sharedInstance.isComputerPlaying = false
        pushViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pushViewController() -> Void {
        let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView");
        self.navigationController?.pushViewController(gameView!, animated: true)
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
