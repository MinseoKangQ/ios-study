//
//  MapViewController.swift
//  practice-ch06
//
//  Created by 강민서 on 4/18/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 태핑이 일어나면 segueViewController를 호출하는 TapGesture 생성
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(segueViewController))
        
        // 지도를 태핑하는 경우에만 동작하게 하기위해 mapView(not view)에 부착
        mapView.addGestureRecognizer(tapGesture)
        
    }
    
    // tab이 바뀌어 MapViewController 가 선택될 때 마다 호출됨 -> viewDidLoad() X, viewWillAppear() O
    override func viewDidAppear(_ animated: Bool) {
        
        // mapViewController의 부모는 UITabBarController
        let parent = self.parent?.parent as! UITabBarController
        
        var selectCityName: String?
        for vc in parent.viewControllers! {
            selectCityName = (vc as? CityViewController)?.getSelectedCity()
            if selectCityName != nil {
                break
            }
        }
        
        print("selected city = \(selectCityName)")
        
        getCLLocationCoordinate2D(cityName: selectCityName!)
    }
    
    
    // tab이 바뀌어 다른 ViewController가 선택될 때 마다 호출
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // 태핑이 일어나면 "jmeel"라는 segue로 전이
    @objc func segueViewController(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "jmlee", sender: self)
    }
    

}

// 도시 이름으로 (위도, 경도) 구하기
// CLGeocoder(), geocodeAddressString 사용하기
extension MapViewController {
    
    func getCLLocationCoordinate2D(cityName: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(cityName) {
            placemarks, error in
            guard error == nil else { return print(error!.localizedDescription)}
            guard let location = placemarks?.first?.location else { return print("no data")}
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("\(cityName): \(latitude), \(longitude))")
            
            self.move2Location(location: location.coordinate)
            self.attachAnnotation(location: location.coordinate)
            self.location = location.coordinate
        }
    }
}

// 지도 주석 달기
// 도시를 표기하기 위해 MKAnnotation 부착
extension MapViewController {
    
    func move2Location(location: CLLocationCoordinate2D) {
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
}

extension MapViewController {
    
    func attachAnnotation(location: CLLocationCoordinate2D) {
        
        // 다른 도시에 표시된 주석 삭제
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location // 센터에 annotation 설치
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}
