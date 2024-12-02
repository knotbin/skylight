//
//  LoginViewModel.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import Foundation
import ATProtoKit
import SwiftUI

@Observable
class LoginViewModel {
    @ObservationIgnored @AppStorage("handle") var handle: String = ""
    @ObservationIgnored @AppStorage("apppassword") var apppassword: String = ""
    var username: String = ""
    var password: String = ""
    
    func createSession() async throws -> UserSession? {
        let config = ATProtocolConfiguration(handle: username, appPassword: password)
        
        do {
            let session = try await config.authenticate()
            handle = username
            apppassword = password
            return session
        } catch {
            print("Error creating session: \(error)")
            throw error
        }
    }

    init() {}
}
