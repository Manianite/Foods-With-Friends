////
////  FWFData.swift
////  Foods With Friends
////
////  Created by Speer-Zisook, Ella on 3/2/23.
////
//
//
//import Foundation
//import FirebaseStorage
//import FirebaseDatabase
//import FirebaseAuth
//



import SwiftUI
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class UserData {
    @MainActor static func writeData(_ data: Data, _ location: String) async {
        let storage = Storage.storage().reference().child("\(location)")
        let metadata = StorageMetadata()
        metadata.contentType = "text/txt"
        await storage.putData(data, metadata: metadata) { meta, error in }
    }
    static func writeDataPatently(_ data: Data, _ location: String) {
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
    static func deleteItem(location: String) {
        let item = Storage.storage().reference().child(location)
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
    @MainActor static func readData(location: String) async -> Data {
        let item = Storage.storage().reference().child(location)
        var outputData = Data()
        await item.getData(maxSize: Int64.max) { data, error in
            if let error = error {
                print("Error reading item", error)
            } else if let data = data {
                outputData = data
            }
        }
        return outputData
    }
    static func readDataPatiently(location: String, _ completion: @escaping ((_ data: Data) -> ())) {
        let item = Storage.storage().reference().child(location)
        item.getData(maxSize: Int64.max) { data, error in
            if let error = error {
                print("Error reading item", error)
            } else if let data = data {
                 completion(data)
            }
        }
    }
}
