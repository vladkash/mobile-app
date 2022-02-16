//
//  CalculatorView.swift
//  iosHyperskillApp
//
//  Created by Ruslan Davletshin on 31.01.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import shared

//import Foundation

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
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case leftBracket = "("
    case rightBracket = ")"
}

struct CalculatorView: View {

    let calculatorCore = CalculatorCore()

    @State var value = ""

    @State var showAlert = false

    let buttons: [[CalcButton]] = [
        [.clear, .leftBracket, .rightBracket, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            TabView {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Text(value)
                                .bold()
                                .font(.system(size: 50))
                    }
                            .padding()

                    Spacer()

                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { item in
                                Button(action: { didTap(button: item) }, label: {
                                    Text(item.rawValue)
                                            .font(.system(size: 32))
                                            .frame(
                                                    width: buttonWidth(item: item),
                                                    height: buttonHeight()
                                            )
                                            .background(Color(.black))
                                            .foregroundColor(.white)
                                            .cornerRadius(buttonHeight() / 2)
                                            .onTapGesture {
                                                self.didTap(button: item)
                                            }
                                            .onLongPressGesture(minimumDuration: 1) {
                                                self.didLongPress(button: item)
                                            }

                                })

                            }
                        }
                                .padding(.bottom, 3)

                    }
                }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Ошибка"), message: Text("Проверьте правильность выражения"), dismissButton: .default(Text("Ок")))
                        }.tabItem( {
                            Image(systemName: "list.bullet")
                            Text("Calculate")
                        })
                List(calculatorCore.getHistory(), id: \.self.hashValue) { expr in
                    Text(expr)
                }.tabItem( {
                        Image(systemName: "clock.fill")
                        Text("History")
                    })
            }

        }
    }

    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return buttonHeight()
    }

    func buttonHeight() -> CGFloat {
        (UIScreen.main.bounds.width - (5 * 12)) / 4
    }

    func didTap(button: CalcButton) {
        switch button {
        case .clear:
            self.value = String(value.dropLast())
        case .equal:
            let res = calculatorCore.evaluate(expr: value)
            if (res != nil) {
                value = res!.stringValue
            } else {
                showAlert = true
            }
        default:
            self.value += button.rawValue
        }
    }

    func didLongPress(button: CalcButton) {
        switch button {
        case .clear:
            self.value = ""
        default:
            break
        }
    }
}

class CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
    // это для того, чтобы работал hot reloading при разработке
    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: CalculatorView())
    }
    #endif
}
