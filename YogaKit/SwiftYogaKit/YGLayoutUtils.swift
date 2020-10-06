//
//  Utils.swift
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

func YGScaleFactor() -> CGFloat {
    struct once {
        #if os(macOS)
        static let scaleFactor = NSScreen.main?.backingScaleFactor ?? 1
        #else
        static let scaleFactor = UIScreen.main.scale
        #endif
    }

    return once.scaleFactor
}

func YGGlobalConfig() -> YGConfigRef {
    struct once {
        static let config: YGConfigRef = {
            let config = YGConfigNew()
            YGConfigSetExperimentalFeatureEnabled(config, .webFlexBasis, true)
            YGConfigSetPointScaleFactor(config, YGFloat(YGScaleFactor()))
            
            return config!
        }()
    }

    return once.config
}

@inline(__always) func YGSanitizeMeasurement(_ constrainedSize: CGFloat, _ measuredSize: CGFloat, _ measureMode: YGMeasureMode) -> CGFloat {
    var result: CGFloat

    switch measureMode {
    case .exactly:
        result = constrainedSize
    case .atMost:
        result = min(constrainedSize, measuredSize)
    default:
        result = measuredSize
    }

    return max(result, 0)
}

func YGMeasureView(_ node: YGNodeRef!, _ width: YGFloat, _ widthMode: YGMeasureMode, _ height: YGFloat, _ heightMode: YGMeasureMode) -> YGSize {
    let constrainedWidth: CGFloat = (widthMode == YGMeasureMode.undefined) ? .greatestFiniteMagnitude : CGFloat(width)
    let constrainedHeight: CGFloat = (heightMode == YGMeasureMode.undefined) ? .greatestFiniteMagnitude : CGFloat(height)

    let view = Unmanaged<UIView>.fromOpaque(node.context!).takeUnretainedValue()
    let yoga = view.yoga
    
    guard !yoga.isBaseView else {
        return YGSizeZero
    }

    #if os(macOS)
    let fittingSize = view.fittingSize
    let sizeThatFits = CGSize(width: min(fittingSize.width, constrainedWidth), height: min(fittingSize.height, constrainedHeight))
    #else
    let sizeThatFits = view.sizeThatFits(CGSize(width: constrainedWidth, height: constrainedHeight))
    #endif

    let w = YGFloat(YGSanitizeMeasurement(constrainedWidth, sizeThatFits.width, widthMode))
    let h = YGFloat(YGSanitizeMeasurement(constrainedHeight, sizeThatFits.height, heightMode))

    return YGSize(width: w, height: h)
}

@inline(__always) func YGNodeHasExactSameChildren(_ node: YGNodeRef, _ subviews: [UIView]) -> Bool {
    let count = subviews.count
    guard node.childCount == count else {
        return false
    }

    for i in 0 ..< count {
        let yoga = subviews[i].yoga
        guard node.getChild(i)?.hashValue == yoga.node.hashValue else {
            return false
        }
    }

    return true
}

func YGAttachNodesFromViewHierachy(_ view: UIView) {
    let yoga = view.yoga
    let node = yoga.node

    guard !yoga.isLeaf else {
        node.removeAllChildren()
        node.setMeasureFunc(YGMeasureView)

        return
    }

    node.setMeasureFunc(nil)

    let subviewsToInclude = view.subviews.filter {
        guard $0.isYogaEnabled else {
            return false
        }

        let yoga = $0.yoga
        
        return yoga.isIncludedInLayout
    }

    if !YGNodeHasExactSameChildren(node, subviewsToInclude) {
        node.removeAllChildren()

        for i in 0 ..< subviewsToInclude.count {
            node.insertChild(subviewsToInclude[i].yoga.node, at: i)
        }
    }

    subviewsToInclude.forEach { (subview) in
        YGAttachNodesFromViewHierachy(subview)
    }
}

func YGApplyLayoutToViewHierarchy(_ view: UIView, _ preserveOrigin: Bool) {
    assert(Thread.isMainThread, "Framesetting should only be done on the main thread.")

    let yoga = view.yoga
    guard !yoga.isApplingLayout, yoga.isIncludedInLayout else {
        return
    }

    yoga.isApplingLayout = true

    let node = yoga.node
    let topLeft = CGPoint(x: CGFloat(node.left), y: CGFloat(node.top))
    let size = CGSize(width: CGFloat(node.width), height: CGFloat(node.height))
    var origin = CGPoint.zero

    #if os(macOS)
    if preserveOrigin {
        origin = view.frame.origin
    }
    #else
    let transformIsIdentity = view.transform.isIdentity

    if preserveOrigin {
        origin = transformIsIdentity ? view.frame.origin : CGPoint(x: view.center.x - view.bounds.width * 0.5,
                                                                   y: view.center.y - view.bounds.height * 0.5)
    }
    #endif

    var frame = CGRect(origin: origin, size: size).offsetBy(dx: topLeft.x, dy: topLeft.y)

    #if os(macOS)
    if let superview = view.superview, !superview.isFlipped, superview.isYogaEnabled, superview.yoga.isIncludedInLayout {
        let height = CGFloat(superview.yoga.node.height)
        frame.origin.y = height - frame.maxY
    }

    view.frame = frame
    #else
    if transformIsIdentity {
        view.frame = frame
    } else {
        var bounds  = view.bounds
        bounds.size = size
        view.bounds = bounds
        view.center = CGPoint(x: frame.midX, y: frame.midY)
    }
    #endif

    // no need layout subviews if width or height is zero.
    if size.width > 0, size.height > 0, !yoga.isLeaf {
        for subview in view.subviews {
            guard subview.isYogaEnabled {
                continue
            }

            let yoga = subview.yoga
            if yoga.isIncludedInLayout {
                YGApplyLayoutToViewHierarchy(subview, false)
            }
        }
    }

    yoga.isApplingLayout = false
}
