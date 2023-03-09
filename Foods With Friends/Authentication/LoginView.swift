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
            Group{
                Image("logo")
                    .padding(.top)
                Text("Foods With Friends")
                    .font(.system(size: 45))
                
                    .font(.largeTitle)
                    .font(Constants.titleFont)
                    .foregroundColor(Color.highlight)
                
            }
            Spacer()
            Group{
                VStack{
                    Spacer()
                    TextField("Enter Username", text: $username)
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: UIScreen.screenWidth-40)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.highlight))
                    
                    SecureField("Enter Password", text: $password)
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: UIScreen.screenWidth-40)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.highlight))
                }
                .padding(.top, 70)
                .padding(.bottom, 40)
            }
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
                Text("Log In")
                    .padding()
                    .frame(width: UIScreen.screenWidth-70)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                //.controlSize(.small) // .large, .medium or .small
                    .buttonStyle(.borderedProminent)
                // .padding(.top, 70)
            }
            Button {
                Auth.auth().sendPasswordReset(withEmail: username) { error in
                    if let _=error {
                        print(error)
                    }
                }
            } label: {
                Text("Forgot Password")
                    .padding()
                    .frame(width: UIScreen.screenWidth-70)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                //.controlSize(.small) // .large, .medium or .small
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 100)
            }
            Spacer()
            Text("Don't have an account?")
                .font(Constants.textFont)
            Button {
                viewState = .signup
            } label: {
                Text("Sign up!")
                    .padding()
                    .frame(width: UIScreen.screenWidth-70)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                //.controlSize(.small) // .large, .medium or .small
                    .buttonStyle(.borderedProminent)
            }
            Spacer()
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
