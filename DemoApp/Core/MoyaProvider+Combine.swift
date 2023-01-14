//
//  MoyaProvider+Combine.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

import Combine
import Foundation
import Moya

extension MoyaProvider: CombineCompatible {}

public extension Combine where Base: MoyaProviderType {
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Future<Response, Error> {
        return Future { [weak base] promise in
            _ = base?.request(token, callbackQueue: callbackQueue, progress: nil, completion: { result in
                switch result {
                case let .success(response):
                    promise(.success(response))
                case let .failure(error):
                    promise(.failure(error))
                }
            })
        }
    }
}

public extension Publisher where Output == Response, Failure == Error {
    func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder(), failsOnEmptyData: Bool = true) -> AnyPublisher<D, Self.Failure> {
        return flatMap { output -> Future<D, Self.Failure> in
            Future { promise in
                do {
                    promise(.success(try output.map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)))
                } catch {
                    promise(.failure(MoyaError.jsonMapping(output)))
                }
            }
        }.eraseToAnyPublisher()
    }

    func filter(statusCode: Int) -> AnyPublisher<Response, Error> {
        return flatMap { output -> Future<Response, Error> in
            Future { promise in
                do {
                    promise(.success(try output.filter(statusCode: statusCode)))
                } catch {}
            }
        }.eraseToAnyPublisher()
    }

    func filter<R: RangeExpression>(statusCodes: R) -> AnyPublisher<Response, Error> where R.Bound == Int {
        return flatMap { output -> Future<Response, Error> in
            Future { promise in
                do {
                    promise(.success(try output.filter(statusCodes: statusCodes)))
                } catch {}
            }
        }.eraseToAnyPublisher()
    }

    func filterWithError<R: RangeExpression>(statusCodes: R) -> AnyPublisher<Response, Error> where R.Bound == Int {
        return flatMap { output -> Future<Response, Error> in
            Future { promise in
                do {
                    promise(.success(try output.filter(statusCodes: statusCodes)))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
