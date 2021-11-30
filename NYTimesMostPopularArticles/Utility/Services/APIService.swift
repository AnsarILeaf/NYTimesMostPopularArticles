

import Foundation

fileprivate let api_key = "DxZjh5ClH4yd6PzoX0gIdlo7W7F9jjup"


class APIService : ServiceProtocol {
    
    func fetchArticleList(periods: Periods, completion: @escaping ([Article]?) -> Void) {
        loadData({ articles in
            completion(articles)
        }, period: periods)
    }
    
    private func loadData(_ completion: @escaping ([Article]?) -> Void, period: Periods) {
        
         let url = "\(URLConstants.base_url)\(URLConstants.most_popular_url)\(period.rawValue).json"
        
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = [URLQueryItem(name: "api-key", value: api_key)]

        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(request.description)
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            guard let articles = try? JSONDecoder().decode(ArticlesResponse.self, from: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                
                completion(articles.articles)
                
            }
            
        }.resume()
    }
    
}
