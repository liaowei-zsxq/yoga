//
//  ListFlowLayout.swift
//  YogaKitSample
//
//  Created by v on 2022/12/16.
//  Copyright © 2022 facebook. All rights reserved.
//

import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {
    private var oldWidth: CGFloat = 0

    override init() {
        super.init()
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = .zero
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let width = newBounds.width
        guard oldWidth != width else {
            return false
        }

        oldWidth = width

        return true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let ctx = super.invalidationContext(forBoundsChange: newBounds)
        guard let context = ctx as? UICollectionViewFlowLayoutInvalidationContext else {
            return ctx
        }

        context.invalidateFlowLayoutDelegateMetrics = true

        return context
    }
}
