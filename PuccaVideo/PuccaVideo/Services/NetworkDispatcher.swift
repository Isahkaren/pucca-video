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
    func response<T: Codable>(of type: T.Type, from path: String, method: HTTPMethod) -> Observable<(T?, NetworkResponse)>
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
    
    /**
     Dispatch the URLRequest on **URLSession.shared.dataTask**
     - Parameter type: generic object type that conforms with Codable
     - Returns: an observable of the generic type and the default response object NetworkResponse
     */
    public func response<T: Codable>(of type: T.Type, from path: String, method: HTTPMethod) -> Observable<(T?, NetworkResponse)> {
        return Observable.create { observable in
            self.dispatch(path: path, method: method, { (response) in
                if let error = response.error {
                    
                    // If the request couldn't be completed with success
                    // send an error sequence so the subscribers can be notified and
                    // the observable can be automatically deallocated
                    observable.onError(error)
                } else if let data = response.data {
                    let serializedObject = try? JSONDecoder().decode(T.self, from: data)
                    observable.onNext((serializedObject, response))
                } else {
                    observable.onNext((nil, response))
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
    private func dispatch(path: String, method: HTTPMethod, _ completion: @escaping (NetworkResponse) -> Void) {
        var networkResponse = NetworkResponse()
        
        guard let requestURL = getURL(with: path) else {
            networkResponse.error = NetworkError(message: "service.invalid.url".localize())
            completion(networkResponse)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, res, error in
            networkResponse.response = res as? HTTPURLResponse
            networkResponse.request = request
            networkResponse.data = data
            
            if let data = data {
                networkResponse.rawResponse = String(data: data, encoding: .utf8)
            }
            
            guard let statusCode = networkResponse.response?.statusCode,
                (200...299 ~= statusCode) else {
                    networkResponse.error = NetworkError(message: "service.error.generic".localize())
                    completion(networkResponse)
                    return
            }
            
            completion(networkResponse)
            
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
