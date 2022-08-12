//
//  APIManager.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON

class SearchMovieAPI{
    
    private init() {}
    
    static let shared = SearchMovieAPI()
    
    func movieListAPI(completionHandler: @escaping ([String]) -> ()) {
        
        let url = "\(EndPoint.TMDBURL)api_key=\(APIKey.TMDB)&page=1"
        AF.request(url, method: .get).validate().responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let movieList = json["results"].arrayValue.map { $0["original_title"].stringValue }
                
                completionHandler(movieList)

            case .failure(let error):
                print(error)
            }
        }
    }
}
