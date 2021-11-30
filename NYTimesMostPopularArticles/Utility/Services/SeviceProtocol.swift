

import Foundation

protocol ServiceProtocol {
    func fetchArticleList(periods: Periods, completion: @escaping ([Article]?) -> Void)
}
