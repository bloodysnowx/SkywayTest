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
    func onCall()
    func onPeerClose()
    func onDisconnected()
    func onPeerError(error: SKWPeerError)
    func onReachability()
    func onStream()
    func onRemoveStream()
    func onMediaConnectionClose()
    func onMediaConnectionError(error: SKWPeerError)
    func localMediaWidth() -> UInt
    func localMediaHeight() -> UInt
    func localVideoRect() -> CGRect
    func remoteVideoRect() -> CGRect
}

class SkywayConnection {
    private let peer = SKWPeer(apiKey: SkywayAPIKey, domain: SkywayDomain)
    private var msLocal: SKWMediaStream?
    private var msRemote: SKWMediaStream?
    private var conn: SKWMediaConnection?
    var skywayId: String?
    var connected = false
    private weak var callback: SkywayConnectionCallback?
    var vwLocal: SKWVideo?
    var vwRemote: SKWVideo?
    
    init(callback: SkywayConnectionCallback) {
        self.callback = callback
        setupPeerCallbacks()
        SKWNavigator.initialize(peer)
        msLocal = SKWNavigator.getUserMedia(callback.localMediaWidth(), height: callback.localMediaHeight())
    }
    
    deinit {
        teardownCallbacks()
    }
    
    private func setupPeerCallbacks() {
        peer.on(.PEER_EVENT_OPEN) { [weak self] obj -> Void in
            guard let givenId = obj as? String else { return }
            self?.callback?.onOpen(givenId)
        }
        peer.on(.PEER_EVENT_CONNECTION) { [weak self] obj -> Void in
            self?.callback?.onConnect()
        }
        peer.on(.PEER_EVENT_CALL) { [weak self] obj -> Void in
            guard let conn = obj as? SKWMediaConnection else { return }
            self?.conn = conn
            self?.setupConnectionCallbacks(conn)
            guard let msLocal = self?.msLocal else { return }
            conn.answer(msLocal)
            self?.callback?.onCall()
        }
        peer.on(.PEER_EVENT_CLOSE) { [weak self] obj -> Void in
            self?.callback?.onPeerClose()
        }
        peer.on(.PEER_EVENT_DISCONNECTED) { [weak self] obj -> Void in
            self?.callback?.onDisconnected()
        }
        peer.on(.PEER_EVENT_ERROR) { [weak self] obj -> Void in
            guard let error = obj as? SKWPeerError else { return }
            self?.callback?.onPeerError(error)
        }
        peer.on(.PEER_EVENT_REACHABILITY) { [weak self] obj -> Void in
            self?.callback?.onReachability()
        }
    }
    
    private func setupConnectionCallbacks(conn: SKWMediaConnection) {
        conn.on(.MEDIACONNECTION_EVENT_STREAM) { [weak self] obj -> Void in
            guard let msRemote = obj as? SKWMediaStream else { return }
            self?.msRemote = msRemote
            self?.vwRemote?.addSrc(msRemote, track: 0)
            self?.callback?.onStream()
        }
        conn.on(.MEDIACONNECTION_EVENT_REMOVE_STREAM) { [weak self] obj -> Void in
            self?.callback?.onRemoveStream()
        }
        conn.on(SKWMediaConnectionEventEnum.MEDIACONNECTION_EVENT_CLOSE) { [weak self] obj -> Void in
            self?.callback?.onMediaConnectionClose()
        }
        conn.on(.MEDIACONNECTION_EVENT_ERROR) { [weak self] obj -> Void in
            guard let error = obj as? SKWPeerError else { return }
            self?.callback?.onMediaConnectionError(error)
        }
    }
    
    private func teardownCallbacks() {
        conn?.teardownConnectionCallbacks()
        peer.teardownPeerCallbacks()
    }
    
    private func setupVideos() {
        setupLocalVideo()
        setupRemoteVideo()
    }
    
    private func setupLocalVideo() {
        guard let callback = callback else { return }
        vwLocal = SKWVideo(frame: callback.localVideoRect())
        guard let msLocal = msLocal, vwLocal = vwLocal else { return }
        vwLocal.addSrc(msLocal, track: 0)
    }
    
    private func setupRemoteVideo() {
        guard let callback = callback else { return }
        vwRemote = SKWVideo(frame: callback.remoteVideoRect())
    }
    
    func callWithId(destId: String) {
        guard let msLocal = msLocal else { return }
        conn = peer.callWithId(destId, stream: msLocal)
        guard let conn = conn else { return }
        setupConnectionCallbacks(conn)
    }
    
    func close() {
        
    }
    
}