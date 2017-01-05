//
//  BaseObject.swift
//  Tic Tac Toe
//
//  Created by Gurjit Singh Ghangura on 2016-07-21.
//  Copyright © 2016 Gurjit Singh Ghangura. All rights reserved.
//

import UIKit

class BaseObject: NSObject {
    class var sharedInstance: BaseObject {
        struct Singleton {
            static let instance = BaseObject()
        }
        return Singleton.instance
    }
    var image : UIImage!
    let url = "http://graph.facebook.com/userID/picture?type=large"
    var customImage : Bool!
    var isCircle : Bool!
    var isComputerPlaying : Bool!
    var userName : String!
    var userData : NSMutableDictionary!
    var isDumb : Bool!
    
    
}
