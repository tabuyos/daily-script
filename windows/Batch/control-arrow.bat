@echo off
color 02 
echo 请选择要执行的操作（1-删除快捷小箭头，2-恢复快捷小箭头，3-退出）
set choice=
set /p choice=请选择（1/2/3）按回车执行：
if /i '%choice%'=='1' goto a
if /i '%choice%'=='2' goto b
if /i '%choice%'=='3' goto end

:a
ECHO. ============================
ECHO. 去除应用程序快捷方式图标箭头
ECHO. ============================
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
taskkill /f /im explorer.exe
attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db"
del "%userprofile%\AppData\Local\iconcache.db" /f /q
start explorer
pause
exit

:b
ECHO. ============================
ECHO. 恢复应用程序快捷方式图标箭头
ECHO. ============================
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f
taskkill /f /im explorer.exe
attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db"
del "%userprofile%\AppData\Local\iconcache.db" /f /q
start explorer
pause
exit

:end
exit