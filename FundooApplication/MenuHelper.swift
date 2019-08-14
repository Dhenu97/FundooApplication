//
//  MenuHelper.swift
//  FundooApplication
//
//  Created by BridgeLabz on 27/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit
import SJSwiftSideMenuController

public class MenuHelper{
    
    public static func getSideMenu() -> SJSwiftSideMenuController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = SJSwiftSideMenuController()
        if let sideVC_L = (storyBoard.instantiateViewController(withIdentifier: "sideMenuVC") as? SideMenuController) {
            if let rootVC = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as? DashboardController {
                SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: nil, leftMenuType: .SlideOver, rightMenuType: .SlideView)
            }
        }
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 280
        return mainVC
}
}
