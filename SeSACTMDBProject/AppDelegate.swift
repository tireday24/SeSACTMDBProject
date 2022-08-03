//
//  AppDelegate.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let genreSingleton = Genre.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        genreAPI()
        // Override point for customization after application launch.
        return true
    }
    
    func genreAPI() {

    let url = "\(EndPoint.genreURL)api_key=\(APIKey.TMDB)"
    
    
    //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
    AF.request(url, method: .get).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
            
            for mv in json["genres"] {
                let poster = mv.1["id"].intValue
                let overview = mv.1["name"].stringValue
                
                self.genreSingleton.genre[poster] = overview
            }
            print("done")
        case .failure(let error):
            print(error)
        }
    }
}

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

