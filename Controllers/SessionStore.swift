import SwiftUI
import Foundation
import Firebase
import Combine
import GoogleSignIn


struct User {
    var uid: String
    var email: String?
    var photoURL: URL?
    var displayName: String?
    
    static let `default` = Self(
        uid: "sdfdsaf",
        displayName: "Jonathan Christie",
        email: "jtchristiedev@gmail.com",
        photoURL: nil
    )

    init(uid: String, displayName: String?, email: String?, photoURL: URL?) {
        self.uid = uid
        self.email = email
        self.photoURL = photoURL
        self.displayName = displayName
    }
}



/**
 * SessionStore manages the firebase user session. It contains the current user. It
 * also provides functions for signing up, signing in, etc.
 */

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var isLoggedIn = false { didSet { self.didChange.send(self) }}
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    @Published var cafes: [Cafe] = []

    init(session: User? = nil) {
        self.session = session
    }
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user \(user)")
                self.isLoggedIn = true
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email,
                    photoURL: user.photoURL
                )
            } else {
                self.isLoggedIn = false
                self.session = nil
            }
        }
    }
    

    

    
    func signInWithGoogle () {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signOut () -> Bool {
        print("user signed out")
        do {
            try Auth.auth().signOut()
              self.isLoggedIn = false
              self.session = nil
            return true
        } catch {
            return false
        }
    }
    func delete(){
        let user = Auth.auth().currentUser
        print("Account deleted")
            user?.delete { error in
                if error != nil {
                 // An error happened.
               } else {
                 // Account deleted.
               }
             }
    }
    
    // stop listening for auth changes
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
}
