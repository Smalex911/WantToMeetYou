//
//  ViewController.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import UIKit
import FirebaseCrashlytics
import YandexMapsMobile

class ViewController: UIViewController {
    
    @objc public var mapView: YMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = YMKMapView(frame: view.bounds, vulkanPreferred: UIApplication.isM1Simulator())
        mapView.mapWindow.map.mapType = .vectorMap
        view.insertSubview(mapView, at: 0)
    }
}

