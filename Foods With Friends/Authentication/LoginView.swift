//
//  LoginView.swift
//  Midterm
//
//  Created by Speer-Zisook, Ella on 2/9/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @Binding var viewState: ViewState
    @EnvironmentObject var appUser: User
    @State var sentReset: Bool? = false
    @State var wrongPassword = false
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
                    
                }
            }
            Group{
                VStack{
                    TextField("Enter Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                        .background(sentReset==nil ? .red.opacity(0.2) : .white)
                    
                    SecureField("Enter Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                        .background(wrongPassword ? .red.opacity(0.2) : .white)
                        .submitLabel(.go)
                        .onSubmit {
                            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                                if let _=user {
                                    guard let uid = Auth.auth().currentUser?.uid else {return}
                                    UserData.getUser(uid) { user in
                                        appUser.reinit(user)
                                        UserDefaults.standard.set(uid, forKey: "userID")
                                        viewState = .home
                                    }
                                } else {
                                    print(error ?? "")
                                    wrongPassword = true
                                }
                            }
                        }
                }
                .padding(.top, 70)
                .padding(.bottom, 40)
            }
            Spacer()
            Button {
                Auth.auth().signIn(withEmail: email, password: password) { user, error in
                    if let _=user {
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        UserData.getUser(uid) { user in
                            appUser.reinit(user)
                            UserDefaults.standard.set(uid, forKey: "userID")
                            viewState = .home
                            //selectedTab = .HomeView
                        }
                    } else {
                        print(error ?? "")
                        wrongPassword = true
                    }
                }
            } label: {
                Text("Log In")
                    .padding()
                    .frame(width: UIScreen.screenWidth-70, height: UIScreen.screenHeight/15)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                    .buttonStyle(.borderedProminent)
            }
            .disabled(password.count<1 || email.count<1)
            .onAppear {
                if let uid: String = UserDefaults.standard.object(forKey: "userID") as? String {
                    UserData.getUser(uid) { user in
                        appUser.reinit(user)
                        viewState = .home
                    }
                } else {
                    print("no saved user found")
                }
            }
            Button {
                if email != "" {
                    sentReset = true
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let _=error {
                            print(error)
                            sentReset = nil
                        }
                    }
                } else {
                    sentReset = nil
                }
            } label: {
                Text(sentReset ?? false ? "Check your Email!" : "Forgot Password")
                    .padding()
                    .frame(width: UIScreen.screenWidth-70, height: UIScreen.screenHeight/15)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                    .buttonStyle(.borderedProminent)
                    .disabled(sentReset ?? false)
            }
            Spacer()
            Spacer()
            Text("Don't have an account?")
                .font(Constants.textFont)
            Button {
                viewState = .signup
            } label: {
                Text("Sign up!")
                   // .padding()
                    .frame(width: UIScreen.screenWidth-70, height: UIScreen.screenHeight/15)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 10)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewState: Binding.constant(.login))
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
