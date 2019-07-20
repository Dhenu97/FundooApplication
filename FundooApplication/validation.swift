//
//  validation.swift
//  FundooApplication
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

class FunctionValidation {


func isemailvalid(emailId:String)->Bool
{
    let emailRegix = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegix)
    
    return emailTest.evaluate(with:emailId)
}


func passwordvalidate(password: String) -> Bool
{
    let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
    
    let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
    
    return passwordValidation.evaluate(with: password)
}

}
