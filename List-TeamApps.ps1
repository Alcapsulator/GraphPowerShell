<#
    .SYNOPSIS
    Query all installed apps in a team.
 
    .DESCRIPTION
    This script lists all installed applications in a MS Team. The data is queried via GraphAPi.

    .NOTES
    File Name : list-teamapps.ps1
    Author    : pascal@rimark.de
    Requires  : PowerShell Version 5.1
    
    .LINK
    To provide feedback or for further assistance email:
    pascal@rimark.de

    .PARAMETER LogMsg
    Specify the Bearer Token to authentificate at GraphAPI
    String

    .PARAMETER groupid
    Specify the GroupId
    String 

    .EXAMPLE
    List-TeamApps {YourToken} {YourGroupId}
#>


function List-TeamApps() {
    param
    (
        [Parameter(Mandatory=$True)]
        [string]$token,
	
	    [Parameter(Mandatory=$True)]
        [string]$groupid
   
    )
    $btoken = $token.replace("`n", "")
    $api = @"
    https://graph.microsoft.com/v1.0/teams/GROUPID/installedApps?`$expand=teamsAppDefinition
"@
    $apicall = $api.Replace("GROUPID",$groupid)
    $apps = Invoke-WebRequest -Method GET -Uri $apicall -Headers @{Authorization="Bearer $btoken"} -UseBasicParsing -ContentType "application/json"
    $inner = $apps.Content | ConvertFrom-Json
    ($inner.Value).teamsAppDefinition
}
