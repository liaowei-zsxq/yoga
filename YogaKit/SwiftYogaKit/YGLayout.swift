//
//  YGLayout.swift
//  SwiftYogaKit
//
//  Created by v on 2020/9/26.
//  Copyright © 2020 facebook. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

import Yoga

public typealias YGLayoutConfigurationBlock = ((YGLayout) -> Void)

public struct YGDimensionFlexibility: OptionSet {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    static let width = YGDimensionFlexibility(rawValue: 1 << 0)

    static let height = YGDimensionFlexibility(rawValue: 1 << 1)
}

final public class YGLayout {

    public var isEnabled = false

    public var isIncludedInLayout = true

    public var isDirty: Bool {
        get {
            return node.isDirty
        }
    }

    public var isLeaf: Bool {
        get {
            assert(Thread.isMainThread, "This method must be called on the main thread.")

            guard isEnabled else {
                return true
            }

            for subview in view.subviews {
                let yoga = subview.yoga
                if yoga.isEnabled, yoga.isIncludedInLayout {
                    return false
                }
            }

            return true
        }
    }

    public var numberOfChildren: UInt {
        get {
            return node.childCount
        }
    }

    public var resolvedDirection: YGDirection {
        get {
            return node.direction
        }
    }

    public var intrinsicSize: CGSize {
        get {
            return calculateLayout(size: CGSize(width: CGFloat.nan, height: CGFloat.nan))
        }
    }

    var isBaseView = true
    var isApplingLayout = false

    private(set) var node: YGNodeRef
    private var view: UIView

    deinit {
        YGNodeFree(node)
    }

    init(view: UIView) {
        self.view = view
        isBaseView = view.isMember(of: UIView.self) || view.isMember(of: UIControl.self)
        node = YGNodeNewWithConfig(YGGlobalConfig())
        node.context = UnsafeRawPointer(Unmanaged<UIView>.passUnretained(self.view).toOpaque())
    }

    public func markDirty() {
        guard isEnabled, !isDirty, isLeaf else {
            return
        }

        if !node.hasMeasureFunc {
            node.setMeasureFunc(YGMeasureView)
        }

        node.markDirty()
    }

    public func applyLayout() {
        applyLayout(preservingOrigin: false)
    }

    public func applyLayout(preservingOrigin preserveOrigin: Bool) {
        applyLayout(preservingOrigin: preserveOrigin, dimensionFlexibility: [])
    }

    public func applyLayout(preservingOrigin preserveOrigin: Bool, dimensionFlexibility: YGDimensionFlexibility) {
        guard !isApplingLayout, isEnabled else {
            return
        }

        var size = view.bounds.size

        if dimensionFlexibility.contains(.width) {
            size.width = CGFloat.nan
        }

        if dimensionFlexibility.contains(.height) {
            size.height = CGFloat.nan
        }

        _ = calculateLayout(size: size)
        YGApplyLayoutToViewHierarchy(view, preserveOrigin)
    }

    public func calculateLayout(size: CGSize) -> CGSize {
        assert(Thread.isMainThread, "Yoga calculation must be done on main.")
        assert(isEnabled, "Yoga is not enabled for this view.")

        YGAttachNodesFromViewHierachy(view)
        YGNodeCalculateLayout(node, YGFloat(size.width), YGFloat(size.height), YGNodeStyleGetDirection(node))

        return CGSize(width: CGFloat(node.width), height: CGFloat(node.height))
    }

    public func configureLayout(block: YGLayoutConfigurationBlock) {
        block(self)
    }
}
