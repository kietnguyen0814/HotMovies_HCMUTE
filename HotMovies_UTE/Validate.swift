//
//  Validate.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 5/31/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import Foundation
class Validate {
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
