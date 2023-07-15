//
//  ViewController.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import UIKit
import YandexMapsMobile

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var labelEmail: UILabel!
    @objc public var mapView: YMKMapView!
    
    lazy var alertWorker = AlertWorker(viewController: self)
    
    var currentUserProfileObserverData: (String, UInt)? {
        didSet {
            if let (uid, handle) = oldValue {
                GodDataService.shared.userAccount.removeCurrentUserProfileObserver(byUid: uid, withHandle: handle)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = YMKMapView(frame: view.bounds, vulkanPreferred: UIApplication.isM1Simulator())
        mapView.mapWindow.map.mapType = .vectorMap
        view.insertSubview(mapView, at: 0)
        
        buttonLogin.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
        buttonLogout.addTarget(self, action: #selector(logoutHandler), for: .touchUpInside)
        
        style()
        updateLoggedState()
        observeCurrentUserProfile()
    }
    
    func style() {
        buttonLogin.styleLogin()
        buttonLogout.styleLogout()
    }
    
    func updateLoggedState() {
        let isLoggedIn = GodDataService.shared.userAccount.isLoggedIn
        buttonLogin.isHidden = isLoggedIn
        buttonLogout.isHidden = !isLoggedIn
    }
    
    @objc func loginHandler() {
        alertWorker.requestAuthorization { [weak self] email, password in
            self?.login(email: email, password: password)
        } registerBlock: { [weak self] email, password in
            self?.createAccount(email: email, password: password)
        }
    }
    
    private func createAccount(email: String, password: String) {
        GodDataService.shared.userAccount.createAccount(email: email, password: password) { [weak self] error in
            guard let `self` = self else { return }
            self.updateLoggedState()
            self.observeCurrentUserProfile()
            
            if let error = error {
                self.alertWorker.display(message: error.localizedDescription)
            } else {
                self.alertWorker.display(message: "Аккаунт успешно создан")
            }
        }
    }
    
    private func login(email: String, password: String) {
        GodDataService.shared.userAccount.login(email: email, password: password) { [weak self] error in
            guard let `self` = self else { return }
            self.updateLoggedState()
            self.observeCurrentUserProfile()
            
            if let error = error {
                self.alertWorker.display(message: error.localizedDescription)
            }
        }
    }
    
    @objc func logoutHandler() {
        GodDataService.shared.userAccount.logout()
        updateLoggedState()
        observeCurrentUserProfile()
    }
    
    func observeCurrentUserProfile() {
        currentUserProfileObserverData = GodDataService.shared.userAccount.observeCurrentUserProfile { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let value):
                self.labelEmail.text = value?.account.email
                
            case .failure(let error):
                self.labelEmail.text = nil
                self.alertWorker.display(message: error.localizedDescription)
            }
        }
    }
}

