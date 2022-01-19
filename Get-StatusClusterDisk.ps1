Param(
[string]$DESCOBERTA,
[string]$DISCO
)
Import-Module FailoverClusters

# Descoberta em LLD
if ( $DESCOBERTA -eq 'DISCOVERY' )
{
$comando = (Get-ClusterResource | Where-Object {$_.Name -like "GED*"})
$count = 1
write-host "{"
write-host " `"data`":[`n"
foreach ($listao in $comando)
{
if ($count -lt $comando.Count)

{
$line= "{ `"{#CLUSTER}`":`"" + $listao.Name + "`" },"
write-host $line
}
elseif ($count -ge $comando.Count)
{
$line= "{ `"{#CLUSTER}`":`"" + $listao.Name + "`" }"
write-host $line
}
$count++;
}
write-host
write-host " ]"
write-host "}"
}

##FUNÇÃO PARA COLETAR O STATUS DO DISCO
if ($DESCOBERTA -eq 'STATUS'){
Import-Module FailoverClusters
$task = Get-ClusterResource | where {$_.name -eq "$DISCO"} | Select-Object -ExpandProperty state
$task1 = $task
$task2 = "$task1".replace('Offline','0').replace('Online','1').replace('Failed','2').replace('Pending','3')
Write-Output ($task2)
}
