//
//  ViewController.swift
//  practice-ch07
//
//  Created by 강민서 on 4/20/24.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {

    let weatherSite = "https://api.openweathermap.org/data/2.5/weather"
    let weatherKey = ""
    
    let openAiSite = "https://api.openai.com/v1/chat/completions"
    let openAiKey = ""
    
    var location: CLLocationCoordinate2D? =
    CLLocationCoordinate2D(latitude: 37.5642135, longitude: 127.0016985)
    
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var specialInfoLabel: UILabel!
    @IBOutlet weak var weatherInfoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherInfo(location: location!)

    }
}

extension ViewController {
    func getWeatherInfo(location: CLLocationCoordinate2D) {
        var urlStr = weatherSite
        urlStr += "?" + "lat=" + String(location.latitude) + "&" + "lon=" + String(location.longitude)
        urlStr += "&" + "appid=" + weatherKey
        
        let request = URLRequest(url: URL(string: urlStr)!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else { print(error!); return}
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
                print(jsonStr)
            }
            
            // UI 업데이트
            let (infoStr, iconData) = self.makeUpWeatherInformation(jsonData: jsonData)
            
            DispatchQueue.main.async {
                self.weatherInfoLabel.text = infoStr
                self.weatherInfoImageView.image = UIImage(data: iconData)
            }
        }
        
        dataTask.resume()
    }
}

extension ViewController {
    func makeUpWeatherInformation(jsonData: Data) -> (String, Data) {
        
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        
        let weather = jsonObject["weather"] as! [Any]
        let weather0 = weather[0] as! [String:Any]
        let icon = weather0["icon"] as! String
        
        let main = jsonObject["main"] as! [String: Any]
        let feels_like = main["feels_like"] as! Double - 273.0
        let temp = main["temp"] as! Double - 273.0
        let temp_min = main["temp_min"] as! Double - 273.0
        let temp_max = main["temp_max"] as! Double - 273.0
        let pressure = main["pressure"] as! Double
        let humidity = main["humidity"] as! Double
        
        let wind = jsonObject["wind"] as! [String: Any]
        let speed = wind["speed"] as! Double
        
        var infoStr = "온도: \(temp)\n"
        infoStr += "최저온도: \(temp_min)\n" + "최고온도: \(temp_max)\n" + "체감온도: \(feels_like)\n"
        infoStr += "기압: \(pressure)파스칼\n" + "습도: \(humidity)%\n" + "풍속: \(speed)m/sec\n"
        
        let iconUrl = URL(string: "https://openweathermap.org/img/wn/"+icon+"@2x.png")
        let data = try! Data(contentsOf: iconUrl!)
        
        return (infoStr, data)
    }
}

// 네이버로 요청 보내고 응답 받기
//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let session = URLSession(configuration: .default)
//        let url = URL(string: "https://www.naver.com")
//        
//        let request = URLRequest(url: url!)
//        
//        let dataTask = session.dataTask(with: url!) {
//            (data, response, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            if let jsonData = data {
//                if let jsonString = String(data: jsonData, encoding: .utf8) {
//                    print(jsonString)
//                }
//            }
//        }
//        
//        dataTask.resume()
//    }
//
//
//}
