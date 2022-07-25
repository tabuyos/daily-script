# --------------------------------------------------------
# -- define parameter block
# --------------------------------------------------------

param($generate_package)

# --------------------------------------------------------
# -- define variable block
# --------------------------------------------------------

$dependencies_path = "dependencies.libary"
$destination_distribution_path = "distribution"
$original_distribution_path = "easydatasky-server/target/dist"
$original_libary_path = "$original_distribution_path/lib/"
$destination_libary_path = "$destination_distribution_path/lib/"
$dependencies_table = @{}
$boot_jar_name = "easydatasky-server.jar"

# --------------------------------------------------------
# -- define function block
# --------------------------------------------------------

Function Quit()
{
    Write-Host "about to exit..."
    Start-Sleep -Seconds 3
    exit
}

Function New-Package-Jar()
{
    mvn -U -pl easydatasky-server -am clean package '-Dmaven.test.skip=true'
}

Function New-File($file)
{
    New-Item -Path $file -ItemType File > $null
}

Function New-Folder($folder)
{
    New-Item -Path $folder -ItemType Directory > $null
}

Function Import-Previous-Dependencies()
{
    Write-Host "start to import previous version dependencies, wait a moment please!"
    Foreach($line in Get-Content $dependencies_path) {
        If ($line.Length -gt 0)
        {
            $dependencies_table[$line] = $true
        }
    }
    Write-Host "clear previous version dependencies file"
    Clear-Content $dependencies_path
}

Function Get-Special-Item($path)
{
    Foreach($item in Get-ChildItem -Name -Path $path)
    {
        If ($item -match "\.jar$")
        {
            $item >> $dependencies_path
            If (!($dependencies_table[$item]))
            {
                Copy-Item -Path "$original_libary_path/$item" -Destination "$destination_libary_path/$item" -Force
            }
        }
    }
}

Function Copy-Boot-Jar()
{
    Copy-Item -Path "$original_distribution_path/$boot_jar_name" -Destination "$destination_distribution_path/$boot_jar_name" -Force
}

Function Remove-Distribution-Folder()
{
    Remove-Item $destination_distribution_path -Recurse -Force
}

Function Main()
{
    Write-Host "current path: `n`t $(Get-Location)"

    If ($generate_package)
    {
        Write-Host "delete old distribution verison folder..."
        Remove-Distribution-Folder
        Write-Host "start packaging easydatasky-server..."
        Write-Host "wait a moment, please..."
        New-Package-Jar
    }

    Write-Host "packaged, start generate distribution files..."

    If(!(Test-Path $original_libary_path))
    {
        Write-Host "$original_libary_path not found, exit!"
        Quit
    }

    If (!(Test-Path $dependencies_path))
    {
        Write-Host "$dependencies_path not found, create version dependencies list file."
        Write-Host "initionalize..."
        New-File($dependencies_path)
    }

    If (!(Test-Path $destination_distribution_path))
    {
        Write-Host "$destination_distribution_path not found, create distribution folder."
        New-Folder($destination_libary_path)
    }
    Write-Host "process dependencies..."
    Import-Previous-Dependencies
    Get-Special-Item($original_libary_path)
    Write-Host "copy boot jar to $destination_distribution_path"
    Copy-Boot-Jar
}

# --------------------------------------------------------
# -- entry function block
# --------------------------------------------------------
Main

Write-Host "============================= SUCCESSFUL ============================="
