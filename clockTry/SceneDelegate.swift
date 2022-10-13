//
//  SceneDelegate.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/6/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowSence = (scene as? UIWindowScene) else { return }
        
        let rootVC1 = AlarmViewController(nibName: String(describing: AlarmViewController.self), bundle: nil)
        let navigationVC1 = UINavigationController(rootViewController: rootVC1)
        
        let rootVC2 = StopWatchViewController(nibName: String(describing: StopWatchViewController.self), bundle: nil)
        let navigationVC2 = UINavigationController(rootViewController: rootVC2)
        
        let rootVC3 = WorldClockViewController(nibName: String(describing: WorldClockViewController.self), bundle: nil)
        let navigationVC3 = UINavigationController(rootViewController: rootVC3)
        
        let rootVC4 = TimerViewController(nibName: String(describing: TimerViewController.self), bundle: nil)
        let navigationVC4 = UINavigationController(rootViewController: rootVC4)
        
        let MyTabBar = UITabBarController()
        
        let AlarmVC = navigationVC1
        AlarmVC.tabBarItem.image = UIImage(systemName: "clock")
        AlarmVC.tabBarItem.title = "鬧鐘"
        
        let StopWatchVC = navigationVC2
        StopWatchVC.tabBarItem.image = UIImage(systemName: "stopwatch")
        StopWatchVC.tabBarItem.title = "碼表"
        
        let WorldClockVC = navigationVC3
        WorldClockVC.tabBarItem.image = UIImage(systemName: "globe")
        WorldClockVC.tabBarItem.title = "世界時鐘"
        
        let TimerVC = navigationVC4
        TimerVC.tabBarItem.image = UIImage(systemName: "timer")
        TimerVC.tabBarItem.title = "計時器"
        
        MyTabBar.viewControllers = [AlarmVC, StopWatchVC, WorldClockVC, TimerVC]
        MyTabBar.selectedIndex = 0
        
        window = UIWindow(frame: windowSence.coordinateSpace.bounds)
        window?.windowScene = windowSence
        window?.rootViewController = MyTabBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

