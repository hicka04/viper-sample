//
//  RepositorySearchInteractorTests.swift
//  ViperSampleDomainTests
//
//  Created by hicka04 on 2020/02/25.
//

import Quick
import Nimble
@testable import ViperSampleDomain
import ViperSampleData

class RepositorySearchInteractorTests: QuickSpec {

    override func spec() {
        let mock = MockGitHubDataStore()
        let interactor = RepositorySearchInteractor(gitHubDataStore: mock, translator: .init())
        describe("search") {
            context("when api response success") {
                mock.searchRepositoriesResult = .success([])
                it("return repositories") {
                    interactor.search(keyword: "hoge") { result in
                        switch result {
                        case .success(let repositories):
                            expect(repositories).to(equal([]))
                        case .failure:
                            fail()
                        }
                    }
                }
            }
        }
    }
}

class MockGitHubDataStore: GitHubRepository {
    
    var searchRepositoriesResult: Result<[ViperSampleData.Repository], GitHubDataStoreError>?
    var searchRepositoriesCallCount = 0
    func searchRepositories(keyword: String, completion: @escaping (Result<[ViperSampleData.Repository], GitHubDataStoreError>) -> Void) {
        completion(searchRepositoriesResult!)
        searchRepositoriesCallCount += 1
    }
}
