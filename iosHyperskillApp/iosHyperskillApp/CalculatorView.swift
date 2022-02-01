//
//  CalculatorView.swift
//  iosHyperskillApp
//
//  Created by Ruslan Davletshin on 31.01.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import shared

struct CalculatorView: View {
    let calculatorCore = CalculatorCore()
    
    var body: some View {
        Text("Calculator")
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
