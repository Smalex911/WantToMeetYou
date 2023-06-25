//
//  Ext+UIApplication.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import UIKit

extension UIApplication {
    
    static func isM1Simulator() -> Bool {
        return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
    }
}
