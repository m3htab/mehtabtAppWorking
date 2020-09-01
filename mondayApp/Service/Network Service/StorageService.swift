
import Foundation
import Firebase

class StorageService {
    

    static func createUserWithPicture(userId: String, firstName: String,lastName: String, email: String, imageData: Data, metadata: StorageMetadata, storagePictureRef: StorageReference, onSuccess: @escaping(_ state: Bool) -> Void) {
        print("NETWORK CALL: create user storage")
        storagePictureRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
            if error != nil {
                return
            }
            storagePictureRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = firstName
                        changeRequest.commitChanges { (error) in
                        if error != nil {
                            return
                        }}
                    }
                                
                    UserService.createNewUser(id:userId, firstName: firstName, lastName: lastName,email: email, largeProfilePicture: metaImageUrl, completion: { state in
                        if state{
                            onSuccess(true)
                        }
                        else{
                            onSuccess(false)
                        }
                    })

                }
            }
        }
                
    }
}

