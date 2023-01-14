//
//  Combine.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 13/1/2566 BE.
//

public struct Combine<Base> {
    
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

public protocol CombineCompatible {
    
    associatedtype CompatibleType
    
    static var cb: Combine<CompatibleType>.Type { get set }
    
    var cb: Combine<CompatibleType> { get set }
}

extension CombineCompatible {
    public static var cb: Combine<Self>.Type {
        get {
            return Combine<Self>.self
        }
        set {
            
        }
    }
    
    public var cb: Combine<Self> {
        get {
            return Combine(self)
        }
        set {
            
        }
    }
}

import class Foundation.NSObject

extension NSObject: CombineCompatible { }

