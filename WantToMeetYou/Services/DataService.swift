//
//  DataService.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class DataService {
    
    var ref = Database.database(url: SecretData.URLS.firebaseRTDB).reference()
    
    func createUserAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let `self` = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let user = authResult?.user {
                let profile = UserProfile(uid: user.uid)
                
                self.ref.child("user_profiles").child(user.uid).setValue(profile.json)
            }
        }
    }
    
    func createUsersGroup() {
        guard let authedUser = Auth.auth().currentUser else { return }
        createUsersGroup(name: "Простая группа", usersUID: [authedUser.uid: .admin])
    }
    
    func createUsersGroup(name: String, usersUID: [String: UsersGroup.Role]) {
        let group = UsersGroup(name: name, usersUID: usersUID)
        
        ref.child("users_groups").child(group.uuid).setValue(group.json)
    }
    
    func saveUserLocation(coords: UserLocation.Coordinates) {
        guard let authedUser = Auth.auth().currentUser else { return }
        let location = UserLocation(coords: coords, modDate: Date().timeIntervalSince1970)
        
        ref.child("user_locations").child(authedUser.uid).setValue(location.json)
    }
    
    func getGroup(byUUID uuid: String) {
        ref.child("users_groups").child(uuid).getData { error, snapshot in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let value = snapshot?.value as? [String: Any], let group: UsersGroup = try? value.serialize() {
                print(group)
            }
        }
    }
}
