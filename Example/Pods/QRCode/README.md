# QRCode 🔳

[![Build Status](https://travis-ci.org/aschuch/QRCode.svg)](https://travis-ci.org/aschuch/QRCode)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)

A QRCode generator written in Swift.

![QRCode Example](Resources/example.png)

## Overview

Create a new QRCode representing a `URL`, a string or arbitrary data.
The following examples all result in the same QRCode image.

```swift
// URL
let url = URL(string: "http://schuch.me")!
let qrCode = QRCode(url)
qrCode?.image

// String
let qrCode = QRCode("http://schuch.me")
qrCode?.image

// NSData
let data = "http://schu