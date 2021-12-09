; 全局互换 Control 和 CapsLock
; +Ctrl::CapsLock
; CapsLock::Ctrl

; #UseHook
; #InstallMouseHook
; 在搜狗输入法中开启 Emacs 的方向键
#IfWinExist ahk_class SoPY_Comp
Control & b::Send {Left}
Control & f::Send {Right}
Control & p::Send {,}
Control & n::Send {.}
#IfWinExist
