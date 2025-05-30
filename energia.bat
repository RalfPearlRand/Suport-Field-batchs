# Executar como Administrador
Write-Host "Ajustando potência máxima para USB..."

# Desativar suspensão seletiva de USB no plano de energia atual
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0
powercfg -change -disk-timeout-ac 0
powercfg -change -usb-selective-suspend OFF

Write-Host "Configurações de energia USB alteradas com sucesso!"

# Recarregar drivers USB para garantir máxima potência
$devices = Get-PnpDevice | Where-Object { $_.FriendlyName -like "*USB*Root*Hub*" }
foreach ($device in $devices) {
    Write-Host "Reiniciando" $device.FriendlyName
    Disable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false
    Start-Sleep -Seconds 2
    Enable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false
}

Write-Host "Máxima potência aplicada às portas USB!"
