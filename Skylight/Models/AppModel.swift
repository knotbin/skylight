//
//  AppModel.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import Foundation
import ATProtoKit
import SwiftUI

@Observable
class AppModel {
    @ObservationIgnored @AppStorage("handle") var handle: String = ""
    @ObservationIgnored @AppStorage("apppassword") var apppassword: String = ""
    var atProto = ATProtoKit()
    
    init() {
        if !handle.isEmpty && !apppassword.isEmpty {
            let config = ATProtocolConfiguration(handle: handle, appPassword: apppassword)
            Task {
                let session = try await config.authenticate()
                atProto = ATProtoKit(session: session)
            }
        }
    }
}
