@echo off
for /r C:\Users\tabuyos\Home\gitrepository\jizura-fonts\fonts %%a in (*.otf) do (
copy "%%a" C:\Users\tabuyos\Home\gitrepository\jizura-fonts\all-fonts
)