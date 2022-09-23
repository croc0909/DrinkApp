//
//  LoadingClass.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/23.
//

import Foundation
import UIKit

class LoadingClass{
    func playLoadingAnimation() -> UIViewController{
       let loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .coverVertical // 動畫模式
        //present(loadingVC, animated: true,completion: nil)
        return loadingVC
    }
}
