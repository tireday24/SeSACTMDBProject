//
//  CastViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/04.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import JGProgressHUD

class CastViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var castList: [CastInfo] = []
    static let identifier = "CastViewController"
    let castViewSection: [String] = ["Overview", "Cast"]
    
    var castId = 0
    
    var castOverview = ""
    
    var castTitle = ""
    var bgUrl = ""
    var posterUrl = ""

    var a: TmdbInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(castOverview, "===================")
        naviDesign()
        requestCastApi()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: OverviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OverviewTableViewCell.identifier)
        tableView.register(UINib(nibName: CastMemberTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CastMemberTableViewCell.identifier)
        
        movieNameLabel.text = castTitle
        let backgroundUrl = URL(string: "\(EndPoint.imgURL)\(bgUrl)")
        backgroundImage.kf.setImage(with: backgroundUrl)
        let psUrl = URL(string: "\(EndPoint.imgURL)\(posterUrl)")
        moviePoster.kf.setImage(with: psUrl)
       
        
    }
    
    func naviDesign() {
        let item = navigationItem
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        item.leftBarButtonItem?.tintColor = .blue
        item.title = "출연/제작"
        
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    func requestCastApi() {
        let url = "\(EndPoint.TMDBACTORURLCASTID(id: castId))api_key=\(APIKey.TMDB)"
        
        
        //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for mv in json["crew"] {
                    let movieOverview = mv.1["overview"].stringValue
                    let actorImage = mv.1["profile_path"].stringValue
                    let orignalName = mv.1["original_name"].stringValue
                    let movieName = mv.1["character"].stringValue
                    
                    let info = CastInfo(overview: movieOverview, actorImage: actorImage, realName: orignalName, mvName: movieName)
                    
                    self.castList.append(info)
                }
                
                print(self.castList.count, "fffffffffffff")
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
   
}

extension CastViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return castList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return castViewSection[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as! OverviewTableViewCell
            cell.overviewLabel.text = castOverview
            
        } else if indexPath.section == 1 {
           let cell = tableView.dequeueReusableCell(withIdentifier: CastMemberTableViewCell.identifier) as! CastMemberTableViewCell
            
            print(castList.count, "================")
            
            let url = URL(string: "\(EndPoint.imgURL)\(castList[indexPath.row].actorImage)")
            cell.actorImageView.kf.setImage(with: url)
            cell.realNameLabel.text = castList[indexPath.row].realName
            cell.movieNameLabel.text = castList[indexPath.row].mvName
        }
       
        
        return UITableViewCell()
    }
    
    
}
