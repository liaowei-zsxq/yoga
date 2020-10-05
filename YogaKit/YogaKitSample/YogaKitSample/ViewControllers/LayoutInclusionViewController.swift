/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit
import SwiftYogaKit
import YGLayoutExtensions

final class LayoutInclusionViewController: UIViewController {
    private let button: UIButton = UIButton(type: .system)
    private let disappearingView: UIView = UIView(frame: .zero)
    private let contentView: UIView = UIView(frame: .zero)

    override func viewDidLoad() {
        let root = self.view!
        root.backgroundColor = .white
        root.yoga
            .flexDirection(.column)
            .justifyContent(.spaceAround)

        contentView.backgroundColor = .clear
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.yoga
            .height(300)
            .width(100%)
            .flexDirection(.row)
            .justifyContent(.center)
            .paddingHorizontal(25)
        self.view.addSubview(contentView)

        let redView = UIView(frame: .zero)
        redView.backgroundColor = .red
        redView.yoga
            .flexGrow(1)
            .flexShrink(1)
        contentView.addSubview(redView)

        disappearingView.backgroundColor = .blue
        disappearingView.yoga
            .flexGrow(1)
        contentView.addSubview(disappearingView)

        button.setTitle("Add Blue View", for: .selected)
        button.setTitle("Remove Blue View", for: .normal)
        button.addTarget(self, action: #selector(buttonWasTapped), for: UIControl.Event.touchUpInside)
        button.yoga
            .height(300)
            .width(300)
            .alignSelf(.center)
        root.addSubview(button)
    }

    // MARK: - UIButton Action
    @objc func buttonWasTapped() {
        button.isSelected = !button.isSelected

        button.isUserInteractionEnabled = false
        disappearingView.yoga.includInLayout(!disappearingView.yoga.isIncludedInLayout)
        disappearingView.isHidden = !disappearingView.isHidden

        contentView.yoga.applyLayout(preservingOrigin: true)
        button.isUserInteractionEnabled = true
    }
}
