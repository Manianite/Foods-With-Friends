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
    @State var handleCheck: Bool = true
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
                UserData.getUserDict { userDict in
                    var userDict = userDict
                    handleCheck = !userDict.handles.contains(handle)
                    if matchCheck && handleCheck {
                        Auth.auth().createUser(withEmail: email, password: password) { user, error in
                            if let _=user {
                                guard let uid = Auth.auth().currentUser?.uid else {return}
                                appUser.reinit(username: username, handle: handle, uid: uid)
                                userDict.handles.append(handle)
                                userDict.uids.append(uid)
                                userDict.usernames.append(username)
                                userDict.profilePics.append("")
                                do {
                                    let JSONUserDict = try JSONEncoder().encode(userDict)
                                    UserData.writeData(JSONUserDict, "users/user_dict.json")
                                    let JSONUserProfile = try JSONEncoder().encode(appUser)
                                    UserData.writeData(JSONUserProfile, "users/\(uid)/user_profile.json")
                                } catch {
                                    print("error!!! cannot encode user_dict.json at SignupView: 71")
                                }
                                viewState = .home
                            } else {
                                print(error ?? "")
                            }
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
