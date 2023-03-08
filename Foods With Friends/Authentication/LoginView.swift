//
//  LoginView.swift
//  Midterm
//
//  Created by Speer-Zisook, Ella on 2/9/23.
//

import SwiftUI
import FirebaseAuth
 
struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @Binding var viewState: ViewState
    var body: some View {
        VStack {
            Text("Foods With Friends!")
                .font(.largeTitle)
            Spacer()
            Text("Log in")
                .font(.headline)
            TextField("Username", text: $username)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Button {
                Auth.auth().signIn(withEmail: username, password: password) { user, error in
                    if let _=user {
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        let me: User = FetchUserData.getData("users/\(uid)/User Profile.json")
                        AppUser.uid = uid
                        AppUser.handle = me.handle
                        AppUser.username = me.username
                        viewState = .homeFeed
                    } else {
                        print(error)
                    }
                }
            } label: {
                Text("Log in")
            }
            Button {
                Auth.auth().sendPasswordReset(withEmail: username) { error in
                    if let _=error {
                        print(error)
                    }
                }
            } label: {
                Text("I forgot my passowrd")
            }
            Spacer()
            Text("Don't have an account?")
            Button {
                viewState = .signup
            } label: {
                Text("Sign up!")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewState: Binding.constant(.login))
    }
}
