//
//  UserMessage.swift
//  LoveFreshBeen
//
//  Created by shang on 16/1/12.
//  Copyright © 2016年 shang. All rights reserved.
//
//
//

import UIKit

enum UserMessageType: Int {
    case System = 0
    case User = 1
}

class UserMessage: NSObject {
    
    var id: String?
    var type = -1
    var title: String?
    var content: String?
    var link: String?
    var city: String?
    var noticy: String?
    var send_time: String?
    
    // 辅助参数
    var subTitleViewHeightNomarl: CGFloat = 60
    var cellHeight: CGFloat = 60 + 60 + 20
    var subTitleViewHeightSpread: CGFloat = 0
    
    class func loadSystemMessage(complete: ((data: [UserMessage]?, error: NSError?) -> ())) {
        
        complete(data: loadMessage(.System)!, error: nil)
    }
    
    class func loadUserMessage(complete: ((data: [UserMessage]?, error: NSError?) -> ())) {
        complete(data: loadMessage(.User), error: nil)
    }
    
    private class func userMessage(dict: NSDictionary) -> UserMessage {

        let modelTool = DictModelManager.sharedManager
        let message = modelTool.objectWithDictionary(dict, cls: UserMessage.self) as? UserMessage

        return message!
    }
    
    private class func loadMessage(type: UserMessageType) -> [UserMessage]? {
        var data: [UserMessage]? = []
        
        let path = NSBundle.mainBundle().pathForResource(((type == .System) ? "SystemMessage" : "UserMessage"), ofType: nil)
        let resData = NSData(contentsOfFile: path!)
        if resData != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(resData!, options: .AllowFragments)) as! NSDictionary
            if let array = dict.objectForKey("data") as? NSArray {
                for dict in array {
                    let message = UserMessage.userMessage(dict as! NSDictionary)
                    data?.append(message)
                }
            }
        }
        return data
    }
}
