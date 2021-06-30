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

    lazy var containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addAction(_:)))

        view.backgroundColor = .gray

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        scrollView.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])

        containerView.backgroundColor = .white
        containerView.yoga
                    .alignItems(.center)
                    .justifyContent(.center)
                    .padding(16)

        let child1 = UIView()
        child1.backgroundColor = .blue
        child1.yoga
            .width(100)
            .height(10)
            .marginBottom(25)
        containerView.addSubview(child1)

        let child2 = UIView()
        child2.backgroundColor = .green
        child2.yoga
            .alignSelf(.flexEnd)
            .width(200)
            .height(200)
        containerView.addSubview(child2)

        let child3 = UIView()
        child3.backgroundColor = .yellow
        child3.yoga
            .alignSelf(.flexStart)
            .width(100)
            .height(100)
            .marginBottom(24)
        containerView.addSubview(child3)

        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textColor = .gray
        textLabel.text = """
                        Yoga: A cross-platform layout engine

                        Layout is an important part of building user interfaces for any mobile, desktop, or web application, because it describes the size and position of views on the screen and their relationship to one another.

                        Today, layout is handled differently on each platform, through systems like Auto Layout on iOS, composable containers on Android, and various CSS-based approaches on the web. Having such a diverse set of layout systems makes it hard for teams building products to share solutions across platforms and increases the amount of time developers spend fixing platform-specific layout bugs.

                        At Facebook, we want engineers to be able to build products across multiple platforms without needing to learn a new layout system for each. With React Native, we introduced a solution to this problem in the form of css-layout, a cross-platform implementation of the Flexbox spec. Since then, several teams have come together to help fix bugs, improve performance, and make css-layout more spec-compliant.

                        Today we are excited to officially relaunch css-layout as Yoga, a stand-alone layout engine that extends beyond React Native and allows product engineers to build layouts quickly for multiple platforms.

                        We chose to implement Yoga in C to better optimize its performance, and we saw a 33 percent improvement to layout times on Android compared with the previous Java implementation. C also gives us the ability to easily integrate Yoga into more platforms and frameworks. To date, Yoga has bindings for Java (Android), Objective-C (UIKit), and C# (.NET), and is being used in projects such as React Native, Components for Android, and Oculus. We are also in the process of migrating some views in Instagram to Yoga via the UIKit bindings, and we’re integrating Yoga into ComponentKit as well.
                        """
        containerView.addSubview(textLabel);
        textLabel.yoga.includInLayout()
    }

    @objc func addAction(_ sender: Any) {
        let subView = UIView()
        subView.backgroundColor = .gray
        containerView.insertSubview(subView, at: 0)
        subView.yoga
            .width(120)
            .height(56)
            .marginBottom(16)

        UIView.animate(withDuration: 0.25) {
            subView.yoga.markDirty()
        }
    }
}
