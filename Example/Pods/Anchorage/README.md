# Anchorage

[![Swift 3.0 + 4.0](https://img.shields.io/badge/Swift-3.0%20+%204.0-orange.svg?style=flat)](https://swift.org)
[![CircleCI](https://img.shields.io/circleci/project/github/Raizlabs/Anchorage/master.svg)](https://circleci.com/gh/Raizlabs/Anchorage)
[![Version](https://img.shields.io/cocoapods/v/Anchorage.svg?style=flat)](https://cocoadocs.org/docsets/Anchorage)
[![Platform](https://img.shields.io/cocoapods/p/Anchorage.svg?style=flat)](http://cocoapods.org/pods/Anchorage)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A lightweight collection of intuitive operators and utilities that simplify Auto Layout code. Anchorage is built directly on top of the `NSLayoutAnchor` API.

Each expression acts on one or more `NSLayoutAnchor`s, and returns active `NSLayoutConstraint`s. If you want inactive constraints, [here's how to do that](#batching-constraints).

# Usage

## Alignment

```swift
// Pin the button to 12 pt from the leading edge of its container
button.leadingAnchor == container.leadingAnchor + 12

// Pin the button to at least 12 pt from the trailing edge of its container
button.trailingAnchor <= container.trailingAnchor - 12

// Center one or both axes of a view
button.centerXAnchor == container.centerXAnchor
button.centerAnchors == container.centerAnchors
```

## Relative Alignment

```swift
// Position a view to be centered at 2/3 of its container's width
view.centerXAnchor == 2 * container.trailingAnchor / 3

// Pin the top of a view at 25% of container's height
view.topAnchor == container.bottomAnchor / 4
```

## Sizing

```swift
// Constrain a view's width to be at most 100 pt
view.widthAnchor <= 100

// Constraint a view to a fixed size
imageView.sizeAnchors == CGSize(width: 100, height: 200)

// Constrain two views to be the same size
imageView.sizeAnchors == view.sizeAnchors

// Constrain view to 4:3 aspect ratio
view.widthAnchor == 4 * view.heightAnchor / 3
```

## Composite Anchors

Constrain multiple edges at a time with this syntax:

```swift
// Constrain the leading, trailing, top and bottom edges to be equal
imageView.edgeAnchors == container.edgeAnchors

// Inset the edges of a view from another view
let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
imageView.edgeAnchors == container.edgeAnchors + insets

// Inset the leading and trailing anchors by 10
imageView.horizontalAnchors >= container.horizontalAnchors + 10

// Inset the top and bottom anchors by 10
imageView.verticalAnchors >= container.verticalAnchors + 10
```

#### Use leading and trailing
Using `leftAnchor` and `rightAnchor` is rarely the right choice. To encourage this, `horizontalAnchors` and `edgeAnchors` use the `leadingAnchor` and `trailingAnchor` layout anchors.

#### Inset instead of Shift
When constraining leading/trailing or top/bottom, it is far more common to work in terms of an inset from the edges instead of shifting both edges in the same direction. When building the expression, Anchorage will flip the relationship and invert the constant in the constraint on the far side of the axis. This makes the expressions much more natural to work with.


## Priority

The `~` is used to specify priority of the constraint resulting from any Anchorage expression:

```swift
// Align view 20 points from the center of its superview, with system-defined low priority
view.centerXAnchor == view.superview.centerXAnchor + 20 ~ .low

// Align view 20 points from the center of its superview, with (required - 1) priority
view.centerXAnchor == view.superview.centerXAnchor + 20 ~ .required - 1

// Align view 20 points from the center of its superview, with custom priority
view.centerXAnchor == view.superview.centerXAnchor + 20 ~ 752
```
The layout priority is an enum with the following values:

- `.required` - `UILayoutPriorityRequired` (default)
- `.high` - `UILayoutPriorityDefaultHigh`
- `.low` - `UILayoutPriorityDefaultLow`
- `.fittingSize` - `UILayoutPriorityFittingSizeLevel`

## Storing Constraints

To store constraints created by Anchorage, simply assign the express