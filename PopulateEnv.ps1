[CmdletBinding()]
param
(
    [Parameter(Mandatory=$true)][string]$envFilePath,
    [Parameter(Mandatory=$true)][string]$projectName
    #[Parameter(Mandatory=$true)][string]$connectionString
)

if(($projectName != "WebEMDR-Node.js") || ($projectName != "Ecommerce-Laravel")) {
    throw "The ProjectName $($projectName) is not supported with this Powershell Script."; 
} if(!(Test-Path -Path $envFilePath)) {
    throw "The FilePath $($envFilePath) is Invalid."
}

[void][System.Reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.21\Assemblies\v4.5.2\MySql.Data.dll");

$myconnection = New-Object MySql.Data.MySqlClient.MySqlConnection;
$myconnection.ConnectionString = "server=sql2.freesqldatabase.com;user id=sql2323722;password=pR7!tG9*;database=sql2323722;pooling=false";

$Query="SELECT * FROM sql2323722.ENVCONFIGURATION where Project = '$($projectName)';";

function PopulateConfiguration() {
    PopulateEnv(GetEnvData)
} if ($projectName = "WebEMDR-Node.js") { 
    PopulateEnv(GetEnvData)
} else {
    throw "The ProjectName $($projectName) is not supported with this Powershell Script";
}

function PopulateEnv([System.Collections.ArrayList]$array) 
{
    Add-Content -Path $envFilePath -Value $array
}

function GetEnvData() 
{
    [System.Collections.ArrayList]$ArrayList = @()
    
    $myconnection.Open()
    
    if($myconnection.State.ToString() != 'Open') {
      throw "Invalid Connection State, Expected Connection state to be Open but 
             found $($myconnection.State.ToString())"; }
    
    $mycommand = New-Object MySql.Data.MySqlClient.MySqlCommand        
    $mycommand.Connection = $myconnection
    $mycommand.CommandText = $Query
    $myreader = $mycommand.ExecuteReader()

    while($myreader.Read())
    {
        $ArrayList.Add("$($myreader.GetString(2))=$($myreader.GetString(3))");
    }
    
    $myconnection.Close()

    echo $ArrayList
    return $ArrayList
}
