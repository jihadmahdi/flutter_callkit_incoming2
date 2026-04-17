//
//  NSUserActivity.swift
//  Runner
//
//  Created by Hien Nguyen on 20/02/2022.
//

import Foundation
import Intents

extension NSUserActivity: StartCallConvertible {

    public var handle: String? {
        guard let interaction = interaction else { return nil }

        // INStartCallIntent is the modern API (iOS 13+).
        // INStartAudioCallIntent / INStartVideoCallIntent were deprecated in iOS 13/14
        // and fully removed in iOS 17 – guard against them to prevent build failures.
        if #available(iOS 13.0, *) {
            if let intent = interaction.intent as? INStartCallIntent,
               let contact = intent.contacts?.first {
                return contact.personHandle?.value
            }
        }

        // Legacy path – only compiled on iOS < 17 where these symbols still exist.
        if let startCallIntent = interaction.intent as? SupportedStartCallIntent,
           let contact = startCallIntent.contacts?.first {
            return contact.personHandle?.value
        }
        return nil
    }

    public var isVideo: Bool? {
        guard let interaction = interaction else { return nil }

        if #available(iOS 13.0, *) {
            if let intent = interaction.intent as? INStartCallIntent {
                return intent.callCapability == .videoCall
            }
        }

        if let startCallIntent = interaction.intent as? SupportedStartCallIntent {
            return startCallIntent is INStartVideoCallIntent
        }
        return nil
    }

}


protocol StartCallConvertible {
    var handle: String? { get }
    var isVideo: Bool? { get }
}

extension StartCallConvertible {

    var isVideo: Bool? {
        return nil
    }

}


protocol SupportedStartCallIntent {
    var contacts: [INPerson]? { get }
}

// INStartAudioCallIntent deprecated iOS 13, removed iOS 17
// INStartVideoCallIntent deprecated iOS 14, removed iOS 17
// Suppress the deprecation warnings; these exist only as a legacy fallback.
@available(iOS, deprecated: 13.0, message: "Use INStartCallIntent instead")
extension INStartAudioCallIntent: SupportedStartCallIntent {}
@available(iOS, deprecated: 14.0, message: "Use INStartCallIntent instead")
extension INStartVideoCallIntent: SupportedStartCallIntent {}
