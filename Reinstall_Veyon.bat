@echo off
title Instalador Veyon 4.9.2 (Apenas Cliente)
echo ===========================================
echo     Desinstalando Veyon Client (se existir)...
echo ===========================================
wmic product where "name='Veyon'" call uninstall /nointeractive
timeout /t 5 /nobreak >nul

echo ===========================================
echo     Instalando Veyon 4.9.2 (somente Client)...
echo ===========================================
set PENDRIVE=D:\
set VEYON_INSTALLER=%PENDRIVE%\Veyon-4.9.2.0-win64-setup.exe
set PUBLIC_KEY=%PENDRIVE%\LABXX_public_key.pem
set PUBLIC_KEY_DEST=C:\ProgramData\Veyon\keys\public\chave_publica.pem

if not exist "%VEYON_INSTALLER%" (
    echo ERRO: Instalador do Veyon não encontrado no pendrive!
    pause
    exit
)

:: Instala apenas os componentes necessários para o Client
"%VEYON_INSTALLER%" /S /Components=Client

timeout /t 10 /nobreak >nul

echo ===========================================
echo     Copiando chave pública...
echo ===========================================
if not exist "C:\ProgramData\Veyon\keys\public" (
    mkdir "C:\ProgramData\Veyon\keys\public"
)

copy "%PUBLIC_KEY%" "%PUBLIC_KEY_DEST%" /Y
if %errorlevel% neq 0 (
    echo ERRO ao copiar a chave pública!
    pause
    exit
)

echo ===========================================
echo     Configurando autenticação...
echo ===========================================
"C:\Program Files\Veyon\bin\veyon-cli.exe" authkeys import public chave_publica.pem
"C:\Program Files\Veyon\bin\veyon-cli.exe" config set AuthenticationMethod KeyFile

echo ===========================================
echo     Reiniciando o serviço do Veyon...
echo ===========================================
net stop VeyonService
net start VeyonService

echo ===========================================
echo  INSTALAÇÃO DO CLIENTE CONCLUÍDA COM SUCESSO!
echo ===========================================
pause
