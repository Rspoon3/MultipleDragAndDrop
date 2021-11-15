//
//  DropDelegates.swift
//  MultipleDragAndDrop
//
//  Created by Richard Witherspoon on 11/14/21.
//

import SwiftUI


struct ColorDropDelegate: DropDelegate {
    @Binding var color: Color
    
    func performDrop(info: DropInfo) -> Bool {
        guard
            info.hasItemsConforming(to: [.color]),
            let provider = info.itemProviders(for: [.color]).first
        else {
            return false
        }
        
        Task{
            let uiColor = try await provider.loadObject(ofClass: UIColor.self)
            color = .init(uiColor)
        }
        
        return true
    }
}



struct TextDropDelegate: DropDelegate {
    @Binding var text: String
    
    func performDrop(info: DropInfo) -> Bool {
        guard
            info.hasItemsConforming(to: [.text]),
            let provider = info.itemProviders(for: [.text]).first
        else {
            return false
        }
        
        Task{
            text = try await provider.loadObject(ofClass: String.self)
        }
        
        return true
    }
}




struct CombinedDropDelegate: DropDelegate {
    @Binding var color: Color
    @Binding var text: String
    
    
    func performDrop(info: DropInfo) -> Bool {
        let providers = info.itemProviders(for: [.color, .text])
        
        Task{
            for provider in providers {
                do {
                    if provider.canLoadObject(ofClass: UIColor.self){
                        let uiColor = try await provider.loadObject(ofClass: UIColor.self)
                        color = .init(uiColor)
                    } else if provider.canLoadObject(ofClass: String.self){
                        text = try await provider.loadObject(ofClass: String.self)
                    }
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        return true
    }
}
