//
//  GodService.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import Foundation
import FirebaseDatabase

class GodDataService {
    
    var userAccount: UserAccountService
    var usersGroup: UsersGroupDataService
    
    private init(
        userAccount: UserAccountService,
        usersGroup: UsersGroupDataService
    ) {
        self.userAccount = userAccount
        self.usersGroup = usersGroup
    }
    
    static var shared: GodDataService = {
        let ref = Database.database(url: SecretData.URLS.firebaseRTDB).reference()
        
        return .init(
            userAccount: .default(ref),
            usersGroup: .init(ref)
        )
    }()
}
