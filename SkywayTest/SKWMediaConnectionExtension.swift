//
//  SKWMediaConnectionExtension.swift
//  SkywayTest
//
//  Created by IwasaAtsushi on 2016/01/02.
//  Copyright © 2016年 IwasaAtsushi. All rights reserved.
//

import Foundation

extension SKWMediaConnection {
    func teardownConnectionCallbacks() {
        [SKWMediaConnectionEventEnum.MEDIACONNECTION_EVENT_STREAM, SKWMediaConnectionEventEnum.MEDIACONNECTION_EVENT_REMOVE_STREAM, SKWMediaConnectionEventEnum.MEDIACONNECTION_EVENT_CLOSE, SKWMediaConnectionEventEnum.MEDIACONNECTION_EVENT_ERROR].forEach { on($0, callback: nil) }
    }
}