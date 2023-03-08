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
    @State var errorString = ""
    var matchCheck: Bool {password==password2}
    var handleCheck: Bool {
        var data: Data = Data()
        DatabaseData.readData(location: "user/user_list.json") { _data, _ in
            data = _data
        }
        do {
            let userList = try JSONDecoder().decode(UserList.self, from: data)
            return userList.list.contains(handle)
        } catch {
            errorString = "error!!! cannot decode user_list.json |28"
        }
        return false
    }
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
            if errorString=="" {
                Text(errorString)
            }
            Button {
                if matchCheck && handleCheck {
                    Auth.auth().createUser(withEmail: email, password: password) { user, error in
                        if let _=user {
                            guard let uid = Auth.auth().currentUser?.uid else {return}
                            AppUser.uid = uid
                            AppUser.username = username
                            AppUser.handle = handle
                            
                            var data: Data = Data()
                            DatabaseData.readData(location: "user/user_list.json") { _data, _ in
                                data = _data
                            }
                            do {
                                var userList = try JSONDecoder().decode(UserList.self, from: data)
                                userList.list.append(handle)
                                data = try JSONEncoder().encode(userList)
                                DatabaseData.writeData(data, "user/user_list.json") { url in }
                            } catch {
                                errorString = "error!!! cannot de/encode user_list.json |83"
                            }
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

struct UserList: Codable {
    var list:[String] = []
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(viewState: Binding.constant(.login))
    }
}
