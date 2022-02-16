package org.hyperskill.app.calculator

import com.github.h0tk3y.betterParse.grammar.parseToEnd
import com.github.h0tk3y.betterParse.parser.ParseException
import kotlin.native.concurrent.ThreadLocal

class CalculatorCore {

    @ThreadLocal
    companion object {
        private var history = mutableListOf<String>()

    }
    fun evaluate(expr: String): Double?{
        return try {
            val res = ArithmeticsEvaluator().parseToEnd(expr)
            history.add("$expr=$res")
            res
        } catch (e: ParseException) {
            null
        }
    }

    fun getHistory(): List<String> = history
}

