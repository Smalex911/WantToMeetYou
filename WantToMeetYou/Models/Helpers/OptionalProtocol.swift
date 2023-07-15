//
//  OptionalProtocol.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import Foundation

protocol OptionalProtocol {
    var isNil: Bool { get }
}

extension Optional : OptionalProtocol {
    var isNil: Bool {
        return self == nil
    }
}
