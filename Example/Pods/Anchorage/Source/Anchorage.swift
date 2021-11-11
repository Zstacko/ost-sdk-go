
//
//  Anchorage.swift
//  Anchorage
//
//  Created by Rob Visentin on 2/6/16.
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
#else
    import UIKit
#endif

public protocol LayoutConstantType {}
extension CGFloat: LayoutConstantType {}
extension CGSize: LayoutConstantType {}
extension EdgeInsets: LayoutConstantType {}

public protocol LayoutAnchorType {}
extension NSLayoutAnchor: LayoutAnchorType {}

// MARK: - Equality Constraints

@discardableResult public func == <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalToConstant: CGFloat(rhs)))
}

@discardableResult public func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs))
}

@discardableResult public func == (lhs: NSLayoutXAxisAnchor, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == (lhs: NSLayoutYAxisAnchor, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func == (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(equalToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: EdgeAnchors) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func == (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
}

@discardableResult public func == <T, U>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToEdges: rhs)
}

@discardableResult public func == <T, U>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func == (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: CGSize) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToConstant: rhs)
}

@discardableResult public func == (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: LayoutExpression<AnchorPair<NSLayoutDimension, NSLayoutDimension>, CGSize>) -> ConstraintPair {
    return lhs.finalize(constraintsEqualToConstant: rhs.constant, priority: rhs.priority)
}

// MARK: - Inequality Constraints

@discardableResult public func <= <T: BinaryFloatingPoint>(lhs: NSLayoutDimension, rhs: T) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs)))
}

@discardableResult public func <= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs))
}

@discardableResult public func <= (lhs: NSLayoutXAxisAnchor, rhs: LayoutExpression<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= (lhs: NSLayoutYAxisAnchor, rhs: LayoutExpression<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return finalize(constraint: lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
}

@discardableResult public func <= (lhs: NSLayoutDimension, rhs: LayoutExpression<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return finalize(constraint: lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant), withPriority: rhs.priority)
    }
    else {
        return finalize(constraint: lhs.constraint(lessThanOrEqualToConstant: rhs.constant), withPriority: rhs.priority)
    }
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: EdgeAnchors) -> ConstraintGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, CGFloat>) -> ConstraintGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func <= (lhs: EdgeAnchors, rhs: LayoutExpression<EdgeAnchors, EdgeInsets>) -> ConstraintGroup {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, insets: rhs.constant, priority: rhs.priority)
}

@discardableResult public func <= <T, U>(lhs: AnchorPair<T, U>, rhs: AnchorPair<T, U>) -> ConstraintPair {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs)
}

@discardableResult public func <= <T, U>(lhs: AnchorPair<T, U>, rhs: LayoutExpression<AnchorPair<T, U>, CGFloat>) -> ConstraintPair {
    return lhs.finalize(constraintsLessThanOrEqualToEdges: rhs.anchor, constant: rhs.constant, priority: rhs.priority)
}

@discardableResult public func <= (lhs: AnchorPair<NSLayoutDimension, NSLayoutDimension>, rhs: CGSize) -> ConstraintPair {