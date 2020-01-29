import Foundation
import Apollo

enum NetworkError: Error {
    case Network(error: Error)
    case CouldNotParse
}

struct APIResponse<T:Any> {
    var data: T?
    var networkError: NetworkError?
    
    init(
        data: T? = nil,
        networkError: NetworkError? = nil
    ) {
        self.data = data
        self.networkError = networkError
    }
}
