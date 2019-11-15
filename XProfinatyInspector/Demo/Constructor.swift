//
//  Constructor.swift
//  XProfinatyInspector
//
//  Created by Vinicius Mangueira on 15/11/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import UIKit

struct Constructor {
 
    static func getWindow(windowScene: UIWindowScene) -> UIWindow {
        let navigation = UINavigationController(rootViewController: ViewController())
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.barTintColor = .black
            navigation.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigation.view.backgroundColor =  .white
        navigation.navigationBar.tintColor = .white
        
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        return window
    }
}
