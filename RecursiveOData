# This function provides a recursive method to process Graph-API responses that contain more than 100 objects. 
# One response of the graph API is limited to 100 objects. If more than 100 objects are returned in the response, the Graph API sends an @odata.nextLink field in the response. 
# This field contains a link that in turn contains the next 100 objects of the query and so on.

# This function shows the example of all teams of a tenant.
# A total of 228 teams are found. This means that the answer contains only the first 100 objects.
# The field @odata.nextlink is also sent. This is again sent to the Graph-API by means of a recursive function.
# As an answer we get the remaining objects

function Recursive_OData([string]$url,[string]$token, [array]$teams) {
    try {
        # Graph API Call (note this is the beta endpoint)
        $req = Invoke-WebRequest -Method GET -Uri $url -ContentType "application/x-www-form-urlencoded" -Headers @{Authorization="Bearer $token"} -UseBasicParsing

        # Get the @odata.nextLink value and save it to a variable
        $nextLink = ($req.Content | ConvertFrom-Json).'@odata.nextLink'

        # Get the answer in the value field and store it into a array
        $teams += ($req.Content | ConvertFrom-Json).value

        # check if the nextLink variable is emtpy. 
        # If so then return the results which are already stored in the $teams-array
        # Else call itself but now with the @odata.nextLink-Link and the already filled array with objects.
        # At the next run the results will be attached into the existing array.
        if(!$nextLink) {
            return $teams
        } else {
            GetTenantTeams $nextLink $token $teams
        }
    } catch {
        echo $_.Exception.Message
    }
}

#IMPORTANT Empty this array before you call the recursive method. Otherwise there will be an error. 
$groups = @()
# Call this Function
# Note use a token string as $btoken
$groups = GetTenantTeams "https://graph.microsoft.com/beta/groups?`$filter=resourceProvisioningOptions/Any(x:x eq 'Team')" $btoken $groups

# This is just one example of a possible approach 
