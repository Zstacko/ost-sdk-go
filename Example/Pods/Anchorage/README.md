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
// Position a view to be centered at 2/3 of its container's widt