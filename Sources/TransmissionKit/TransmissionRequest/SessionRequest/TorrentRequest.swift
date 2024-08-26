//
//  File.swift
//  
//
//  Created by Shibo Tong on 26/8/2024.
//

import Foundation

public enum TorrentMethod: String {
    case start
    case startNow = "start-now"
    case stop
    case verify
    case reannounce
    case get
    case set
    case add
    case remove
    case setLocation = "set-location"
    case renamePath = "rename-path"
}

extension TransmissionRequest {
    public static func torrent(method: TorrentMethod, arguments: [String: [Any]], tag: Int? = nil) -> TransmissionRequest {
        TransmissionRequest(method: "torrent-\(method.rawValue)", arguments: arguments, tag: tag)
    }
}
