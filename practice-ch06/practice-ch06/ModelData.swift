/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation

// var landmarks: [Landmark] = load("landmarkData.json")

class MultipleController { // 클래스로 감싸줌
    
    static func load<T: Decodable>(_ filename: String) -> T { // static 함수로 변경
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
