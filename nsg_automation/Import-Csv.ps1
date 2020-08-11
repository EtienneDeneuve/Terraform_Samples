
[CmdletBinding()]
param(
    $csvSource
)
$listCsvs = Get-ChildItem "$($PSScriptRoot)/$($csvSource)"
foreach ($csv in $listCsvs) {

    $rules = Import-Csv $($csv.FullName) -Encoding utf8

    $ipPattern = "^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}/[0-9][0-9]$"
    $portPattern = "^(0|[1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$"
    $wordPattern = "[A-Za-z]"
    foreach ($rule in $rules) {
        $SourceAddressPrefixes = $DestinationAddressPrefixes = $source_port_ranges = $destination_port_ranges = $false

        switch ($rule) {
            { $rule.SourcePortRange.ToCharArray() -contains '*' } { $source_port_ranges = $false }
            { $rule.SourcePortRange.ToCharArray() -contains ',' } { $source_port_ranges = $true }
            { $rule.SourcePortRange -match $portPattern } { $source_port_ranges = $false }
            { $rule.SourcePortRange -match $wordPattern } { $source_port_ranges = $true }
            { $rule.DestinationPortRange.ToCharArray() -contains '*' } { $destination_port_ranges = $false }
            { $rule.DestinationPortRange.ToCharArray() -contains ',' } { $destination_port_ranges = $true }
            { $rule.DestinationPortRange -match $portPattern } { $destination_port_ranges = $false }
            { $rule.DestinationPortRange -match $wordPattern } { $destination_port_ranges = $true }
            { $rule.SourceAddressPrefix.ToCharArray() -contains ',' } { $SourceAddressPrefixes = $true }
            { $rule.DestinationPortRange -match $wordPattern } { $SourceAddressPrefixes = $false }
            { $rule.DestinationAddressPrefix.ToCharArray() -contains ',' } { $DestinationAddressPrefixes = $true }
            { $rule.DestinationAddressPrefix -match $wordPattern } { $DestinationAddressPrefixes = $false }
        }

        $array = "$($PSScriptRoot)/csv-name$([int]$source_port_ranges)$([int]$destination_port_ranges)$([int]$SourceAddressPrefixes)$([int]$DestinationAddressPrefixes).csv"
        if (Test-Path $($array)) {
            $rule | export-csv -Path $($array) -Encoding utf8 -Append -NoClobber
        }
        else {
            $rule | export-csv -Path $($array) -Encoding utf8 -NoClobber
        }
    }

}
