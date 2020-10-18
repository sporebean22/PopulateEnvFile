[CmdletBinding()]
param
(
    [Parameter(Mandatory=$true)][string]$envFilePath,
    [Parameter(Mandatory=$true)][string]$projectName,
    [Parameter(Mandatory=$true)][string]$connectionString
)

$currentDir = Get-Location
Clear-Content $envFilePath

[void][System.Reflection.Assembly]::LoadFrom($currentDir.Path + "\MySql.Data.dll");
function GetEnvData() 
{
    $myconnection = New-Object MySql.Data.MySqlClient.MySqlConnection;
    $myconnection.ConnectionString = $connectionString;
    $Query="SELECT * FROM sql2323722.ENVCONFIGURATION where Project = '$($projectName)';";

    [System.Collections.ArrayList]$ArrayList = @()
    
    $myconnection.Open()    
    
    $mycommand = New-Object MySql.Data.MySqlClient.MySqlCommand        
    $mycommand.Connection = $myconnection
    $mycommand.CommandText = $Query
    $myreader = $mycommand.ExecuteReader()

    while($myreader.Read())
    {
        $ArrayList.Add("$($myreader.GetString(2))=$($myreader.GetString(3))");
    }
    
    $myconnection.Close()

    Clear-Content $envFilePath
    Add-Content -Path $envFilePath -Value $ArrayList
}

if(($projectName -eq "WebEMDR-Node.js") -or ($projectName -eq "Ecommerce-Laravel")) {
    GetEnvData
} else {
    throw "The ProjectName $($projectName) is not supported with this Powershell Script."; 
} if(!(Test-Path -Path $envFilePath)) {
    throw "The FilePath $($envFilePath) is Invalid."
}

#[Parameter(Mandatory=$true)][string]$connectionString
#$myconnection.ConnectionString = $connectionString