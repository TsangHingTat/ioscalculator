//
//  ContentView.swift
//  Shared
//
//  Created by TsangHingTat on 27/12/2021.
//

import SwiftUI
import Combine
import MobileCoreServices

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "關於"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .red
        case .clear, .negative, .percent:
            return Color(UIColor(red: 166/255.0, green: 51/255.0, blue: 189/255.0, alpha: 1))
        default:
            return Color(UIColor(red: 28/255.0, green: 56/255.0, blue: 214/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    @State var value = "0"
    @State var runningNumber: Float = 0.0
    @State var currentOperation: Operation = .none
    @State private var showingPopover = false
    @State private var firstword = true
    @State private var dot = false
    @State private var notifications = ""
    @State private var cleanvalue = ""
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        Spacer()
        ZStack {
            HStack {
                VStack {
                    Text(notifications)
                        .font(.body)
                        .fontWeight(.bold)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .padding()
                    Spacer()
                    // Text display
                    VStack(spacing: 12) {
                        HStack {
                            Spacer()
                            if value == "0" {
                                Text("0.0")
                                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                                    .fontWeight(.bold)
                                    .scaledToFit()
                                    .minimumScaleFactor(0.01)
                                    .lineLimit(1)
                                    .padding()
                                    .onTapGesture {
                                        UIPasteboard.general.string = self.value
                                        notifications = "已複製到剪貼簿"
                                    }
                                
                            } else {
                                Text(" \(value) ")
                                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                                    .fontWeight(.bold)
                                    .scaledToFit()
                                    .minimumScaleFactor(0.01)
                                    .lineLimit(1)
                                    .padding()
                                    .onTapGesture {
                                        UIPasteboard.general.string = self.value
                                        notifications = "已複製到剪貼簿"
                                    }
                                
                            }
                        }
                    }
                    

                    // Our buttons
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    self.didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: self.buttonWidth(item: item),
                                            height: self.buttonHeight()
                                        )
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(self.buttonWidth(item: item)/2)
                                })
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
                
            }
            Spacer()
                .sheet(isPresented: $showingPopover) {
                    NavigationView {
                        VStack {
                            List {
                                HStack {
                                    Spacer()
                                    Image("iconapp")
                                        .resizable()
                                        .frame(width: 100.0, height: 100.0)
                                        .cornerRadius(25)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("GoodCalculator")
                                        .bold()
                                        .font(.title2)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("Created by TsangHingTat")
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("Copyright © 2021 CrazyApps. All rights reserved.")
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("我們的網頁: https://www.crazyapps.club")
                                    Spacer()
                                }
                                NavigationLink(destination: DebugdataView(value: value, runningNumber: runningNumber, showingPopover: showingPopover, firstword: firstword, dot: dot, notifications: notifications, cleanvalue: cleanvalue)) {
                                    HStack {
                                        Spacer()
                                        Text("Show Debug Data")
                                            .foregroundColor(.red)
                                            .font(.title2)
                                        Spacer()
                                    }
                                }
                                HStack {
                                    Spacer()
                                    Text("取消")
                                        .foregroundColor(.red)
                                        .font(.title2)
                                        .onTapGesture {
                                            showingPopover = false
                                        }
                                    Spacer()
                                }
                               
                            }
                            .navigationTitle("關於此 App")
                        }
                    }
                }
                                    
        }
    }
    

    func didTap(button: CalcButton) {
        notifications = ""
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                self.dot = false
                if firstword == false {
                    let runningValue = self.runningNumber
                    let currentValue = Float(self.value) ?? 0
                    
                    self.dot = false
                    
                    switch self.currentOperation {
                    case .add: self.value = "\(runningValue + currentValue)"
                    case .subtract: self.value = "\(runningValue - currentValue)"
                    case .multiply: self.value = "\(runningValue * currentValue)"
                    case .divide: self.value = "\(runningValue / currentValue)"
                    case .none:
                        break
                    }
                }
                self.currentOperation = .add
                self.runningNumber = Float(self.value) ?? 0
                self.firstword = false
            }
            else if button == .subtract {
                self.dot = false
                if firstword == false {
                    let runningValue = self.runningNumber
                    let currentValue = Float(self.value) ?? 0
                    
                    self.dot = false
                                        
                    switch self.currentOperation {
                    case .add: self.value = "\(runningValue + currentValue)"
                    case .subtract: self.value = "\(runningValue - currentValue)"
                    case .multiply: self.value = "\(runningValue * currentValue)"
                    case .divide: self.value = "\(runningValue / currentValue)"
                    case .none:
                        break
                    }
                }
                self.currentOperation = .subtract
                self.runningNumber = Float(self.value) ?? 0
                self.firstword = false
            }
            else if button == .mutliply {
                self.dot = false
                if firstword == false {
                    let runningValue = self.runningNumber
                    let currentValue = Float(self.value) ?? 0
                    
                    self.dot = false
                    
                    switch self.currentOperation {
                    case .add: self.value = "\(runningValue + currentValue)"
                    case .subtract: self.value = "\(runningValue - currentValue)"
                    case .multiply: self.value = "\(runningValue * currentValue)"
                    case .divide: self.value = "\(runningValue / currentValue)"
                    case .none:
                        break
                    }
                }
                self.currentOperation = .multiply
                self.runningNumber = Float(self.value) ?? 0
                self.firstword = false
            }
            else if button == .divide {
                self.dot = false
                if firstword == false {
                    let runningValue = self.runningNumber
                    let currentValue = Float(self.value) ?? 0
                    
                    self.dot = false
                    
                    switch self.currentOperation {
                    case .add: self.value = "\(runningValue + currentValue)"
                    case .subtract: self.value = "\(runningValue - currentValue)"
                    case .multiply: self.value = "\(runningValue * currentValue)"
                    case .divide: self.value = "\(runningValue / currentValue)"
                    case .none:
                        break
                    }
                }
                self.currentOperation = .divide
                self.runningNumber = Float(self.value) ?? 0
                self.firstword = false
            }
            else if button == .equal {
                self.dot = false
                let runningValue = self.runningNumber
                let currentValue = Float(self.value) ?? 0
                
                self.firstword = false
                self.dot = false
                
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }

            if button != .equal {
                self.value = ""
            }
        case .clear:
            self.value = "0"
            self.firstword = true
            self.dot = false
        case .decimal:
            if dot == false {
                self.value = "\(value)."
            }
            self.dot = true
        case .negative, .percent:
            showingPopover = true
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
            
        }
            
    }
       
    func buttonWidth(item: CalcButton) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if item == .zero {
                return 174.0
            }
            if item == .negative {
                return 174.0
            }
            return 85.5
        } else {
            if item == .zero {
                return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
            }
            if item == .negative {
                return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
            }
            return (UIScreen.main.bounds.width - (5*12)) / 4
        }
        
        
    }

    func buttonHeight() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 85.5
        } else {
            return (UIScreen.main.bounds.width - (5*12)) / 4
        }
    }

}


struct DebugdataView: View {
    var value: String
    var runningNumber: Float
    var showingPopover: Bool
    var firstword: Bool
    var dot: Bool
    var notifications: String
    var cleanvalue: String
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Spacer()
                    Image("iconapp")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                        .cornerRadius(25)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("GoodCalculator")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Text("value: \(value)")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text("runningNumber: \(runningNumber)")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text("showingPopover: \(String(showingPopover))")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text("firstword: \(String(firstword))")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text("dot: \(String(dot))")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text("notifications: \(notifications)")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text("cleanvalue: \(cleanvalue)")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
            }
            .navigationTitle("Debug Data")
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
