//
//  SignupView.swift
//  Midterm
//
//  Created by Speer-Zisook, Ella on 2/9/23.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @EnvironmentObject var appUser: User
    @State var email = ""
    @State var handle = ""
    @State var username = ""
    @State var password = ""
    @State var password2 = ""
    var matchCheck: Bool {password==password2}
    var handleCheck: Bool {!UserData.userDict.contains {$0.value.handle == handle}}
    @Binding var viewState:ViewState
    var body: some View {
        VStack {
            Text("Foods With Friends!")
                .font(.largeTitle)
            Spacer()
            Text("Sign up")
                .font(.headline)
            VStack {
                TextField("Email address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                if !handleCheck {
                    Text("@handle not unique!")
                }
                TextField("@handle", text: $handle)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                if !matchCheck {
                    Text("Passwords do not match!")
                }
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField("Confirm password", text: $password2)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Button {
                //TODO: loading –––––––––––––––––––––––––––––––
                if matchCheck && handleCheck {
                    Auth.auth().createUser(withEmail: email, password: password) { user, error in
                        if let _=user {
                            guard let uid = Auth.auth().currentUser?.uid else {return}
                            appUser.reinit(username: username, handle: handle, uid: uid)
                            UserData.appendUserDict(uid, PublicUser(username: username, handle: handle))
                            UserData.pushUser(appUser)
                            UserData.stopObservingUserDict()
                            viewState = .home
                        } else {
                            print(error ?? "")
                        }
                    }
                }
            } label: {
                Text("Sign up")
            }
            .onAppear {
                UserData.observeUserDict()
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
