//
//  SignupView.swift
//  Midterm
//
//  Created by Speer-Zisook, Ella on 2/9/23.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State var email = ""
    @State var handle = ""
    @State var username = ""
    @State var password = ""
    @State var password2 = ""
    var matchCheck: Bool {password==password2}
    var handleCheck: Bool {true}//{!handles.contains(handle)}
    @Binding var viewState:ViewState
    @EnvironmentObject var me: AppUser
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
                if !matchCheck {
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
                if matchCheck && handleCheck {
                    Auth.auth().createUser(withEmail: email, password: password) { user, error in
                        if let _=user {
                            self.me.handle = handle
                            
                            var data: Data
                            DatabaseData.readTxtData(location: "user/user_list.json") { dataString in
                                data = Data(dataString.utf8)
                            }
                            JSONDecoder().decode(UserList.self, from: data)
                            //DatabaseData.writeTxtData("", "user/user_list.json") { url in }
                            viewState = .homeFeed
                        } else {
                            print(error)
                        }
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
