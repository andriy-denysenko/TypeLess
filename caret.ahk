; The current A_CaretX value
global $CurrentCaretX := 0

; The previous A_CaretX value
global $PreviousCaretX := 0

; The current A_CaretY value
global $CurrentCaretY := 0

; The previous A_CaretY value
global $PreviousCaretY := 0

IsCaretMoved()
{
	return ($CurrentCaretX <> $PreviousCaretX or $CurrentCaretY <> $PreviousCaretY)
}