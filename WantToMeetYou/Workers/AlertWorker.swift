//
//  AlertWorker.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import UIKit

class AlertWorker {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func display(title: String? = nil, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        viewController?.present(alert, animated: true)
    }
    
    func requestAuthorization(authorizationBlock: @escaping ((_ email: String, _ password: String) -> Void), registerBlock: @escaping ((_ email: String, _ password: String) -> Void)) {
        let alert = UIAlertController(title: "Введите данные авторизации", message: nil, preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "E-mail"
        }
        alert.addTextField() { textField in
            textField.placeholder = "Пароль"
            textField.isSecureTextEntry = true
        }
        alert.addAction(.init(title: "Войти", style: .default, handler: { _ in
            guard let email = alert.textFields?[0].text, let password = alert.textFields?[1].text else { return }
            authorizationBlock(email, password)
        }))
        alert.addAction(.init(title: "Зарегистрироваться", style: .default, handler: { _ in
            guard let email = alert.textFields?[0].text, let password = alert.textFields?[1].text else { return }
            registerBlock(email, password)
        }))
        alert.addAction(.init(title: "Отменить", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        viewController?.present(alert, animated: true)
    }
}
