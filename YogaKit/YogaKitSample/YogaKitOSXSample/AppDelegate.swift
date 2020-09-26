//
//  AppDelegate.swift
//  YogaKitOSXSample
//
//  Created by v on 2020/9/26.
//  Copyright © 2020 facebook. All rights reserved.
//

import Cocoa
import SwiftYogaKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationWillFinishLaunching(_ aNotification: Notification) {
        NSView.SwiftYogaKitSwizzle()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

