@echo off
echo Desativando atualizações automáticas do Google Chrome...

:: Desativar os serviços do Google Update
sc config gupdate start= disabled
sc config gupdatem start= disabled
net stop gupdate
net stop gupdatem

:: Desativar atualizações no Registro
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update" /v "AutoUpdateCheckPeriodMinutes" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Google\Update" /v "AutoUpdateCheckPeriodMinutes" /t REG_DWORD /d 0 /f

:: Desativar Tarefas do Google Update no Agendador de Tarefas
schtasks /change /tn "GoogleUpdateTaskMachineUA" /disable
schtasks /change /tn "GoogleUpdateTaskMachineCore" /disable

echo.
echo Atualizações automáticas do Google Chrome foram desativadas.
echo Reinicie o computador para aplicar as mudanças.
pause
