package org.hyperskill.app.android

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import org.hyperskill.app.calculator.CalculatorCore

class CalculatorActivity : AppCompatActivity() {

    private val calculatorCore = CalculatorCore()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_calculator)
    }
}