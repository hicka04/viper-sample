//
//  GitHubDataStore.swift
//  ViperSampleData
//
//  Created by hicka04 on 2020/02/24.
//

import Foundation

public protocol GitHubRepository: AnyObject {
    
    func searchRepositories(keyword: String,
                            completion: @escaping (Result<[Repository], GitHubDataStoreError>) -> Void)
}

public final class GitHubDataStore {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func send<Request: GitHubRequest>(_ request: Request,
                                              completion: @escaping (Result<Request.Response, GitHubDataStoreError>) -> Void) {
        let urlRequest = request.buildURLRequest()
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            switch (data, response, error) {
            case (_, _, let error?):
                completion(.failure(.connectionError(error)))
                
            case (let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(.success(response))
                } catch let error as GitHubAPIError {
                    completion(.failure(.apiError(error)))
                } catch {
                    completion(.failure(.responseParseError(error)))
                }
                
            default:
                fatalError("Invalid response combination")
            }
        }
        
        task.resume()
    }
}

extension GitHubDataStore: GitHubRepository {
    
    public func searchRepositories(keyword: String,
                                   completion: @escaping (Result<[Repository], GitHubDataStoreError>) -> Void) {
        send(Endpoint.Search.SearchRepositories(keyword: keyword)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
