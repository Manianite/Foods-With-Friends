//
//  FWFData.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/2/23.
//



import SwiftUI
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class UserData {
//    @MainActor static func writeData(_ data: Data, _ location: String) async {
//        let storage = Storage.storage().reference().child("\(location)")
//        let metadata = StorageMetadata()
//        metadata.contentType = "text/txt"
//        await storage.putData(data, metadata: metadata) { meta, error in }
//    }
    static func writeData(_ data: Data, _ location: String) {
        let storage = Storage.storage().reference().child("\(location)")
        let metadata = StorageMetadata()
        metadata.contentType = "text/txt"
        storage.putData(data, metadata: metadata) { meta, error in }
    }
    static func listFilesIn(_ dir: String) {
        let storage = Storage.storage().reference().child("\(dir)")
        storage.listAll { (result, error) in
            if let e = error {
                print("Error while listing all files: ", e)
            }
            if let r = result {
                for item in r.items {
                    print("Item in folder: ", item)
                }
            }
        }
    }
    static func deleteItem(_ location: String) {
        let item = Storage.storage().reference().child(location)
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
//    @MainActor static func readData(_ location: String) async -> Data {
//        let item = Storage.storage().reference().child(location)
//        var outputData = Data()
//        await item.getData(maxSize: Int64.max) { data, error in
//            if let error = error {
//                print("Error reading item", error)
//            } else if let data = data {
//                outputData = data
//            }
//        }
//        return outputData
//    }
    static func readData(_ location: String, _ completion: @escaping ((_ data: Data) -> ())) {
        let item = Storage.storage().reference().child(location)
        item.getData(maxSize: Int64.max) { data, error in
            if let error = error {
                print("Error reading item", error)
            } else if let data = data {
                 completion(data)
            }
        }
    }
    static func getUser(_ uid: String, _ completion: @escaping ((_ user: User) -> ())) {
        readData("users/\(uid)/user_profile.json") { data in
            do {
                let user: User = try JSONDecoder().decode(User.self, from: data)
                completion(user)
            } catch {
                print(error)
            }
        }
    }
    static func getUserDict(_ completion: @escaping ((_ userDict: UserDict) -> ())) {
        readData("users/user_dict.json") { data in
            do {
                let userDict = try JSONDecoder().decode(UserDict.self, from: data)
                completion(userDict)
            } catch {
                print("error!!! cannot decode user_list.json at UserData: 87")
            }
        }
    }
    static func clearUserList() {
        do {
            let JSONUserProfile = try JSONEncoder().encode(UserDict())
            UserData.writeData(JSONUserProfile, "users/user_dict.json")
        } catch {}
    }
}
struct Review: Codable {
    
}
