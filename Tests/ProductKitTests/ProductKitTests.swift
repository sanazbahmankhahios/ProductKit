import XCTest
import Combine

@testable import ProductKit

final class ProductKitTests: XCTestCase {
    var mockClient: ProductClientMock!
    var cancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockClient = ProductClientMock()
        cancellable = []
    }
    
    override func tearDown() {
        mockClient = nil
        cancellable = nil
        super.tearDown()
    }
    
    func testProductsReturnsAllProducts() {
        let expectation = expectation(description: "Products publisher returns products")
        
        mockClient.products(request: ProductRequest(limit: 10, skip: 0))
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Publisher failed with error: \(error)")
                }
            } receiveValue: { response in
                XCTAssertEqual(response.products.count, 4)
                XCTAssertEqual(response.total, 4)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testProductByIdReturnsProduct() {
        let targetProduct = mockClient.products[0]
        let expectation = expectation(description: "Product by ID returns correct product")
        
        mockClient.product(by: targetProduct.id)
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Publisher failed with error: \(error)")
                }
            } receiveValue: { product in
                XCTAssertEqual(product.id, targetProduct.id)
                XCTAssertEqual(product.title, targetProduct.title)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testProductByIdReturnsErrorForMissingProduct() {
        let expectation = expectation(description: "Product by ID returns error for missing product")
        let missingId = 999_999
        
        mockClient.product(by: missingId)
            .sink { completion in
                if case let .failure(error) = completion {
                    if let networkError = error as? NetworkError {
                        XCTAssertEqual(networkError, .keyNotFound)
                        expectation.fulfill()
                    } else {
                        XCTFail("Unexpected error type")
                    }
                }
            } receiveValue: { _ in
                XCTFail("Publisher should not emit a product for missing ID")
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
        
        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}
