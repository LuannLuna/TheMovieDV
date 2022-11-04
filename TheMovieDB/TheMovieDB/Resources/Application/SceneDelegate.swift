//
//  SceneDelegate.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

import SwiftUI
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private lazy var mainCoordinator: MainCoordinator = {
        guard let window = window else { fatalError("Enable to load window") }
        window.overrideUserInterfaceStyle = .dark
        return MainCoordinator(window: window)
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        mainCoordinator.showRootView()
        window?.makeKeyAndVisible()
    }
}
