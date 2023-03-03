//
//  SignupView.swift
//  Midterm
//
//  Created by Speer-Zisook, Ella on 2/9/23.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State var username = ""
    @State var password = ""
    @Binding var viewState:ViewState
    var body: some View {
        VStack {
            Text("Foods With Friends!")
                .font(.largeTitle)
            Spacer()
            Text("Sign up")
                .font(.headline)
            TextField("Username", text: $username)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Button {
                Auth.auth().createUser(withEmail: username, password: password) { user, error in
                    if let _=user {
                        viewState = .home
                    } else {
                        print(error)
                    }
                }
            } label: {
                Text("Sign up")
            }
            Spacer()
            Text("Already have an account?")
            Button {
                viewState = .login
            } label: {
                Text("Log in!")
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(viewState: Binding.constant(.login))
    }
}
