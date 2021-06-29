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

    lazy var scrollView = UIScrollView(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        let root = UIView()
        scrollView.addSubview(root)
        root.translatesAutoresizingMaskIntoConstraints = false

        let leftConstraint = root.leftAnchor.constraint(greaterThanOrEqualTo: scrollView.leftAnchor, constant: 16)
        leftConstraint.priority = .defaultHigh

        let rightConstraint = root.rightAnchor.constraint(lessThanOrEqualTo: scrollView.rightAnchor, constant: -16)
        rightConstraint.priority = .defaultHigh

        let widthConstraint = root.widthAnchor.constraint(equalToConstant: 414)
        widthConstraint.priority = .defaultMedium

        NSLayoutConstraint.activate([
            root.topAnchor.constraint(equalTo: scrollView.topAnchor),
            root.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            root.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            root.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            leftConstraint, rightConstraint, widthConstraint
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
