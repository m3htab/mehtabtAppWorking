
import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage

class AuthNetworkService {
    
    static func signInUser(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        //print("NETWORK CALL: sign in")
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                print(error!.localizedDescription)
                onError(error!.localizedDescription)
                return
            }
            guard let userId = authData?.user.uid else { return }
        }
    }
    
    static func signupUserWithPicture(firstName: String,lastName: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ state: Bool) -> Void) {
      // print("NETWORK CALL: create user")
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
                
        if error != nil {
            print(error!.localizedDescription)
            return
        }
            
        //get created users id
        guard let userId = authData?.user.uid else { return }
        
        //create storage reference to new users profile picture
        let storagePictureUserId = Ref.STORAGE_PROFILE_PICTURE_USERID(userId: userId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        //save profile picture to storage and save user doc
        StorageService.createUserWithPicture(userId: userId, firstName: firstName, lastName: lastName, email: email, imageData: imageData, metadata: metadata, storagePictureRef: storagePictureUserId, onSuccess: onSuccess)
       
        }
    }
}
