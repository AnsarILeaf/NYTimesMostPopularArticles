//
//  MockService.swift
//  NYTimesMostPopularArticlesTests
//
//  Created by ANSAR on 30/11/21.
//

import Foundation
@testable import NYTimesMostPopularArticles

class MockService : ServiceProtocol {
    
    func fetchArticleList(periods: Periods, completion: @escaping ([Article]?) -> Void) {
        completion(mockData)
    }
    
    let mockData: [Article]?
    
    init(mockData: [Article]?) {
        self.mockData = mockData
    }
    
}
