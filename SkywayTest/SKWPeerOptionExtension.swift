//
//  SKWPeerOptionExtension.swift
//  SkywayTest
//
//  Created by IwasaAtsushi on 2016/01/01.
//  Copyright © 2016年 IwasaAtsushi. All rights reserved.
//

import Foundation

extension SKWPeerOption {
    convenience init(apiKey: String, domain: String) {
        self.init()
        self.key = apiKey
        self.domain = domain
    }
}