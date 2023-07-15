//
//  Ext+UIButton.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 15.07.2023.
//

import UIKit

extension UIButton {
    
    func styleTitle(_ title: String?) {
        UIView.performWithoutAnimation {
            setTitle(title, for: .normal)
            layoutIfNeeded()
        }
    }
    
    func styleLogin() {
        backgroundColor = .clear
        
        setBackgroundImage(nil, for: .normal)
        setImage(nil, for: .normal)
        
        styleTitle("Войти")
    }
    
    func styleLogout() {
        backgroundColor = .clear
        
        setBackgroundImage(nil, for: .normal)
        setImage(nil, for: .normal)
        
        styleTitle("Выйти")
    }
}
