//
//  CustomSplitViewController.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 02/11/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//
import UIKit

class CustomSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}
