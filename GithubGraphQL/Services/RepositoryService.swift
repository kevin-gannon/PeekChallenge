import RxCocoa
import RxSwift
import Apollo

typealias PageInfo = SearchRepositoriesQuery.Data.Search.PageInfo

struct RepositorySearchResponse {
    let repositories: [RepositoryDetails]
    let pageInfo: PageInfo
}

struct RepositoryService {
    func getRepositories(
        _ query: String,
        _ pageSize: Int,
        _ pageStart: String? = nil
    ) -> Observable<APIResponse<RepositorySearchResponse>> {
        return Observable.create { observer in
            let gqlQuery = SearchRepositoriesQuery.init(
                first: pageSize,
                after: pageStart,
                query: query,
                type: SearchType.repository
            )
            RepositoriesGraphQLClient.searchRepositories(query: gqlQuery) { (result) in
               switch result {
               case .success(let data):
                 guard
                    let gqlResult = data,
                    let pageInfo = gqlResult.data?.search.pageInfo else {
                    observer.onNext(APIResponse<RepositorySearchResponse>(
                        networkError: .CouldNotParse
                    ))
                    return
                 }

                 let _repositories = gqlResult.data?.search.edges?.compactMap {
                    next -> RepositoryDetails? in
                    guard let repository = next?
                        .node?
                        .asRepository?
                        .fragments
                        .repositoryDetails else { return nil }
                    
                    return repository
                 }
                 
                 guard let repositories = _repositories else {
                    observer.onNext(APIResponse<RepositorySearchResponse>(
                        networkError: .CouldNotParse
                    ))
                    return
                 }

                observer.onNext(APIResponse<RepositorySearchResponse>(
                    data: RepositorySearchResponse(
                        repositories: repositories,
                        pageInfo: pageInfo
                )))
                
               case .failure(let error):
                 if let error = error {
                    observer.onNext(APIResponse<RepositorySearchResponse>(
                        networkError: .Network(error: error)
                    ))
                 }
               }
             }
            return Disposables.create {}
        }
    }
}
