@echo off

set DIR_ORIGEM=C:\Users


for /f "tokens=*" %%x in ('dir /b %DIR_ORIGEM%') do (
	
	IF NOT "%%x"=="Administrador" IF NOT "%%x"=="Default" IF NOT "%%x"=="Default User" IF NOT "%%x"=="All Users" IF NOT "%%x"=="Usu�rio Padr�o" IF NOT "%%x"=="Todos os Usu�rios" IF NOT "%%x"=="Public" IF NOT "%%x"=="MSSQL$SQLEXPRESS" IF NOT "%%x"=="MSSQL$SQLEXPRESS.NT Service" rd "%DIR_ORIGEM%\%%x" /s /q 

)

regedit