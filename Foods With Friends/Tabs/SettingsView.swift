//
//  SettingsView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/7/23.
//

import SwiftUI
import FirebaseAuth
import UIKit

struct SettingsView: View {
    @EnvironmentObject var appUser: User
    @EnvironmentObject var locationManager: LocationManager
    @Binding var viewState: ViewState
    @State var passwordChangeMode = false
    @State var emailChangeMode = false
    @State var handleChangeMode = false
    @State var locationChangeMode = false
    @State var newPassword = ""
    @State var newHandle = ""
    @State var newEmail = ""
    @State var isHidden = true
    @State var confirmation = false
    @State var presentPopup = false
    private let notificationPublisher = NotificationPublisher()
    
    var handleCheck: Bool {!UserData.userDict.contains {$0.value.handle == newHandle}}
    
    var body: some View {
        
        VStack{
            Group{
                Text("Settings")
                    .font(.headline)
                    .padding(10)
//            Text("Settings")
//                .font(Constants.titleFont)
//                .padding(.top, 20)
//                .padding(.bottom, 30)
//                .accentColor(.highlight)
            
            
            Group {

                //button for change password
                Button {
                    if passwordChangeMode == false{
                        passwordChangeMode = true
                    }
                    else {
                        passwordChangeMode = false
                    }
                    handleChangeMode = false
                    emailChangeMode = false
                    locationChangeMode = false

                } label: {
                    Text("Change Password")
                        .frame(width: UIScreen.screenWidth/1.3)
                        .font(Constants.textFont)
                        .accentColor(.black.opacity(0.8))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 1)
                        )
                }.padding(.vertical, 10)
                
                //shows textfield or securefield for password
                if passwordChangeMode {
                    VStack {
                        if isHidden {
                            HStack {
                                SecureField("Enter new password", text: $newPassword)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.black.opacity(0.5), lineWidth: 1)
                                         
                                    )
                                    .font(Constants.textFont)
                                    .padding(.top, 20)
                                    .padding(.leading, 30)
                                Button(){
                                    isHidden = false
                                } label: {
                                    Image(systemName: "eye")
                                        .padding(.trailing, 20)
                                        .padding(.top, 20)
                                        .accentColor(Color.highlight)
                                }
                            }
                        }
                        else {
                            HStack{
                                TextField("Enter new password", text: $newPassword)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.black.opacity(0.5), lineWidth: 1)
                                    )
                                    .font(Constants.textFont)
                                    .padding(.top, 20)
                                    .padding(.leading, 30)
                                Button{
                                    isHidden = true
                                } label: {
                                    Image(systemName: "eye.slash")
                                        .padding(.trailing, 20)
                                        .padding(.top, 20)
                                }
                            }
                        }
                        
                        //asks user to confirm password change
                        Button {
                            guard let pass = Auth.auth().currentUser?.updatePassword(to: newPassword) else {return}
                            
                            passwordChangeMode = false
                        } label: {
                            Text("Confirm Password Change")
                                .font(Constants.textFont)
                                .accentColor(.highlight)
                                .padding(.bottom, 10)
                            
                        }
                    }
                }
            }
            
            //            Button {
            //                //confirmation = true
            //                presentPopup = true
            //            } label: {
            //                Text("Delete Account")
            //                    .font(Constants.titleFont)
            //                    .accentColor(.highlight)
            //                    .popover(isPresented: $presentPopup, content: {
            //                        Button{
            //                            //Auth.auth().currentUser?.delete()
            //                            Auth.auth().currentUser!.uid
            //                            UserData.remove("users/\(appUser.uid)")
            //                            UserData.remove("users/user_dict/\(appUser.uid)")
            //                            viewState = .login
            //                        }label: {
            //                            Text("Confirm delete account?")
            //                        }
            //                    })
            //            }
            
            
            Group{
                //button for changing handle
                Button{
                    if handleChangeMode == false{
                        handleChangeMode = true
                    }
                    else {
                        handleChangeMode = false
                    }
                    emailChangeMode = false
                    passwordChangeMode = false
                    locationChangeMode = false

                }label: {
                    Text("Change handle")
                        .frame(width: UIScreen.screenWidth/1.3)
                        .font(Constants.textFont)
                        .accentColor(.black.opacity(0.8))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 1)
                        )
                        .padding(.vertical, 10)

                    
                }
                
                //shows textfield for handle change
                if handleChangeMode == true {
                    VStack{
                        TextField("Enter new handle", text: $newHandle)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black.opacity(0.5), lineWidth: 1)
                            )
                            .font(Constants.textFont)
                            .padding(.top, 20)
                            .padding(.horizontal, 30)
                        Button{
                            appUser.handle = newHandle
                            UserData.pushUser(appUser)

                            handleChangeMode = false
                            
                        }label: {
                            Text("Confirm Handle Change")
                                .font(Constants.textFont)
                                .foregroundColor(Color.highlight)
                                .padding(.bottom, 10)
                        }

                        .disabled(handleCheck)
                    }
                    .onAppear {
                        UserData.observeUserDict()
                    }
                    .onDisappear {
                        UserData.stopObservingUserDict()

                    }
                    
                }
                
                //button to change email
                Button{
                    if emailChangeMode == false{
                        emailChangeMode = true
                    }
                    else {
                        emailChangeMode = false
                    }
                    handleChangeMode = false
                    passwordChangeMode = false
                    locationChangeMode = false
                    
                }label: {
                    Text("Change email")
                        .frame(width: UIScreen.screenWidth/1.3)
                        .font(Constants.textFont)
                        .accentColor(.black.opacity(0.8))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 1)
                        )
                        .padding(.vertical, 10)
                    
                }
                
                //shows textfield for email change
                if emailChangeMode == true {
                    VStack{
                        TextField("Enter new email", text: $newEmail)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black.opacity(0.5), lineWidth: 1)
                            )
                            .font(Constants.textFont)
                            .padding(.top, 20)
                            .padding(.horizontal, 30)
                        Button{
                            appUser.handle = newHandle
                            UserData.pushUser(appUser)
                            emailChangeMode = false
                        }label: {
                            Text("Confirm Email Change")
                                .font(Constants.textFont)
                                .accentColor(.highlight)
                                .padding(.bottom, 10)
                        }
                    }
                }
                
                //button to change location settings
                Button{
                    if locationChangeMode == false{
                        locationChangeMode = true
                    }
                    else{
                        locationChangeMode = false
                    }
                    handleChangeMode = false
                    passwordChangeMode = false
                    emailChangeMode = false
                }label: {
                    Text("Location Services")
                        .frame(width: UIScreen.screenWidth/1.3)
                        .font(Constants.textFont)
                        .accentColor(.black.opacity(0.8))
                        .padding(.vertical, 10)
                        .padding(.horizontal)

                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 1)
                        )
                        .padding(.vertical, 10)
                    
                }
                
                //shows options for location settings
                if locationChangeMode == true {
                    VStack{
                        Button{
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            locationChangeMode = false
                        }label: {
                            Text("Update Location Preferences")
                                .font(Constants.textFont)
                                .accentColor(.highlight)
                                .padding(.bottom, 10)
                        }
                    }
                }
                
                
                Spacer()
                
                Button {
                    UserDefaults.standard.removeObject(forKey: "userID")
                    viewState = .login
                } label: {
                    VStack{
                        Text("Log Out")
                            .frame(width: UIScreen.screenWidth/1.3)
                            .font(Constants.textFont)
                            .accentColor(.black.opacity(0.8))
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 1)
                            )
                            .background(Color.highlight.opacity(0.5).cornerRadius(16))
                            .padding(.vertical, 20)
                    }
                }
            }
//            Spacer()
//
//
//            //testing for posting reviews
//            Button {
//                let time = Date().timeIntervalSince1970
//                UserData.pushReview(Review(time: time), toFriendsOf: appUser)
//                appUser.reviews[String(time)] = Review(time: time)
//            } label: {
//                Text("Push Test Review")
//                    .font(Constants.textFont)
//                    .accentColor(.highlight)
//            }
//            .disabled(true)
//
//            Button{
//                notificationPublisher.sendNotification(title: "hey", subtitle: "we made a cool", body: "notification", badge: 1, delayInterval: nil)
//
//            } label: {
//                Text("test notification")
//            }
 
            
            //            //testing for posting reviews
            //            Button {
            //                let time = Date().timeIntervalSince1970
            //                UserData.pushReview(Review(time: time), toFriendsOf: appUser)
            //                appUser.reviews[String(time)] = Review(time: time)
            //            } label: {
            //                Text("Push Test Review")
            //                    .font(Constants.textFont)
            //                    .accentColor(.highlight)
            //                    .disabled(true)
            //            }
            
            
                        //.padding(.vertical, 10)
                    
                }               
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewState: Binding.constant(.home))
            .environmentObject(LocationManager())
    }
}
