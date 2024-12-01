//
//  LoginView.swift
//  Skylight
//
//  Created by Roscoe Rubin-Rottenberg on 12/1/24.
//

import SwiftUI
import ATProtoKit

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    let handle: String
    @Binding var atProto: ATProtoKit
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
                    atProto = ATProtoKit(session: session)
                }
            }
        }
        .padding()

    }
}

#Preview {
    LoginView(handle: "knotbin.xyz", atProto: .constant(ATProtoKit()))
}
