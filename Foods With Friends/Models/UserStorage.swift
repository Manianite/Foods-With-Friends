//
//  UserStorage.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/10/23.
//

import SwiftUI
import FirebaseStorage

class UserStorage {
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
}
