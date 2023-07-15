//
//  UserAccountService.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserAccountService {
    
    private var ref: DatabaseReference
    private var authorization: AuthorizationService
    private var userProfile: UserProfileDataService
    
    private init(
        ref: DatabaseReference,
        authorization: AuthorizationService,
        userProfile: UserProfileDataService
    ) {
        self.ref = ref
        self.authorization = authorization
        self.userProfile = userProfile
    }
    
    static func `default`(_ ref: DatabaseReference) -> UserAccountService {
        return .init(
            ref: ref,
            authorization: .init(),
            userProfile: .init(ref)
        )
    }
    
    var isLoggedIn: Bool {
        authorization.currentUser != nil
    }
    
    private var currentUserProfileObserverHandle: (String, UInt)? {
        didSet {
            if let (uid, handle) = oldValue {
                userProfile.removeObserver(byUid: uid, withHandle: handle)
            }
        }
    }
    
    func createAccount(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        authorization.create(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                let profile = UserProfile(uid: user.uid)
                
                self?.userProfile.save(profile) { error in
                    completion(error)
                }
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        authorization.signIn(email: email, password: password) { result in
            switch result {
            case .success(_):
                completion(nil)
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getCurrentUserProfile(completion: @escaping ((Result<(account: User, profile: UserProfile), Error>) -> Void)) {
        guard let user = authorization.currentUser else {
            completion(.failure(NetworkError.unknownError))
            return
        }
        return userProfile.observeSingle(byUid: user.uid) { result in
            switch result {
            case .success(let profile):
                completion(.success((user, profile)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func observeCurrentUserProfile(block: @escaping ((Result<(account: User, profile: UserProfile)?, Error>) -> Void)) -> (String, UInt)? {
        guard let user = authorization.currentUser else {
            block(.success(nil))
            return nil
        }
        
        let handle = userProfile.observe(byUid: user.uid) { result in
            switch result {
            case .success(let profile):
                block(.success((user, profile)))
                
            case .failure(let error):
                block(.failure(error))
            }
        }
        return (user.uid, handle)
    }
    
    func removeCurrentUserProfileObserver(byUid uid: String, withHandle handle: UInt) {
        userProfile.removeObserver(byUid: uid, withHandle: handle)
    }
    
    func logout() {
        authorization.signOut()
    }
}
