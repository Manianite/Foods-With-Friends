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
            Group{
                VStack{
                Image("loginlogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenWidth/2.5)
                    .padding(.top, 20)
                    .padding()
//                Text("Foods With Friends")
//                    .font(.system(size: 45))
//                    .font(.largeTitle)
//                    .font(Constants.titleFont)
//                    .foregroundColor(Color.highlight)
//                    .frame(width: UIScreen.screenWidth-20, height: UIScreen.screenHeight/15)
//                    .scaledToFill()
//                    .minimumScaleFactor(0.5)
//                    .lineLimit(1)
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

                TextField("Username", text: $handle)
                    .textCase(.lowercase)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(Color.gray)
                    .padding()
                    .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                    .background(handleCheck ? .white : .red.opacity(0.2))
                
                TextField("Name", text: $username)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(Color.gray)
                    .padding()
                    .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
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
                    .background(matchCheck ? .white : .red.opacity(0.2))
                    .submitLabel(.go)
                    .onSubmit {
                        Auth.auth().createUser(withEmail: email, password: password) { user, error in
                            if let _=user {
                                guard let uid = Auth.auth().currentUser?.uid else {return}
                                appUser.reinit(username: username, handle: handle, uid: uid)
                                UserData.appendUserDict(uid, PublicUser(username: username, handle: handle, uid: uid))
                                UserData.pushUser(appUser)
                                UserData.stopObservingUserDict()
                                viewState = .home
                            } else {
                                print(error ?? "")
                            }
                        }
                    }
            }
            Spacer()

            Button {
                Auth.auth().createUser(withEmail: email, password: password) { user, error in
                    if let _=user {
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        appUser.reinit(username: username, handle: handle, uid: uid)
                        UserData.appendUserDict(uid, PublicUser(username: username, handle: handle, uid: uid))
                        UserData.pushUser(appUser)
                        UserData.setValue(uid, to: "users/handle_to_uid/\(handle)")
                        UserData.stopObservingUserDict()
                        UserDefaults.standard.set(uid, forKey: "userID")
                        viewState = .home
                    } else {
                        print(error ?? "")
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
            .disabled(!(matchCheck && handleCheck))
            .onAppear {
                UserData.observeUserDict()
            }
            .onDisappear {
                UserData.stopObservingUserDict()
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

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(viewState: Binding.constant(.signup))
    }
}
