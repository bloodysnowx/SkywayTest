//
//  SKWMediaConstraintsExtension.swift
//  SkywayTest
//
//  Created by IwasaAtsushi on 2016/01/02.
//  Copyright © 2016年 IwasaAtsushi. All rights reserved.
//

import Foundation

extension SKWMediaConstraints {
    convenience init(width: UInt, height: UInt) {
        self.init()
        self.maxWidth = width
        self.maxHeight = height
        self.cameraPosition = .CAMERA_POSITION_FRONT
    }
}