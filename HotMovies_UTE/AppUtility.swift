//
//  AppUtility.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/17/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateorientation: UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateorientation.rawValue, forKey: "orientation")
    }
}
