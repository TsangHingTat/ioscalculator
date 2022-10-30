//
//  old.swift
//  Calculator
//
//  Created by TsangHingTat on 29/12/2021.
//


import Foundation
import SwiftUI
import MobileCoreServices

struct ContentView5: View {
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
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
            
        }
        if item == .negative {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView3: View {
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
        if item == .zero {
            return 174.0
        }
        if item == .negative {
            return 174.0
        }
        return 85.5
    }

    func buttonHeight() -> CGFloat {
        return 85.5
    }
}


struct ContentView2: View {
    @State var num: String = ""
    @State var num2: String = ""
    @State var cal: String = ""
    @State var calint: Int = 0
    @State var calint2: Int = 0
    @State var type1: Int = 1
    @State var caling: Int = 0
    @State var call: String = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("debug data :")
                        .font(.largeTitle)
                }
                VStack {
                    Text("num1: \(num)")
                    Text("num2: \(num2)")
                    Text("cal: \(cal)")
                    Text("calint: \(caling)")
                    Text("calint2: \(calint2)")
                    Text("type1: \(type1)")
                    Text("caling: \(caling)")
                    Text("call: \(call)")
                }
            }
            
            if type1 == 1 {
                HStack {
                    Text(" \(num) ")
                }
                Text(" \(caling) ")
                    .font(.largeTitle)
            }
            if type1 == 0 {
                HStack {
                    Text(" \(num2) ")
                }
                Text(" \(caling) ")
                    .font(.largeTitle)
            }
            if type1 == 2 {
                HStack {
                    Text(" \(num) ")
                }
                Text(" \(caling) ")
                    .font(.largeTitle)
            }
            
            
            VStack {
                HStack {
                    Text("N/A")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.num = "Error"
                        self.num2 = "Error"
                    }
                    Text("N/A")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.num = "Error"
                        self.num2 = "Error"
                    }
                    Text("C")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.num = ""
                        self.num2 = ""
                        self.cal = ""
                        self.calint = 0
                        self.calint2 = 0
                        self.type1 = 1
                        self.caling = 0
                        self.call = ""
                        
                    }
                    Text("÷")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.call = "/"
                    }
                    
                }
                HStack {
                    Text("7")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("7")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("7")"
                        }
                    }
                    Text("8")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("8")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("8")"
                        }
                    }
                    Text("9")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("9")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("9")"
                        }
                    }
                    Text("×")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.call = "*"
                    }
                    
                    
                }
                HStack {
                    Text("4")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("4")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("4")"
                        }
                    }
                    Text("5")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("5")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("5")"
                        }
                    }
                    Text("6")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("6")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("6")"
                        }
                    }
                    
                    
                    Text("－")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.call = "-"
                    }
                }
                HStack {
                    Text("1")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("1")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("1")"
                        }
                    }
                    Text("2")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("2")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("2")"
                        }
                    }
                    Text("3")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("3")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("3")"
                        }
                    }
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        
                        if call == "+" {
                            calint = Int(num) ?? 0
                            calint2 = Int(num2) ?? 0
                            caling = calint + calint2
                        }
                        if call == "-" {
                            calint = Int(num) ?? 0
                            calint2 = Int(num2) ?? 0
                            caling = calint - calint2
                        }
                        if call == "*" {
                            calint = Int(num) ?? 0
                            calint2 = Int(num2) ?? 0
                            caling = calint * calint2
                        }
                        if call == "/" {
                            calint = Int(num) ?? 0
                            calint2 = Int(num2) ?? 0
                            caling = calint / calint2
                        }
                        if type1 == 0 {
                            num = ""
                        }
                        if type1 == 0 {
                            type1 = 12
                        } else {
                            if type1 == 1 {
                                type1 = 0
                            } else {
                                if type1 == 2 {
                                    type1 = 1
                                }
                            }
                        }
                        if type1 == 12 {
                            type1 = 1
                        }
                        
                        self.call = "+"
                        
                    }
                    
                }
                HStack {
                    Text("N/A")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.num = "Error"
                        self.num2 = "Error"
                    }
                    
                    Text("0")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.yellow, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        if type1 == 1 {
                            self.num = "\(self.num)\("0")"
                        }
                        if type1 == 0 {
                            self.num2 = "\(self.num2)\("0")"
                        }
                    }
                    
                    
                    Text(".")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.num = "\(self.num)\(".")"
                        self.cal = "\(self.num)\(".")"
                    }
                    
                    Text("=")
                        .font(.largeTitle)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding()
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 10)
                                .frame(width: 60, height: 60)
                            
                        )
                    .onTapGesture {
                        self.num = "Error"
                        self.cal = "Error"
                    }
                }
                
                
            }
            
        }
        
    }
}


