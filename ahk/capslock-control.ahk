; ȫ�ֻ��� Control �� CapsLock
; +Ctrl::CapsLock
; CapsLock::Ctrl

; #UseHook
; #InstallMouseHook
; ���ѹ����뷨�п��� Emacs �ķ����
#IfWinExist ahk_class SoPY_Comp
Control & b::Send {Left}
Control & f::Send {Right}
Control & p::Send {,}
Control & n::Send {.}
#IfWinExist
