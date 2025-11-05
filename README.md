# ProductKit

**ProductKit** is a Swift Package for fetching and managing product data using Combine.  
It provides a network client and mock data for testing.

---

## Features

- Fetch product lists and individual product details via Combine  
- Mock client for previews and unit tests (`ProductClientMock`)  
- JSON body & query parameter encoding (`RequestParameters`)  
- Pagination support via `ProductResponse.total`  

---

## Installation

Add **ProductKit** via Swift Package Manager:

```swift
.package(url: "https://github.com/sanazbahmankhahios/ProductKit.git", from: "1.0.0")

Then include it in your target dependencies:
.target(
    name: "YourApp",
    dependencies: [
        "ProductKit"
    ]
)
