@echo off
title Rotina de Manutenção - Tabajara
color 0A

echo ========================================
echo   INICIANDO ROTINA DE MANUTENÇÃO
echo ========================================
echo.

:: Copiar e forçar atualização do antivirus
echo Atualizando script antivirus...
mkdir c:\antivirus\ >nul 2>&1
xcopy "\\dominio\Scripts\Update_antivirus.ps1" "C:\antivirus" /Y
powershell.exe -ExecutionPolicy Bypass -File "c:\antivirus\update_antivirus.ps1"

:: Limpar arquivos temporários do usuário
echo Limpando arquivos temporários do usuário...
del /s /f /q "%temp%\*.*"
rd /s /q "%temp%" 2>nul

:: Limpar arquivos temporários dos navegadores (todos os usuários)
echo Limpando cache de navegadores (Chrome e Edge) para todos os usuários...
for /d %%u in ("C:\Users\*") do (
    echo Limpando cache de Chrome e Edge em %%u...
    del /s /f /q "%%u\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*" 2>nul
    del /s /f /q "%%u\AppData\Local\Microsoft\Edge\User Data\Default\Code Cache\*.*" 2>nul
    del /s /f /q "%%u\AppData\Local\Google\Chrome\User Data\Default\Cache\*.*" 2>nul
    del /s /f /q "%%u\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*.*" 2>nul
)

:: Limpeza de Prefetch
echo Limpando arquivos de prefetch...
del /s /f /q "C:\Windows\Prefetch\*.*"

:: Limpeza da Lixeira
echo Limpando lixeira...
for /f "tokens=*" %%i in ('"wmic logicaldisk get name /value | find ":""') do (
    for %%d in (%%i) do (
        rd /s /q %%d\$Recycle.Bin 2>nul
    )
)

:: Verificar integridade do disco
echo Verificando integridade do disco...
chkdsk C: /F

:: Verificar e corrigir arquivos corrompidos do sistema
echo Verificando arquivos do sistema com SFC...
sfc /scannow

:: Otimizar disco (apenas em SSDs com TRIM ou HDs sem desfragmentação agendada)
echo Otimizando disco...
defrag C: /O

:: Atualizar políticas de grupo (opcional)
echo Atualizando políticas de grupo...
gpupdate /force

:: Finalização
echo.
echo ========================================
echo   ROTINA FINALIZADA!
echo ========================================
pause
exit
