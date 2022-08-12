//
//  TheaterMapViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation

class TheaterMapViewController: UIViewController {
    
    static let identifier = "TheaterMapViewController"

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let theaterList = TheaterList()
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:  37.4824761978647, longitude: 126.9521680487202)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navi = navigationItem
        navi.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBackButtonClicked))
        navi.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        
        locationManager.delegate = self
    
        setRegionAndAnnotationSecond(center: center, theater: theaterList.mapAnnotations)
    }
    
    @objc func goBackButtonClicked() {
       dismiss(animated: true)
   }
    
    @objc func filterButtonClicked() {
        showAlertController()
    }

    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D, title: String) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 3000, longitudinalMeters: 3000)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        
        var theaterInfo:[MKPointAnnotation] = []
        
        let location: [Theater] = []

        for i in location {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            annotation.title = "\(i.location)"
            theaterInfo.append(annotation)
        }
        
        map.addAnnotation(annotation)
        map.addAnnotations(theaterInfo)
        
    }
    
    func setRegionAndAnnotationSecond(center: CLLocationCoordinate2D, theater: [Theater]) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.setRegion(region, animated: true)
        
        var theaterInfo:[MKPointAnnotation] = []

        for i in theater {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            annotation.title = "\(i.location)"
            theaterInfo.append(annotation)
        }
        
        map.addAnnotations(theaterInfo)
        
    }
    
    
    
    func actionSheetAlert(_ action: UIAlertAction) {
        map.removeAnnotations(map.annotations)
        for actionSheet in theaterList.mapAnnotations {
            if action.title == actionSheet.type {
                setRegionAndAnnotation(center: CLLocationCoordinate2D(latitude: actionSheet.latitude, longitude: actionSheet.longitude), title: actionSheet.location)
            }
        }
    }
   
    
    func showAlertController() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let mega = UIAlertAction(title: "메가박스", style: .default) { mega in
            self.actionSheetAlert(mega)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { lotte in
            self.actionSheetAlert(lotte)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { cgv in
            self.actionSheetAlert(cgv)
        }
        let total = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.map.removeAnnotations(self.map.annotations)
            for location in self.theaterList.mapAnnotations {
                self.setRegionAndAnnotation(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), title: location.location)
            }
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(mega)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(total)
        alert.addAction(cancle)
        
        present(alert, animated: true, completion: nil)
    }


}

extension TheaterMapViewController {
    func checkUserDeviceLoactionServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치서비스가 꺼져 있어서 위치 권한 요청을 못 합니다")
        }
    }
    
    
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        switch authorizationStatus {
        case .notDetermined:
            print("NotDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Denied, 아이폰 설정으로 유도")
            showRequestLocationServiceAlert()
            setRegionAndAnnotation(center: center, title: "청년취업사관학교 영등포 캠퍼스")
        case .authorizedWhenInUse:
            print("When In USe")
            locationManager.startUpdatingLocation()
            
        default: print("Default")
        }
    }
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
        
          //실제 설정으로 이동
          //설정까지 이동하거나 설정 세부화면까지 이동하거나
          //한번도 설정에 들어가지 않았거나 막 다운받은 앱이거나
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
          
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }

}

extension TheaterMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate, title: "내 현재 위치")
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLoactionServiceAuthorization()
    }
    
    
    
}


