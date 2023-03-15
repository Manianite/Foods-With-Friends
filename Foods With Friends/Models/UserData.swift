//
//  UserData.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/2/23.
//



import SwiftUI
import FirebaseDatabase

class UserData {
    private static var ref = Database.database().reference()
    
    static func pushUser(_ user: User) {
        ref.child("users/\(user.uid)").updateChildValues(user.toDictionnary)
        ref.child("users/user_dict/\(user.uid)").updateChildValues(PublicUser(user).toDictionnary)
    }
    static func remove(_ url: String) {
        ref.child(url).removeValue()
    }
    static func setValue(_ value: Any, to url: String) {
        ref.child(url).setValue(value)
    }
    static func getBranch<T>(from url: String, as type: T.Type, _ completion: @escaping ((_ obj: T) -> ())) where T: Codable {
        ref.child(url).observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                print("ERROR!!! cannot get branch")
                return
            }
            do {
                completion(try dict.asObject(T.self, from: dict))
            } catch {
                print("ERROR!!! cannot convert branch")
            }
        }
    }
    static func getUser(_ uid: String, _ completion: @escaping ((_ user: User) -> ())) {
        ref.child("users/\(uid)").observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                print("ERROR!!! cannot get user")
                return
            }
            do {
                completion(try dict.asObject(User.self, from: dict))
            } catch {
                print("ERROR!!! cannot convert user")
            }
        }
    }
    static func getPublicUser(_ uid: String, _ completion: @escaping ((_ user: PublicUser) -> ())) {
        ref.child("users/user_dict/\(uid)").observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                print("ERROR!!! cannot get public user")
                return
            }
            do {
                completion(try dict.asObject(PublicUser.self, from: dict))
            } catch {
                print("ERROR!!! cannot convert public user")
            }
        }
    }
    static var userDict:[String: PublicUser] = [:]
    static var userDictObserver: DatabaseReference = ref.child("users/user_dict")
    static func observeUserDict() {
        userDictObserver.observe(.value) { snapshot in
            let dict = snapshot.value as? [String: Any] ?? [:]
            do {
                userDict = try dict.asObject([String: PublicUser].self, from: dict)
            } catch {
                print("ERROR!!! cannot get user_dict")
            }
        }
    }
    static func stopObservingUserDict() {
        userDictObserver.removeAllObservers()
    }
    
    static var observedUser: User = User()
    static var userObserver: DatabaseReference = ref.child("users/uid/")
    static func observeUser(for uid: String, _ completion: @escaping ((_ user: User) -> ())) {
        userObserver = ref.child("users/\(uid)")
        userObserver.observe(.value) { snapshot in
            let dict = snapshot.value as? [String: Any] ?? [:]
            do {
                observedUser = try dict.asObject(User.self, from: dict)
                completion(observedUser)
            } catch {
                print("ERROR!!! cannot get new_friends")
            }
        }
    }
    static func stopObservingUser() {
        userObserver.removeAllObservers()
    }
    
    static func appendUserDict(_ uid: String, _ user: PublicUser) {
        ref.child("users/user_dict/\(uid)").updateChildValues(user.toDictionnary)
    }
}
