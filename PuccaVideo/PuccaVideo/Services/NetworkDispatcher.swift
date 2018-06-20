//
//  NetworkDispatcher.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift

public enum HTTPMethod: String {
    case get = "GET"
}

protocol NetworkDispatcherProtocol {
    init(url: URL)
    func response<T: Codable>(of type: T.Type, from path: String, method: HTTPMethod) -> Observable<([T]?)>
}

class NetworkDispatcher: NetworkDispatcherProtocol {

    // MARK: - Properties
    
    private(set) var url: URL
    
    // MARK: - Lifecycle
    
    /**
     Initialize the dispatcher with a base endpoint url
     - Parameter url: endpoint to request.
     */
    required init(url: URL) {
        self.url = url
    }
    
    // MARK: - Responses
    
//    /**
//     - Parameter type: generic object type that conforms with Codable
//     - Returns: an Observable of item
//     */
//    public func response<T: Codable>(of type: T.Type, from path: String, method: HTTPMethod) -> Observable<(T?)> {
//        return Observable.create { observable in
//
//            self.dispatch(path: path, method: method, { (data, error) in
//                if let error = error {
//                    // If the request couldn't be completed with success
//                    // send an error sequence so the subscribers can be notified and
//                    // the observable can be automatically deallocated
//                    observable.onError(error)
//                } else if let data = data {
//                    let serializedObject = try? JSONDecoder().decode(T.self, from: data)
//                    observable.onNext(serializedObject)
//                } else {
//                    observable.onNext(nil)
//                }
//
//                // After dispatch the sequence of next events
//                // complete the observable so it can be deallocated
//                observable.onCompleted()
//            })
//
//            return Disposables.create()
//        }
//    }
    
    /**
     - Parameter type: generic object type that conforms with Codable
     - Returns: an Observable of items
     */
    public func response<T: Codable>(of type: T.Type, from path: String, method: HTTPMethod) -> Observable<([T]?)> {
        return Observable.create { observable in
            
            self.dispatch(path: path, method: method, { (data, error) in
                if let error = error {
                    // If the request couldn't be completed with success
                    // send an error sequence so the subscribers can be notified and
                    // the observable can be automatically deallocated
                    observable.onError(error)
                } else if let data = data {
                    let serializedObject = try? JSONDecoder().decode([T].self, from: data)
                    observable.onNext(serializedObject)
                } else {
                    observable.onNext(nil)
                }
                
                // After dispatch the sequence of next events
                // complete the observable so it can be deallocated
                observable.onCompleted()
            })
            
            return Disposables.create()
        }
    }
    
    // MARK: - URLSession handler
    
    /// Dispatch the request and return the URLSession.shared.dataTask response
    private func dispatch(path: String, method: HTTPMethod, _ completion: @escaping (_ data: Data?, _ error: NetworkError?) -> Void) {
        guard let requestURL = getURL(with: path) else {
            completion(nil, NetworkError(message: "service.invalid.url".localized))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, res, error in
            
            guard let statusCode = (res as? HTTPURLResponse)?.statusCode,
                    (200...299 ~= statusCode)
                    else {
                        completion(nil, NetworkError(message: "service.error.generic".localized))
                        return
            }
            
            completion(data, nil)
            
        }.resume()
    }
    
    // MARK: - Helpers
    
    public func getURL(with path: String) -> URL? {
        guard let urlString = url.appendingPathComponent(path).absoluteString.removingPercentEncoding,
            let requestUrl = URL(string: urlString) else {
                return nil
        }
        return requestUrl
    }
    

}
