//
//  NSItemProvider+Extension.swift
//  MultipleDragAndDrop
//
//  Created by Richard Witherspoon on 11/14/21.
//

import Foundation


public extension NSItemProvider{
    @available(iOS 15.0.0, *)
    func loadObject<T>(ofClass type: T.Type) async throws -> T where T : _ObjectiveCBridgeable, T._ObjectiveCType : NSItemProviderReading{
        return try await withCheckedThrowingContinuation { continuation in
            _ = loadObject(ofClass: type) { (nsItemProviderReading, error) in
                if let error = error{
                    continuation.resume(throwing: error)
                } else if let type = nsItemProviderReading {
                    continuation.resume(returning: type)
                } else {
                    let error = NSError(domain: "Unknown NSItemProviderReading Error", code: -1, userInfo: [:])
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    func loadObject<T: NSItemProviderReading>(ofClass aClass: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            _ = loadObject(ofClass: aClass) { (nsItemProviderReading, error) in
                if let error = error{
                    continuation.resume(throwing: error)
                } else if let type = nsItemProviderReading as? T{
                    continuation.resume(returning: type)
                } else {
                    let error = NSError(domain: "Unknown NSItemProviderReading Error", code: -1, userInfo: [:])
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
