syntax match textTagSymbol contained "|" conceal
syntax match textJumpSymbol contained "\*" conceal
syntax match textULSymbol contained "_" conceal

syntax match input "< .*" contains=ALL
syntax match inputA "< A.*" contains=textTag,TextJump,TextUL,inputB,inputC,inputD,inputP
syntax match inputB "< B.*" contains=textTag,TextJump,TextUL,inputA,inputC,inputD,inputP
syntax match inputC "< C.*" contains=textTag,TextJump,TextUL,inputA,inputB,inputD,inputP
syntax match inputD "< D.*" contains=textTag,TextJump,TextUL,inputA,inputB,inputC,inputP
syntax match inputP "< P.*" contains=textTag,TextJump,TextUL,inputA,inputB,inputC,inputD
syntax match heading "-=[^-=]*=-"
syntax match textTag "|[^|]*|" contains=textTagSymbol
syntax match textJump "\*[^\*]*\*" contains=textJumpSymbol
syntax match textUL "_[^_]*_" contains=textULSymbol

highlight link inputA			Character
highlight link inputB			Constant
highlight link inputC			String
highlight link inputD			Function
highlight link inputP			Comment
highlight link input			Label
highlight link textTag			Label
highlight link textJump			Label
highlight link textUL			Underlined
highlight link textTagSymbol	Ignore
highlight link textJumpSymbol	Ignore
highlight link textBoldSymbol	Ignore
highlight link heading			Statement
