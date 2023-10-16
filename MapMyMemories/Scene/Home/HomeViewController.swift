//
//  HomeViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/26.
//


import UIKit
import CoreLocation
import CoreLocationUI
import MapKit
import Floaty
import RealmSwift

final class HomeViewController: BaseViewController{
    //MARK: - Properties
    let mainView = HomeView()
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    var memoryData: Results<MemoryDB>?
    
    
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        setAnnotation()
    }
    
    //MARK: - Configure
    override func configure() {
        mainView.mapView.showsUserLocation = true
        mainView.floatingButton.addItem("기록하기", icon: UIImage(systemName: "pencil.line")) { item in
            self.navigationController?.pushViewController(WriteViewController(), animated: true)
        }
        locationManager.delegate = self
        mainView.locationButton.addTarget(self, action: #selector(tappedLocationButton), for: .touchUpInside)
        checkDeviceAuthorization()
    }
    
    
    //MARK: - SetNavigation
    override func setNavigation() {
    }
    
    //MARK: - Action
    @objc func tappedLocationButton(_ sender: CLLocationButton){
        self.locationManager.startUpdatingLocation()
    }
    
    //MARK: - Helper
    
    func checkDeviceAuthorization(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                let status: CLAuthorizationStatus = self.locationManager.authorizationStatus
                
                DispatchQueue.main.async {
                    self.checkUserAuthorization(authorization: status)
                }
            }
        }
    }
    
    func checkUserAuthorization(authorization: CLAuthorizationStatus){
        switch authorization {
        case .notDetermined:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            showAuthorizationAlert()
            setUserLocation()
        case .denied:
            showAuthorizationAlert()
            setUserLocation()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        case .authorized:
            self.locationManager.startUpdatingLocation()
        @unknown default:
            print("UnknownLocationAuthorization")
        }
    }
    
    func showAuthorizationAlert(){
        let alert = UIAlertController(title: "위치 권한 허용이 필요합니다.", message: "위치 서비스를 사용할 수 없습니다.\n기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정 이동", style: .default) { action in
            if let settingURL = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(settingURL)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [goSetting, cancel].forEach { action in
            alert.addAction(action)
        }
        
        self.present(alert, animated: true)
    }
    
    func setUserLocation(_ coordinate: CLLocationCoordinate2D? = nil){
        let region: MKCoordinateRegion
        let defaultMeter: CLLocationDistance = 500
        
        if let coordinate {
            region = MKCoordinateRegion(center: coordinate, latitudinalMeters: defaultMeter, longitudinalMeters: defaultMeter)
        } else {
            //서울 시청 기본 위치 : 37.566713, 126.978428
            let defaultLocation = CLLocationCoordinate2D(latitude: 37.566713, longitude: 126.978428)
            
            region = MKCoordinateRegion(center: defaultLocation, latitudinalMeters: defaultMeter, longitudinalMeters: defaultMeter)
        }
        
        mainView.mapView.setRegion(region, animated: true)
        
    }
    
    func setAnnotation(){
        RealmManager.shared.readAllRecord(type: MemoryDB.self) { results in
            self.memoryData = results
        }
        guard let memoryData else {
            print("none MemoryData")
            return}
        
        var annotations: [MKPointAnnotation] = []
        
        for element in memoryData{
            guard let lat = element.address?.lat, let long = element.address?.long else {  
                print("failed load Address")
                return }
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = lat
            annotation.coordinate.longitude = long
            annotations.append(annotation)
        }
        
        mainView.mapView.addAnnotations(annotations)
    }
}

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else {return}
        setUserLocation(location)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.makeToastMessage(errorType: .failedloadLocation)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceAuthorization()
    }
    
}
