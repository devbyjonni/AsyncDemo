//
//  TodoImageViewModelTests.swift
//  AsyncDemoTests
//
//  Created by Jonni Akesson on 2023-03-05.
//

import XCTest
@testable import AsyncDemo

final class TodoImageViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadImage() async throws {
        // Given
        let expectedImage = UIImage(systemName: "circle")!
        let imageLoader = MockImageLoader(expectedImage: expectedImage)
        let viewModel = TodoImageViewModel(imageLoader: imageLoader)
        
        // When
        await viewModel.loadImage(from: URL(string: "https://example.com/image.jpg")!)
        
        // Then
        XCTAssertEqual(viewModel.uiImage, expectedImage)
    }
    
    func testLoadRealImage() async throws {
        // Given
        let url = URL(string: "https://picsum.photos/200")!
        let imageLoader = ImageLoader()
        let viewModel = TodoImageViewModel(imageLoader: imageLoader)
        
        // When
        await viewModel.loadImage(from: url)
        
        // Then
        XCTAssertNotNil(viewModel.uiImage)
    }
}

class MockImageLoader: ImageLoaderProtocol {
    let expectedImage: UIImage
    
    init(expectedImage: UIImage) {
        self.expectedImage = expectedImage
    }
    
    func fetchImage(from url: URL?) async throws -> UIImage? {
        return expectedImage
    }
}
