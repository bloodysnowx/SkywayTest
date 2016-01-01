//
//  SKWPeerExtension.swift
//  SkywayTest
//
//  Created by IwasaAtsushi on 2016/01/01.
//  Copyright © 2016年 IwasaAtsushi. All rights reserved.
//

import Foundation

extension SKWPeer {
    convenience init(apiKey: String, domain: String) {
        self.init(options: SKWPeerOption(apiKey: apiKey, domain: domain))
    }
    
    func teardownPeerCallbacks() {
        [SKWPeerEventEnum.PEER_EVENT_OPEN, SKWPeerEventEnum.PEER_EVENT_CONNECTION, SKWPeerEventEnum.PEER_EVENT_CALL, SKWPeerEventEnum.PEER_EVENT_CLOSE, SKWPeerEventEnum.PEER_EVENT_DISCONNECTED, SKWPeerEventEnum.PEER_EVENT_ERROR, SKWPeerEventEnum.PEER_EVENT_REACHABILITY].forEach { on($0, callback: nil) }
    }
}