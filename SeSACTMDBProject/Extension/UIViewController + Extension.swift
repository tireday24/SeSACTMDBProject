//
//  UIViewController + Extension.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/18.
//

import UIKit
import TmdbFrameWork

extension UIViewController {
    enum Transition {
        case push
        case present
    }
    
    func transitionViewController<T: UIViewController>(storyboard: String, vc: T, transiton: Transition, complition: (T) -> ()) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        
        switch transiton {
        case .push:
            guard let vc = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
            complition(vc)
            navigationController?.pushViewController(vc, animated: true)
        case .present:
            guard let vc = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
            let nv = UINavigationController(rootViewController: vc)
            nv.modalPresentationStyle = .fullScreen
            present(nv, animated: true)
        }
        
    }
}
