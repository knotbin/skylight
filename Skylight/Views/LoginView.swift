//
//  LoginView.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import SwiftUI
import ATProtoKit

struct LoginView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Handle", text: $viewModel.username)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("App Password", text: $viewModel.password)
                }
            }
            .padding(.top, 40)
            Button("Login") {
                Task {
                    let session = try await viewModel.createSession()
                    appModel.atProto = ATProtoKit(session: session)
                }
            }
        }
        .padding()

    }
}

#Preview {
    LoginView()
        .environment(AppModel())
}
