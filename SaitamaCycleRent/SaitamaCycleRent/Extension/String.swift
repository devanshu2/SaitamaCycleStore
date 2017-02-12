//
//  String.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation
import Gloss

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    static func isValid(paramString theString:Any?) ->Bool {
        if theString != nil {
            if theString is String {
                if ((theString as! String).length) > 0 {
                    return true
                }
            }
        }
        return false
    }
    
    static func isUnsafeValid(paramString theString:Any?) ->Bool {
        if theString != nil {
            if theString is String {
                return true
            }
        }
        return false
    }

    static func isValidURL(paramURLString theURLString: String?) -> Bool {
        if String.isValid(paramString: theURLString) {
            if let candidateURL = URL(string: theURLString!) {
                if ( (candidateURL.scheme != nil) && (candidateURL.host != nil) ) {
                    return true
                }
            }
        }
        return false
    }
    
    static func isValidateEmail(_ candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    static func getRandomString(_ length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func textRect(withFont font: UIFont) -> CGRect {
        return self.textRect(withFont: font, andWidth: CGFloat.greatestFiniteMagnitude, andHeight: CGFloat.greatestFiniteMagnitude)
    }
    
    func textRect(withFont font: UIFont, andWidth width:CGFloat) -> CGRect {
        return self.textRect(withFont: font, andWidth: width, andHeight: CGFloat.greatestFiniteMagnitude)
    }
    
    func textRect(withFont font: UIFont, andHeight height:CGFloat) -> CGRect {
        return self.textRect(withFont: font, andWidth: CGFloat.greatestFiniteMagnitude, andHeight: height)
    }
    
    func textRect(withFont font: UIFont, andWidth width:CGFloat, andHeight height:CGFloat) -> CGRect {
        let constraintRect = CGSize(width: width, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox
    }
    func withBoldText(boldPartsOfString: Array<String>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSFontAttributeName:font!]
        let boldFontAttribute = [NSFontAttributeName:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self.lowercased() as NSString).range(of: boldPartsOfString[i].lowercased() as String))
        }
        return boldString
    }
    func JSONValue() -> AnyObject?
    {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let jsonData = data
        {do{
            let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
            if let jsonResult = message as? JSON
            {
                return jsonResult as AnyObject?
            }
            if let jsonArray = message as? Array<JSON>
            {
                   return jsonArray as AnyObject
            }
            if let stringArray = message as? Array<String>
            {
                return stringArray as AnyObject
            }
            else
            {
                return nil
            }
        }
        catch _ as NSError{return nil}}else{return nil}
    }
}
