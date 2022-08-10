//
//  MovieListToJason.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBEasyAPIManager {
    static let shared = TMDBEasyAPIManager()
    
    var idList: [Int] = []
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    let recommendationURL = "https://api.themoviedb.org/3/movie/725201/recommendations?api_key=\(APIKey.TMDB)&language=en-US&page=1"
    
    func callRequest(query: Int, completionHandler: @escaping ([String]) -> ()) {
        print(#function)
        let url = "https://api.themoviedb.org/3/movie/\(query)/recommendations?api_key=\(APIKey.TMDB)&language=en-US&page=1"
        
        //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
        //Alamofire -> URLSession Framework -> 비동기로 request
        //almofire가 자동으로 메인스레드로 바꿔줌
        //뜨기전에 네트워크 요청 -> Response -> request시점에 Urlsession에 비동기가 처리되도록 백그라운드에서 비동기 처리 -> 메인 Ui처리
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
        
                let value = json["results"].arrayValue.map { $0["poster_path"].stringValue }
                let id = json["results"].arrayValue.map { $0["id"].intValue}
                self.idList = id
    
                print(id, "ffffffffff")
                
                completionHandler(value)
                
            case .failure(let error):
                print(error)
                
                
            }
        }
        
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var imageList: [[String]] = []
        
        //나중에 배울 것: async/awit(iOS13 이상)
        TMDBAPIManager.shared.callRequest(query: idList[0]) { value in
            imageList.append(value)
            
            TMDBAPIManager.shared.callRequest(query: self.idList[1]) { value in
                imageList.append(value)
                
                TMDBAPIManager.shared.callRequest(query: self.idList[2]) { value in
                    imageList.append(value)
                    
                    TMDBAPIManager.shared.callRequest(query: self.idList[3]) { value in
                        imageList.append(value)
                        
                        TMDBAPIManager.shared.callRequest(query: self.idList[4]) { value in
                            imageList.append(value)
                            
                            TMDBAPIManager.shared.callRequest(query: self.idList[5]) { value in
                                imageList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.idList[6]) { value in
                                    imageList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.idList[7]) { value in
                                        imageList.append(value)
                                        
                                        TMDBAPIManager.shared.callRequest(query: self.idList[8]) {value in
                                            imageList.append(value)
                                            
                                            TMDBAPIManager.shared.callRequest(query: self.idList[9]) {value in
                                                imageList.append(value)
                                                completionHandler(imageList)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
