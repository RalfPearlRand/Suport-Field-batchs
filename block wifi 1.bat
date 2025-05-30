@echo off
setlocal

set NOME_REDE=REDE-XPTO

echo.
echo Bloqueando todas as redes Wi-Fi exceto: %NOME_REDE%
echo.

REM Bloqueia todas as redes Wi-Fi
netsh wlan add filter permission=denyall networktype=infrastructure

REM Permite somente a rede especificada
netsh wlan add filter permission=allow ssid="%NOME_REDE%" networktype=infrastructure

echo.
echo ? Apenas a rede "%NOME_REDE%" está autorizada. Trocas de Wi-Fi estão bloqueadas.
pause
