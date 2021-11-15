//
//  ContentView.swift
//  MultipleDragAndDrop
//
//  Created by Richard Witherspoon on 11/14/21.
//

import SwiftUI


struct ContentView: View {
    @State private var title = DropType.color.rawValue
    @State private var selection = DropType.color
    @State private var color = Color.blue
    
    enum DropType: String, CaseIterable{
        case color, text, multi, broken
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("Drop Type", selection: $selection){
                    ForEach(DropType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: selection) { newValue in
                    title = newValue.rawValue
                }
                
                Spacer()

                switch selection {
                case .color:
                    content
                        .onDrop(of: [.color], delegate: ColorDropDelegate(color: $color))
                case .text:
                    content
                        .onDrop(of: [.text], delegate: TextDropDelegate(text: $title))
                case .multi:
                    content
                        .onDrop(of: [.color, .text], delegate: CombinedDropDelegate(color: $color, text: $title))
                case .broken:
                    content
                        .onDrop(of: [.color], delegate: ColorDropDelegate(color: $color))
                        .onDrop(of: [.text], delegate: TextDropDelegate(text: $title))
                }
                
                Spacer()
            }
            .navigationTitle("Drag & Drop")
        }
        .navigationViewStyle(.stack)
    }
    
    
    var content: some View{
        Text(title)
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 300, height: 300)
            .padding()
            .background(color)
            .cornerRadius(10)
            .multilineTextAlignment(.center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
