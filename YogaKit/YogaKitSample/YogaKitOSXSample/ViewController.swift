//
//  ViewController.swift
//  YogaKitOSXSample
//
//  Created by v on 2020/9/26.
//  Copyright © 2020 facebook. All rights reserved.
//

import Cocoa
import SwiftYogaKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let root = self.view
        root.wantsLayer = true
        root.layer?.backgroundColor = .white
        root.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.alignItems = .center
            layout.justifyContent = .center
        }

        let child1 = NSView()
        child1.wantsLayer = true
        child1.layer?.backgroundColor = NSColor.blue.cgColor
        child1.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 100
            layout.height = 10
            layout.marginBottom = 25
        }
        root.addSubview(child1)

        let child2 = NSView()
        child2.wantsLayer = true
        child2.layer?.backgroundColor = NSColor.green.cgColor
        child2.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.alignSelf = .flexEnd
            layout.width = 200
            layout.height = 200
        }
        root.addSubview(child2)

        let child3 = NSView()
        child3.wantsLayer = true
        child3.layer?.backgroundColor = NSColor.yellow.cgColor
        child3.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.alignSelf = .flexStart
            layout.width = 100
            layout.height = 100
        }
        root.addSubview(child3)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

