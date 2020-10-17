#region Load the Assemblies
Add-Type -assemblyName PresentationFramework
Add-Type -assemblyName PresentationCore
Add-Type -assemblyName WindowsBase
#endregion

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window"
    Background="#080957"
        Title="PopulateEnv" Height="500.667" Width="434.095">
    <Grid>
    <Image Source="C:\Users\Dilan2814\Downloads\HatchfulExport-All\test.png" HorizontalAlignment="Left" Height="100" Margin="89,10,0,0" VerticalAlignment="Top" Width="263"/>
    <TextBox HorizontalAlignment="Left" Height="23" Margin="33,196,0,0" TextWrapping="Wrap" Text="Path to .Env File" VerticalAlignment="Top" Width="120"/>
    <TextBlock HorizontalAlignment="Left" Margin="44,110,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Height="66" Width="351" Foreground="#FFDBDBEB"><Run Text="populate env works like this:: ...."/><LineBreak/><Run Text="bla bla"/><LineBreak/><Run Text="fdfdf"/></TextBlock>

    <TabControl Name="Tabs1" TabStripPlacement="Top" Background="#FF7577CD" BorderBrush="Blue" Margin="10,176,10,10">

        <TabItem Header="Populate Env" IsSelected="True" Background="#FF5E60A4">
            <Grid>
                <TextBlock TextAlignment="Center" VerticalAlignment="Center" HorizontalAlignment="Center" Margin="10,10,0,159" TextWrapping="Wrap" Height="87" Width="370" Foreground="#FF080957" Text="test"/>
                <TextBox Height="23" TextWrapping="Wrap" Text="Choose Env File" Width="120" Margin="10,119,270,114" />
                <TextBox Height="23" TextWrapping="Wrap" Text="Database Connection" Width="120" Margin="10,189,270,44" />
                <TextBox Height="23" TextWrapping="Wrap" Text="Project Name" Width="120" Margin="10,154,270,79" />
                <Button Name="Select" Content="Select File" Margin="299,115,10,115"/>
                <Button Name="Populate" Content="Populate" Margin="299,203,10,10"/>
            </Grid>

        </TabItem>

        <TabItem Header="Get Started" Background="#FF5E60A4">
            <ComboBox Name="ComboBox1" IsEditable="True" IsReadOnly="True" Text="Select Database" Width="167" Height="26" VerticalAlignment="Top" HorizontalAlignment="Left" Margin="10,10,0,0">
                <ComboBoxItem Content="MySQL"></ComboBoxItem>
                <ComboBoxItem Content="MSSQL"></ComboBoxItem>
                <ComboBoxItem Content="Oracle"></ComboBoxItem>
                <ComboBoxItem Content="PostGreSQL"></ComboBoxItem>
                <ComboBoxItem Content="MariahDB"></ComboBoxItem>
                <ComboBoxItem Content="MongoDB"></ComboBoxItem>
                <ComboBoxItem Content="CosmoDB"></ComboBoxItem>
                <ComboBoxItem Content="DB2"></ComboBoxItem>
            </ComboBox>

        </TabItem>

        <TabItem Header="Info" Background="#FF5E60A4">
        </TabItem>
    </TabControl>
</Grid>
</Window>
"@

#$currentDir = Get-Location
# "$($currentDir.Path)\PopulateEnv.ico"})

try {
    $Window.add_Loaded({
    $Window.Icon = "C:\Users\Dilan2814\Documents\GitHub\PopulateEnvFile\A.ico"})
} catch {
    Write-Host "$($currentDir.Path)\PopulateEnv.ico"
    Write-Host "Error"
}

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$window.ShowDialog()