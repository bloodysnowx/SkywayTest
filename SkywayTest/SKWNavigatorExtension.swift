//
//  SKWNavigatorExtension.swift
//  SkywayTest
//
//  Created by IwasaAtsushi on 2016/01/02.
//  Copyright © 2016年 IwasaAtsushi. All rights reserved.
//

import Foundation

extension SKWNavigator {
    class func getUserMedia(width: UInt, height: UInt) -> SKWMediaStream {
        let constraints = SKWMediaConstraints(width: width, height: height)
        return SKWNavigator.getUserMedia(constraints)
    }
}
