@echo off
echo ==========================================
echo     Restaurando configuracoes de rede
echo ==========================================
echo.

REM Resetar configurações de IP
echo > Resetando TCP/IP...
netsh int ip reset

REM Resetar Winsock
echo > Resetando Winsock...
netsh winsock reset

REM Resetar configurações de firewall
echo > Resetando Firewall...
netsh advfirewall reset

REM Deletar todos os perfis de Wi-Fi
echo > Deletando perfis de Wi-Fi...
netsh wlan delete profile name=*

REM Liberar e renovar IP
echo > Liberando IP...
ipconfig /release

echo > Renovando IP...
ipconfig /renew

REM Limpar cache DNS
echo > Limpando cache DNS...
ipconfig /flushdns

echo.
echo ==========================================
echo     Processo concluido com sucesso!
echo     O sistema sera reiniciado agora...
echo ==========================================
timeout /t 5 /nobreak >nul

shutdown /r /t 0
