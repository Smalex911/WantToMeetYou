//
//  AuthorizationService.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import Foundation
import FirebaseAuth

class AuthorizationService {
    
    init() {
    }
    
    private var sharedAuth: Auth {
        Auth.auth()
    }
    
    var currentUser: User? {
        sharedAuth.currentUser
    }
    
    func create(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        sharedAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                completion(.success(user))
            } else {
                completion(.failure(error ?? NetworkError.unknownError))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        sharedAuth.signIn(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                completion(.success(user))
            } else {
                completion(.failure(error ?? NetworkError.unknownError))
            }
        }
    }
    
    func signOut() {
        try? sharedAuth.signOut()
    }
}
