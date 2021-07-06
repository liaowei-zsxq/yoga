/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit
import YogaKit_Swift

final class BasicViewController: UIViewController {
    override func viewDidLoad() {

        let root = self.view!
        root.backgroundColor = .white
        root.yoga
            .alignItems(.center)
            .justifyContent(.center)

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
