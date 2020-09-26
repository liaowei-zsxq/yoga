//
//  TWTimelineViewController.swift
//  YogaKitSample
//
//  Created by lvv on 2020/8/15.
//  Copyright © 2020 facebook. All rights reserved.
//

import UIKit
import SwiftYogaKit

class TWTimelineViewController: UIViewController {

    private var tableView: UITableView!
    private var timelineCell: TWTimelineCell!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        view.yoga.configureLayout { (layout) in
            layout.isEnabled = true
        }

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 100%
            layout.height = 100%
        }

        registerCell(TWTimelineCell.self)

        timelineCell = TWTimelineCell(style: .default, reuseIdentifier: NSStringFromClass(TWTimelineCell.self))
    }

    func registerCell(_ cellClass: AnyClass?) {
        guard let cellClass = cellClass else {
            return
        }

        tableView.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }

    func dequeueReusableCell(_ cellClass: AnyClass?, for indexPath: IndexPath) -> UITableViewCell? {
        guard let cellClass = cellClass else {
            return nil
        }

        return tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(cellClass), for: indexPath)
    }
}

extension TWTimelineViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(TWTimelineCell.self, for: indexPath) as! TWTimelineCell

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let size = timelineCell.contentView.yoga.calculateLayout(size: CGSize(width: tableView.bounds.width, height: CGFloat.nan))

        return size.height
    }
}

class TWTimelineCell: UITableViewCell {
    var headimgView: UIImageView!
    var nameView: UILabel!
    var dateView: UILabel!
    var postView: UILabel!
    var tagsView: UILabel!
    var bottomView: UIView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundView = UIView()
        backgroundView?.backgroundColor = .white

        contentView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .column
            layout.paddingLeft = 74
            layout.paddingRight = 15
            layout.position = .relative
        }

        headimgView = UIImageView(image: UIImage(named: "Yoga"))
        headimgView.clipsToBounds = true
        headimgView.contentMode = .scaleAspectFill
        headimgView.layer.cornerRadius = 49 * 0.5
        contentView.addSubview(headimgView)
        headimgView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.position = .absolute
            layout.top = 10
            layout.left = 15
            layout.width = 49
            layout.height = 49
        }

        nameView = UILabel()
        nameView.font = .systemFont(ofSize: 15)
        nameView.textColor = .orange
        nameView.text = "Emil Sjölander"
        contentView.addSubview(nameView)
        nameView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 10
            layout.height = 20
        }

        dateView = UILabel()
        dateView.font = .systemFont(ofSize: 12)
        dateView.textColor = .lightGray
        dateView.text = "POSTED ON DEC 7, 2016"
        contentView.addSubview(dateView)
        dateView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 2
        }

        postView = UILabel()
        postView.numberOfLines = 0
        postView.textColor = .gray
        postView.text = """
                        Yoga: A cross-platform layout engine

                        Layout is an important part of building user interfaces for any mobile, desktop, or web application, because it describes the size and position of views on the screen and their relationship to one another.

                        Today, layout is handled differently on each platform, through systems like Auto Layout on iOS, composable containers on Android, and various CSS-based approaches on the web. Having such a diverse set of layout systems makes it hard for teams building products to share solutions across platforms and increases the amount of time developers spend fixing platform-specific layout bugs.

                        At Facebook, we want engineers to be able to build products across multiple platforms without needing to learn a new layout system for each. With React Native, we introduced a solution to this problem in the form of css-layout, a cross-platform implementation of the Flexbox spec. Since then, several teams have come together to help fix bugs, improve performance, and make css-layout more spec-compliant.

                        Today we are excited to officially relaunch css-layout as Yoga, a stand-alone layout engine that extends beyond React Native and allows product engineers to build layouts quickly for multiple platforms.

                        We chose to implement Yoga in C to better optimize its performance, and we saw a 33 percent improvement to layout times on Android compared with the previous Java implementation. C also gives us the ability to easily integrate Yoga into more platforms and frameworks. To date, Yoga has bindings for Java (Android), Objective-C (UIKit), and C# (.NET), and is being used in projects such as React Native, Components for Android, and Oculus. We are also in the process of migrating some views in Instagram to Yoga via the UIKit bindings, and we’re integrating Yoga into ComponentKit as well.
                        """
        contentView.addSubview(postView)
        postView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 5
        }

        tagsView = UILabel()
        tagsView.numberOfLines = 0
        tagsView.textColor = .blue
        tagsView.text = "#yoga #iOS #twiiter #flexbox #YogaKit #facebook #Github"
        contentView.addSubview(tagsView)
        tagsView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginTop = 5
        }

        bottomView = UIView()
        contentView.addSubview(bottomView)
        bottomView.yoga.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.justifyContent = .spaceBetween
            layout.marginTop = 10
            layout.marginBottom = 10
        }

        let names = ["comment", "retweet", "like"]
        for i in 0 ..< 3 {
            let v = UIImageView(image: UIImage(named: names[i]))
            bottomView.addSubview(v)
            v.yoga.configureLayout { (layout) in
                layout.isEnabled = true
                layout.width = 19
                layout.height = 19
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
