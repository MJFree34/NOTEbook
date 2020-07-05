//
//  SceneDelegate.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let nav = UINavigationController(rootViewController: NotePickerViewController())
        nav.navigationBar.tintColor = UIColor(named: "DarkAqua")!
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.barTintColor = UIColor(named: "White")
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.barStyle = .default
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

