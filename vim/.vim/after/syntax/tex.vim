if has('conceal')
  syn match texMathSymbol '\\dotsc\>' contained conceal cchar=…
  syn match texMathSymbol '\\C\>' contained conceal cchar=ℂ
  syn match texMathSymbol '\\E\>' contained conceal cchar=𝔼
  syn match texMathSymbol '\\N\>' contained conceal cchar=ℕ
  syn match texMathSymbol '\\prob\>' contained conceal cchar=ℙ
  syn match texMathSymbol '\\Q\>' contained conceal cchar=ℚ
  syn match texMathSymbol '\\R\>' contained conceal cchar=ℝ
  syn match texMathSymbol '\\Z\>' contained conceal cchar=ℤ
  syn match texMathSymbol '\\varnothing\>' contained conceal cchar=∅
endif
