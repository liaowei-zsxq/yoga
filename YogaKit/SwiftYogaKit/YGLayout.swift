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

public class YGLayout {

    public var isEnabled = false

    public var isIncludedInLayout = true

    public var isDirty: Bool {
        get {
            return YGNodeIsDirty(node)
        }
    }

    public var isLeaf: Bool {
        get {
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
            return UInt(YGNodeGetChildCount(node))
        }
    }

    public var resolvedDirection: YGDirection {
        get {
            return YGNodeLayoutGetDirection(node)
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
        YGNodeSetContext(node, Unmanaged.passUnretained(self.view).toOpaque())
    }

    public func markDirty() {
        guard !isDirty, isLeaf else {
            return
        }

        if !YGNodeHasMeasureFunc(node) {
            YGNodeSetMeasureFunc(node, YGMeasureView)
        }

        YGNodeMarkDirty(node)
    }

    public func applyLayout() {
        applyLayout(preservingOrigin: false)
    }

    public func applyLayout(preservingOrigin preserveOrigin: Bool) {
        applyLayout(preservingOrigin: preserveOrigin, dimensionFlexibility: [])
    }

    public func applyLayout(preservingOrigin preserveOrigin: Bool, dimensionFlexibility: YGDimensionFlexibility) {
        guard !isApplingLayout else {
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
        guard isEnabled else {
            return .zero
        }

        YGAttachNodesFromViewHierachy(view)
        YGNodeCalculateLayout(node, YGFloat(size.width), YGFloat(size.height), YGNodeStyleGetDirection(node))
        let w = CGFloat(max(YGNodeLayoutGetWidth(node), 0))
        let h = CGFloat(max(YGNodeLayoutGetHeight(node), 0))

        return CGSize(width: w, height: h)
    }

    public func configureLayout(block: YGLayoutConfigurationBlock) {
        block(self)
    }
}
