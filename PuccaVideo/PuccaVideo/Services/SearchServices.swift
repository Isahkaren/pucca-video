//
//  SearchServices.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift

protocol YouTubeServicesProtocol {
    func getVideos(by keyWord: String) -> Observable<(Items?)>
    //www.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=surfing&key={YOUR_API_KEY}
}

class SearchServices: YouTubeServicesProtocol {
    
    // MARK: - Properties
    public let kEndpoint = "search"
    public let kApiKey = "AIzaSyCwbGziupadfpxuaTv72BsKZxOAQQDDj9A"
    private(set) var dispatcher: NetworkDispatcherProtocol
    
    // MARK: - Lifecycle
    
    init() {
        let url = Environment.shared.baseUrl.appendingPathComponent(kEndpoint)
        dispatcher = NetworkDispatcher(url: url)
    }
    
    init(dispatcher: NetworkDispatcherProtocol) {
        self.dispatcher = dispatcher
    }
    
    // MARK: - Services
    
    /**
     Returns the current bitcoin price
     - Parameter currency: ISO4217 currency
     ## Important ##
     [ISO4217 values](https://api.coindesk.com/v1/bpi/supported-currencies.json): all values accepted by bitcoin desk.
     */
//    func getCurrentPrice(in currency: ISO4217) -> Observable<(CurrentPriceTO?, NetworkResponse)> {
//        let path = "currentprice/\(currency.rawValue).json"
//        return dispatcher.response(of: CurrentPriceTO.self, from: path, method: .get)
//    }
    
    func getVideos(by keyWord: String) -> Observable<(Items?)> {
        let path = "?part=snippet&maxResults=20&q=\(keyWord)&key=\(kApiKey)"
        return dispatcher.response(of: Items.self, from: path, method: .get)
    }
    
    /**
     Returns the price history in the given date interval
     - Parameter startDate: the start date in "YYYY-MM-DD" format
     - Parameter endDate: the end date in "YYYY-MM-DD" format
     - Parameter currency: ISO4217 currency
     ## Important ##
     [ISO4217 values](https://api.coindesk.com/v1/bpi/supported-currencies.json): all values accepted by bitcoin desk.
     */
//    func getHistoricalPrice(from startDate: String, to endDate: String, in currency: ISO4217) -> Observable<(BPIHistory?, NetworkResponse)> {
//        let path = "historical/close.json?currency=\(currency.rawValue)&start=\(startDate)&end=\(endDate)"
//        return dispatcher.response(of: BPIHistory.self, from: path, method: .get)
//    }
}
