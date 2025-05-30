@echo off
echo Removendo filtros de rede Wi-Fi...
netsh wlan delete filter permission=denyall networktype=infrastructure
netsh wlan delete filter permission=allow ssid="REDE-XPTO" networktype=infrastructure
echo ✅ Filtros removidos. Agora todas as redes estão liberadas.
pause
