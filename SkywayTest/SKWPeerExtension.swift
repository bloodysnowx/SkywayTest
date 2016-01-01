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
}