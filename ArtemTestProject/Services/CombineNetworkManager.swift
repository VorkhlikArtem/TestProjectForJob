//
//  CombineNetworkManager.swift
//  ArtemTestProject
//
//  Created by Артём on 14.03.2023.
//

import Foundation
import Combine

final class CombineNetworkManager {
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    // MARK: - fetching Data for Page1 VC
    func getMain() -> AnyPublisher<(LatestResponse, FlashSaleResponse), Error> {
        return getLatest().zip(getFlashSale()).eraseToAnyPublisher()
    }
    
    func getLatest() -> AnyPublisher<LatestResponse, Error> {
        return fetchData(url: Url.latest, type: LatestResponse.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getFlashSale() -> AnyPublisher<FlashSaleResponse, Error> {
        return fetchData(url: Url.flashSale, type: FlashSaleResponse.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - fetching Data for Page2 VC
    func getDetails() -> AnyPublisher<DetailModel, Error> {
        return fetchData(url: Url.details, type: DetailModel.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - fetching search words
    func getSearchWords() -> AnyPublisher<[String], Error> {
        return fetchData(url: Url.searchWords, type: SearchWordsResponse.self)
            .map{ $0.words }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    
    // MARK: - Generic Method for Data Fetching 
    private func fetchData<T: Decodable>(url: String, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: DataFetchingError.invalidUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw DataFetchingError.serverResponseError
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { _ in DataFetchingError.decodingError }
            
            .eraseToAnyPublisher()
    }
}
