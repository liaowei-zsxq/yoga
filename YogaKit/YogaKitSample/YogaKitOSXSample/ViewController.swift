//
//  ViewController.swift
//  YogaKitOSXSample
//
//  Created by v on 2020/9/26.
//  Copyright © 2020 facebook. All rights reserved.
//

import Cocoa
import YogaKit_Swift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let root = NSView()
        view.addSubview(root)
        root.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            root.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            root.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        root.wantsLayer = true
        root.layer?.backgroundColor = .white
        root.yoga.configureLayout { (layout) in
            layout.alignItems = .center
            layout.justifyContent = .center
            layout.padding(16)
        }

        let child1 = NSView()
        child1.wantsLayer = true
        child1.layer?.backgroundColor = NSColor.blue.cgColor
        child1.yoga.configureLayout { (layout) in
            layout.width = 100
            layout.height = 10
            layout.marginBottom = 25
        }
        root.addSubview(child1)

        let child2 = NSView()
        child2.wantsLayer = true
        child2.layer?.backgroundColor = NSColor.green.cgColor
        child2.yoga.configureLayout { (layout) in
            layout.alignSelf = .flexEnd
            layout.width = 200
            layout.height = 200
        }
        root.addSubview(child2)

        let child3 = NSView()
        child3.wantsLayer = true
        child3.layer?.backgroundColor = NSColor.yellow.cgColor
        child3.yoga.configureLayout { (layout) in
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

