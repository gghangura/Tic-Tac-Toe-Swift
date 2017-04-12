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
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        
        BaseObject.sharedInstance.isComputerPlaying = true
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Use Profile Picture Instead of", message: "Note, this is a one player game", preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Cross", style: .default)
        { action -> Void in
            BaseObject.sharedInstance.customImage = true
            BaseObject.sharedInstance.isCircle = false
            self.onePlayerActionSheet()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Circle", style: .default)
        { action -> Void in
            BaseObject.sharedInstance.customImage = true
            BaseObject.sharedInstance.isCircle = true
            self.onePlayerActionSheet()
        }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func facebook() -> Void {
        
        if FBSDKAccessToken.current() != nil {
            let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
//            req.start(completionHandler: { (connection, result, error : NSError!) -> Void in
//                if(error == nil)
//                {
//                    BaseObject.sharedInstance.userData = result as! NSMutableDictionary
//                    let finishedUrl = BaseObject.sharedInstance.url.replacingOccurrences(of: "userID", with: "\(BaseObject.sharedInstance.userData.value(forKey: "id")!)")
//                    let data = try? Data(contentsOf: URL(string: finishedUrl)!)
//                    BaseObject.sharedInstance.image = UIImage(data: data!)
//                    self.pushViewController()
//                }
//                else
//                {
//                    print("error \(error)")
//                }
//            })
        } else {
            let loginManager = FBSDKLoginManager();
            let isInstalled = UIApplication.shared.canOpenURL(URL(string: "fb://")!)
            if (isInstalled) {
                loginManager.loginBehavior = FBSDKLoginBehavior.native
            } else {
                loginManager.loginBehavior = FBSDKLoginBehavior.browser
            }
            
            //        print(FBSDKAccessToken.currentAccessToken())
            //        loginManager.logOut()
//            FBSDKLoginManager().logIn(withReadPermissions: ["public_profile"],from:self ,handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
//                if error != nil {
//                    print("error")
//                }else if(result.isCancelled){
//                    print("result cancelled")
//                }else{
//                    let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters: nil);
//                    fbRequest.start { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
//                        
//                        if error == nil {
//                            BaseObject.sharedInstance.userData = result as! NSMutableDictionary
//                            let finishedUrl = BaseObject.sharedInstance.url.replacingOccurrences(of: "userID", with: "\(BaseObject.sharedInstance.userData.value(forKey: "id")!)")
//                            let data = try? Data(contentsOf: URL(string: finishedUrl)!)
//                            BaseObject.sharedInstance.image = UIImage(data: data!)
//                            self.pushViewController()
//                        } else {
//                            
//                        }
//                    }
//                }
//            })
        }
    }
    
    @IBAction func setUserNameForGame(_ sender: UIButton) {
        if userNameTxtField.text == "" {
            let alert = UIAlertController.init(title: "Error", message: "Please enter your username", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "OK", style: .cancel, handler: { (alert : UIAlertAction) in
                
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
            self.present(alert, animated: true, completion: nil)
        } else {
            BaseObject.sharedInstance.userName = userNameTxtField.text
        }
        
    }
    @IBAction func onePlayer(_ sender: UIButton) {
        BaseObject.sharedInstance.customImage = false
        BaseObject.sharedInstance.isComputerPlaying = true
        let actionSheetController: UIAlertController = UIAlertController(title: "iPhone is", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Dumb", style: .default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = true
            self.pushViewController()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Smart", style: .default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = false
            self.pushViewController()
        }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func onePlayerActionSheet() {
        let actionSheetController: UIAlertController = UIAlertController(title: "iPhone is", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Dumb", style: .default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = true
            self.facebook()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Smart", style: .default)
        { action -> Void in
            BaseObject.sharedInstance.isDumb = false
            self.facebook()
        }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    @IBAction func twoPlayer(_ sender: UIButton) {
        BaseObject.sharedInstance.customImage = false
        BaseObject.sharedInstance.isComputerPlaying = false
        pushViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pushViewController() -> Void {
        let gameView = self.storyboard?.instantiateViewController(withIdentifier: "gameView");
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
