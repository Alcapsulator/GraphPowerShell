function List-TeamApps($bearertoken, $groupid) {
    $api = @"
    https://graph.microsoft.com/v1.0/teams/GROUPID/installedApps?`$expand=teamsAppDefinition
"@
    $apicall = $api.Replace("GROUPID",$groupid)
    $apps = Invoke-WebRequest -Method GET -Uri $apicall -Headers @{Authorization="Bearer $bearertoken"} -UseBasicParsing -ContentType "application/json"
    $inner = $apps.Content | ConvertFrom-Json
    ($inner.Value).teamsAppDefinition
}

List-TeamApps $btoken 37aae96d-8de5-4eb4-824b-f0627ace6702