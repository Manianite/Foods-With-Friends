//
//  FWFData.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/2/23.
//


import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class DatabaseData {
    func uploadProfilePicture(_ image: UIImage, _ completion: @escaping((_ url:URL?) -> ())){
        // get the current user's userid
        guard let uid = Auth.auth().currentUser?.uid else {return}
        // get a reference to the storage object
        let storage = Storage.storage().reference().child("user/\(uid)")
        // image's must be saved as data obejct's so convert and compress the image.
        guard let image = imageView?.image, let imageData = UIImageJPEGRepresentation(image, 0.75) else {return}
        // store the image
        storage.putData(imageData, metadata: StorageMetadata()) { (metaData, error) in
        }
    }
}
