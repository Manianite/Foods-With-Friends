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
    var body: some View {
        VStack {
            Group{
                VStack{
                Image("logo")
                    .resizable()
                    .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenWidth/3)
                    .padding(.top)
                
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
            Group{
                VStack{
                    TextField("Enter Username", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                    
                    SecureField("Enter Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: UIScreen.screenWidth-40, height: UIScreen.screenHeight/15)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                }
                .padding(.top, 70)
                .padding(.bottom, 5)
            }
            Button {
                Auth.auth().signIn(withEmail: email, password: password) { user, error in
                    if let _=user {
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        UserData.getUser(uid) { user in
                            appUser.reinit(user)
                            viewState = .home
                        }
                    } else {
                        print(error ?? "")
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
                    .padding(.bottom, 35)
            }
            .disabled(password.count<1 || email.count<1)
            Button {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let _=error {
                        print(error)
                    }
                }
            } label: {
                Text("Forgot Password")
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
            Text("Don't have an account?")
                .font(Constants.textFont)
            Button {
                viewState = .signup
            } label: {
                Text("Sign up!")
                    .padding()
                    .frame(width: UIScreen.screenWidth-70, height: UIScreen.screenHeight/15)
                    .background(Color.highlight.opacity(0.1))
                    .cornerRadius(100)
                    .background(RoundedRectangle(cornerRadius: 100).stroke().foregroundColor(Color.highlight))
                    .tint(Color.black)
                    .font(Constants.textFont)
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 15)
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
