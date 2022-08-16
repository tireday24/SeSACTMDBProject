//
//  SecondViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/16.
//

import UIKit
import TmdbFrameWork

class SecondViewController: UIViewController {

    @IBOutlet weak var theaterLable: UILabel!
    @IBOutlet weak var theaterImage: UIImageView!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        setUI()
        
    }
    
    func setUI() {
        theaterLable.textAlignment = .center
        theaterLable.tintColor = .white
        theaterLable.font = .boldSystemFont(ofSize: 20)
        theaterLable.text = "영화관 찾기 기능"
        theaterImage.backgroundColor = .clear
        theaterImage.image = UIImage(systemName: "map")
        theaterImage.tintColor = .white
        stopButton.tintColor = .white
        stopButton.setTitle("오늘 하루 보지 않기", for: .normal)
        stopButton.layer.borderWidth = 2
        stopButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func stopButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Tmdb", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TmdbViewController.reuseIdentifier) as? TmdbViewController else {return }
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true)
    }
    
}
