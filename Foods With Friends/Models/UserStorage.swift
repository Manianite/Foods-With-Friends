//
//  UserStorage.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/10/23.
//

import SwiftUI
import FirebaseStorage

class UserStorage {
    private static let ref = Storage.storage().reference()
    static func putImage(_ image: UIImage, url: String, _ completion: @escaping((_ url:URL?, _ error: Error?) -> ())) {
        let storage = ref.child(url)
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        storage.putData(imageData, metadata: StorageMetadata()) { (metaData, error) in
            if error == nil && metaData != nil {
                storage.downloadURL { url, error in
                    guard let downloadURL = url else { return }
                    completion(downloadURL, nil)
                }
            } else {
                completion(nil, error)
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
