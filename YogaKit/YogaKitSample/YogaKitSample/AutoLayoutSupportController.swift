//
//  AutoLayoutSupportController.swift
//  YogaKitSample
//
//  Created by lvv on 2021/6/29.
//  Copyright © 2021 facebook. All rights reserved.
//

import UIKit
import YGLayoutExtensions

extension UILayoutPriority {
    static let defaultMedium = UILayoutPriority(rawValue: 501)
}

class AutoLayoutSupportController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray

        let root = UIView()
        view.addSubview(root)
        root.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            root.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            root.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        root.backgroundColor = .white
        root.yoga
            .alignItems(.center)
            .justifyContent(.center)
            .padding(16)

        let child1 = UIView()
        child1.backgroundColor = .blue
        child1.yoga
            .width(100)
            .height(10)
            .marginBottom(25)
        root.addSubview(child1)

        let child2 = UIView()
        child2.backgroundColor = .green
        child2.yoga
            .alignSelf(.flexEnd)
            .width(200)
            .height(200)
        root.addSubview(child2)

        let child3 = UIView()
        child3.backgroundColor = .yellow
        child3.yoga
            .alignSelf(.flexStart)
            .width(100)
            .height(100)
        root.addSubview(child3)
    }
}
