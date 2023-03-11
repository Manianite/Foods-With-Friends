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
            Group{
                VStack{
                Image("logo")
                    .resizable()
                    .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenWidth/3)
                    //.padding(.top, 5)
                
                    //.aspectRatio(contentMode: .fit)
                Text("Foods With Friends")
                    .font(.system(size: 45))
                    .font(.largeTitle)
                    .font(Constants.titleFont)
                    .foregroundColor(Color.highlight)
                    .frame(width: UIScreen.screenWidth-20, height: UIScreen.screenHeight/15)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                }
            }

            VStack {
                TextField("Email address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)
                    .padding()
                    .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                
                if !matchCheck {
                    Text("@handle not unique!")
                }
                TextField("@handle", text: $handle)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(Color.gray)
                    .padding()
                    .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(Color.gray)
                    .padding()
                    .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                if !matchCheck {
                    Text("Passwords do not match!")
                }
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .foregroundColor(Color.gray)
                    .padding()
                    .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                SecureField("Confirm password", text: $password2)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .foregroundColor(Color.gray)
                    .padding()
                    .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
            }
            //.padding(.top, 10)
            Spacer()
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
                    .padding()
                    .frame(width: UIScreen.screenWidth-70, height: UIScreen.screenHeight/15)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                    .buttonStyle(.borderedProminent)
            }
            Spacer()
            Text("Already have an account?")
                .font(Constants.textFont)
            Button {
                viewState = .login
            } label: {
                Text("Log in!")
                    .padding()
                    .frame(width: UIScreen.screenWidth-70, height: UIScreen.screenHeight/15)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                    .buttonStyle(.borderedProminent)
            }
            Spacer()
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
