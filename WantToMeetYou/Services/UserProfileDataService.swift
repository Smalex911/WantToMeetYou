//
//  UserProfileDataService.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import Foundation
import FirebaseDatabase

class UserProfileDataService {
    
    private var userProfilePathName = "user_profiles"
    private var ref: DatabaseReference
    
    init(_ ref: DatabaseReference) {
        self.ref = ref
    }
    
    func save(_ profile: UserProfile, completion: @escaping (Error?) -> Void) {
        ref.child(userProfilePathName).child(profile.uid).setValue(profile.json) { (error, _) in
            completion(error)
        }
    }
    
    func observeSingle(byUid uid: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        ref.child(userProfilePathName).child(uid).observeSingleEvent(
            of: .value,
            with: { snapshot in
                if let profile: UserProfile = snapshot.serializeValue() {
                    completion(.success(profile))
                } else {
                    completion(.failure(NetworkError.unknownError))
                }
            },
            withCancel: { error in
                completion(.failure(error))
            }
        )
    }
    
    func observe(byUid uid: String, block: @escaping (Result<UserProfile, Error>) -> Void) -> UInt {
        ref.child(userProfilePathName).child(uid).observe(
            .value,
            with: { snapshot in
                if let profile: UserProfile = snapshot.serializeValue() {
                    block(.success(profile))
                } else {
                    block(.failure(NetworkError.unknownError))
                }
            },
            withCancel: { error in
                block(.failure(error))
            }
        )
    }
    
    func removeObserver(byUid uid: String, withHandle handle: UInt) {
        ref.child(userProfilePathName).child(uid).removeObserver(withHandle: handle)
    }
}
