//
//  ContentView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/1/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ContentView: View {
    @State var viewState = ViewState.login
    var body: some View {
        VStack {
            if viewState == .home {
                AppView(viewState: $viewState)
            } else if viewState == .login {
                LoginView(viewState: $viewState)
            } else if viewState == .signup {
                SignupView(viewState: $viewState)
            } else if viewState == .forgotPassword {
                Text("Forgot password page")
            } else {
                Text("Problem at ~23")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
