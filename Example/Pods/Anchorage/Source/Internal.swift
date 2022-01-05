
//
//  Internal.swift
//  Anchorage
//
//  Created by Rob Visentin on 5/1/17.
//
//  Copyright 2016 Raizlabs and other contributors
//  http://raizlabs.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#if os(macOS)
    import Cocoa

    internal typealias View = NSView
    internal typealias ViewController = NSViewController
    internal typealias LayoutGuide = NSLayoutGuide

    #if swift(>=4.0)
        internal let LayoutPriorityRequired = NSLayoutConstraint.Priority.required
        internal let LayoutPriorityHigh = NSLayoutConstraint.Priority.defaultHigh
        internal let LayoutPriorityLow = NSLayoutConstraint.Priority.defaultLow
        internal let LayoutPriorityFittingSize = NSLayoutConstraint.Priority.fittingSizeCompression
    #else
        internal let LayoutPriorityRequired = NSLayoutPriorityRequired
        internal let LayoutPriorityHigh = NSLayoutPriorityDefaultHigh
        internal let LayoutPriorityLow = NSLayoutPriorityDefaultLow
        internal let LayoutPriorityFittingSize = NSLayoutPriorityFittingSizeCompression
    #endif
#else
    import UIKit

    internal typealias View = UIView
    internal typealias ViewController = UIViewController
    internal typealias LayoutGuide = UILayoutGuide

    #if swift(>=4.0)
        internal let LayoutPriorityRequired = UILayoutPriority.required
        internal let LayoutPriorityHigh = UILayoutPriority.defaultHigh
        internal let LayoutPriorityLow = UILayoutPriority.defaultLow
        internal let LayoutPriorityFittingSize = UILayoutPriority.fittingSizeLevel
    #else
        internal let LayoutPriorityRequired = UILayoutPriorityRequired
        internal let LayoutPriorityHigh = UILayoutPriorityDefaultHigh
        internal let LayoutPriorityLow = UILayoutPriorityDefaultLow
        internal let LayoutPriorityFittingSize = UILayoutPriorityFittingSizeLevel
    #endif
#endif

// MARK: - LayoutExpression

public struct LayoutExpression<T: LayoutAnchorType, U: LayoutConstantType> {

    public var anchor: T?
    public var constant: U
    public var multiplier: CGFloat
    public var priority: Priority

    internal init(anchor: T? = nil, constant: U, multiplier: CGFloat = 1.0, priority: Priority = .required) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }

}

// MARK: - AnchorPair

public struct AnchorPair<T: LayoutAnchorType, U: LayoutAnchorType>: LayoutAnchorType {

    public var first: T
    public var second: U

    public init(first: T, second: U) {
        self.first = first
        self.second = second
    }

}

internal extension AnchorPair {

    func finalize(constraintsEqualToConstant size: CGSize, priority: Priority = .required) -> ConstraintPair {
        return constraints(forConstant: size, priority: priority, builder: ConstraintBuilder.equality);
    }

    func finalize(constraintsLessThanOrEqualToConstant size: CGSize, priority: Priority = .required) -> ConstraintPair {
        return constraints(forConstant: size, priority: priority, builder: ConstraintBuilder.lessThanOrEqual);
    }

    func finalize(constraintsGreaterThanOrEqualToConstant size: CGSize, priority: Priority = .required) -> ConstraintPair {
        return constraints(forConstant: size, priority: priority, builder: ConstraintBuilder.greaterThanOrEqual);
    }

    func finalize(constraintsEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: Priority = .required) -> ConstraintPair {
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: ConstraintBuilder.equality)
    }

    func finalize(constraintsLessThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: Priority = .required) -> ConstraintPair {
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: ConstraintBuilder.lessThanOrEqual)
    }

    func finalize(constraintsGreaterThanOrEqualToEdges anchor: AnchorPair<T, U>?, constant c: CGFloat = 0.0, priority: Priority = .required) -> ConstraintPair {
        return constraints(forAnchors: anchor, constant: c, priority: priority, builder: ConstraintBuilder.greaterThanOrEqual)
    }

    func constraints(forConstant size: CGSize, priority: Priority, builder: ConstraintBuilder) -> ConstraintPair {
        var constraints: ConstraintPair!

        performInBatch {
            switch (first, second) {
            case let (first as NSLayoutDimension, second as NSLayoutDimension):
                constraints = ConstraintPair(
                    first: builder.dimensionBuilder(first, size.width ~ priority),
                    second: builder.dimensionBuilder(second, size.height ~ priority)
                )
            default:
                preconditionFailure("Only AnchorPair<NSLayoutDimension, NSLayoutDimension> can be constrained to a constant size.")
            }
        }

        return constraints;
    }

    func constraints(forAnchors anchors: AnchorPair<T, U>?, constant c: CGFloat, priority: Priority, builder: ConstraintBuilder) -> ConstraintPair {
        return constraints(forAnchors: anchors, firstConstant: c, secondConstant: c, priority: priority, builder: builder)
    }

    func constraints(forAnchors anchors: AnchorPair<T, U>?, firstConstant c1: CGFloat, secondConstant c2: CGFloat, priority: Priority, builder: ConstraintBuilder) -> ConstraintPair {
        guard let anchors = anchors else {
            preconditionFailure("Encountered nil edge anchors, indicating internal inconsistency of this API.")
        }

        var constraints: ConstraintPair!

        performInBatch {
            switch (first, anchors.first, second, anchors.second) {
            // Leading, Trailing
            case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                      secondX as NSLayoutXAxisAnchor, otherSecondX as NSLayoutXAxisAnchor):
                constraints = ConstraintPair(
                    first: builder.leadingBuilder(firstX, otherFirstX + c1 ~ priority),
                    second: builder.trailingBuilder(secondX, otherSecondX - c2 ~ priority)
                )
            // Top, Bottom
            case let (firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor,
                      secondY as NSLayoutYAxisAnchor, otherSecondY as NSLayoutYAxisAnchor):
                constraints = ConstraintPair(
                    first: builder.topBuilder(firstY, otherFirstY + c1 ~ priority),
                    second: builder.bottomBuilder(secondY, otherSecondY - c2 ~ priority)
                )
            // CenterX, CenterY
            case let (firstX as NSLayoutXAxisAnchor, otherFirstX as NSLayoutXAxisAnchor,
                      firstY as NSLayoutYAxisAnchor, otherFirstY as NSLayoutYAxisAnchor):
                constraints = ConstraintPair(
                    first: builder.centerXBuilder(firstX, otherFirstX + c1 ~ priority),
                    second: builder.centerYBuilder(firstY, otherFirstY + c2 ~ priority)
                )
            // Width, Height
            case let (first as NSLayoutDimension, otherFirst as NSLayoutDimension,
                      second as NSLayoutDimension, otherSecond as NSLayoutDimension):
                constraints = ConstraintPair(
                    first: builder.dimensionBuilder(first, otherFirst + c1 ~ priority),
                    second: builder.dimensionBuilder(second, otherSecond + c2 ~ priority)
                )
            default:
                preconditionFailure("Constrained anchors must match in either axis or type.")
            }
        }

        return constraints
    }

}

// MARK: - EdgeAnchors

internal extension EdgeInsets {

    init(constant: CGFloat) {
        self.init(
            top: constant,
            left: constant,
            bottom: constant,
            right: constant
        )
    }

}

internal prefix func - (rhs: EdgeInsets) -> EdgeInsets {
    return EdgeInsets(
        top: -rhs.top,
        left: -rhs.left,
        bottom: -rhs.bottom,
        right: -rhs.right