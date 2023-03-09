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
    @State var errorString = ""
    var matchCheck: Bool {password==password2}
    @State var handleCheck: Bool = true
    @State var userList: [String] = []
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
                    .task {
                        var data = await DatabaseData.readData(location: "users/user_list.json")
                        print(String(data: data, encoding: .utf8) ?? "")
                        do {
                            userList = try JSONDecoder().decode(UserList.self, from: data).list
                        } catch {
                            handleCheck = false
                            //errorString = "error!!! cannot decode user_list.json |28"
                        }
                    }
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
            if errorString=="" {
                Text(errorString)
            }
            Button {
                handleCheck = !userList.contains(handle)
                if matchCheck && handleCheck {
                    Auth.auth().createUser(withEmail: email, password: password) { user, error in
                        if let _=user {
                            guard let uid = Auth.auth().currentUser?.uid else {return}
                            appUser.reinit(username: username, handle: handle, uid: uid)
                            userList.append(handle)
                            do {
                                let JSONUserList = try JSONEncoder().encode(userList)
                                DatabaseData.writeDataPatently(JSONUserList, "users/user_list.json")
                                let JSONUserProfile = try JSONEncoder().encode(appUser)
                                DatabaseData.writeDataPatently(JSONUserProfile, "users/\(uid)/User Profile.json")
                            } catch {
                                errorString = "error!!! cannot encode user_list.json |83"
                            }
                            viewState = .home
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
 
struct UserList: Codable {
    var list:[String] = []
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(viewState: Binding.constant(.login))
    }
}
