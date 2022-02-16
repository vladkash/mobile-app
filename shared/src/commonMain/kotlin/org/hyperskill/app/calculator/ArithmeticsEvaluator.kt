package org.hyperskill.app.calculator

import com.github.h0tk3y.betterParse.combinators.*
import com.github.h0tk3y.betterParse.grammar.Grammar
import com.github.h0tk3y.betterParse.grammar.parser
import com.github.h0tk3y.betterParse.lexer.literalToken
import com.github.h0tk3y.betterParse.lexer.regexToken
import com.github.h0tk3y.betterParse.parser.Parser
import kotlin.math.pow

class ArithmeticsEvaluator : Grammar<Double>() {
    private val num by regexToken("[0-9]+(\\.[0-9]+)?")
    private val lpar by literalToken("(")
    private val rpar by literalToken(")")
    private val mul by literalToken("*")
    private val pow by literalToken("^")
    val div by literalToken("/")
    val minus by literalToken("-")
    val plus by literalToken("+")

    private val number by num use { text.toDouble() }
    private val term: Parser<Double> by number or
            (skip(minus) and parser(::term) map { -it }) or
            (skip(lpar) and parser(::rootParser) and skip(rpar))

    private val powChain by leftAssociative(term, pow) { a, _, b -> a.pow(b) }

    private val divMulChain by leftAssociative(powChain, div or mul use { type }) { a, op, b ->
        if (op == div) a / b else a * b
    }

    private val subSumChain by leftAssociative(divMulChain, plus or minus use { type }) { a, op, b ->
        if (op == plus) a + b else a - b
    }

    override val rootParser: Parser<Double> by subSumChain
}