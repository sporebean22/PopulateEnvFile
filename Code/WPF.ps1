Add-Type -assemblyName PresentationFramework
Add-Type -assemblyName PresentationCore
Add-Type -assemblyName WindowsBase

[xml]$xaml = Get-Content "WPF.xml"

$currentDir = Get-Location
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]") | ForEach-Object{
    Set-Variable -Name ($_.Name) -Value $window.FindName($_.Name)
}

try {
    $window.add_Loaded({
    $window.Icon = "$($currentDir.Path)\PopulateEnv.ico"})
} catch {
    Write-Host "Error the Icon path is incorrect: $($currentDir.Path)\PopulateEnv.ico"
}

$async = $window.Dispatcher.InvokeAsync({
    $window.ShowDialog() | Out-Null
})

$async.Wait() | Out-Null
