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

protocol SkywayConnectionCallback: class {
    func onOpen(givenId: String)
    func onConnect()
    func onCall(mediaConnection: SKWMediaConnection)
    func onClose()
    func onDisconnected()
    func onError(error: SKWPeerError)
    func onReachability()
}

class SkywayConnection {
    let peer = SKWPeer(apiKey: SkywayAPIKey, domain: SkywayDomain)
    var msLocal: SKWMediaStream?
    var msRemote: SKWMediaStream?
    var conn: SKWMediaConnection?
    var skywayId: String?
    var connected = false
    weak var callback: SkywayConnectionCallback?
    
    init(callback: SkywayConnectionCallback) {
        self.callback = callback
        setupCallbacks()
    }
    
    private func setupCallbacks() {
        peer.on(.PEER_EVENT_OPEN) { [weak self] obj -> Void in
            guard let givenId = obj as? String else { return }
            self?.callback?.onOpen(givenId)
        }
        
        peer.on(.PEER_EVENT_CONNECTION) { [weak self] obj -> Void in
            self?.callback?.onConnect()
        }
        peer.on(.PEER_EVENT_CALL) { [weak self] obj -> Void in
            guard let conn = obj as? SKWMediaConnection else { return }
            self?.callback?.onCall(conn)
        }
        peer.on(.PEER_EVENT_CLOSE) { [weak self] obj -> Void in
            self?.callback?.onClose()
        }
        peer.on(.PEER_EVENT_DISCONNECTED) { [weak self] obj -> Void in
            self?.callback?.onDisconnected()
        }
        peer.on(.PEER_EVENT_ERROR) { [weak self] obj -> Void in
            guard let error = obj as? SKWPeerError else { return }
            self?.callback?.onError(error)
        }
        peer.on(.PEER_EVENT_REACHABILITY) { [weak self] obj -> Void in
            self?.callback?.onReachability()
        }
    }
}