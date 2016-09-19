//
//  AppDelegate.swift
//  Lotos
//
//  Created by Andrey Torlopov on 09/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var coreDataStack = CoreDataStack()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupAppearence()
        return true
    }
    
    func setupAppearence() {
        Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatOrangeColorDark(), withSecondaryColor: UIColor.flatOrangeColor(), andContentStyle: .Contrast)
    }
}

