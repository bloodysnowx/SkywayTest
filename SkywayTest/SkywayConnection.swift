//
//  SkywayConnection.swift
//  SkywayTest
//
//  Created by IwasaAtsushi on 2016/01/01.
//  Copyright © 2016年 IwasaAtsushi. All rights reserved.
//

import Foundation

private let SkywayAPIKey = "cd83668a-22cc-4cd4-9d85-b66c0f0f454f"
private let SkywayDomain = "com.bloodysnow"

class SkywayConnection {
    let peer = SKWPeer(apiKey: SkywayAPIKey, domain: SkywayDomain)
    var msLocal: SKWMediaStream?
    var msRemote: SKWMediaStream?
    var conn: SKWConnection?
    var skywayId: String?
    var connected = false
    
    init() {

    }
}