@echo off
color 02 
echo ��ѡ��Ҫִ�еĲ�����1-ɾ�����С��ͷ��2-�ָ����С��ͷ��3-�˳���
set choice=
set /p choice=��ѡ��1/2/3�����س�ִ�У�
if /i '%choice%'=='1' goto a
if /i '%choice%'=='2' goto b
if /i '%choice%'=='3' goto end

:a
ECHO. ============================
ECHO. ȥ��Ӧ�ó����ݷ�ʽͼ���ͷ
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
ECHO. �ָ�Ӧ�ó����ݷ�ʽͼ���ͷ
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