. "C:\Scripts-New\FileShare\FileShare.ps1"
. "C:\Scripts-New\ActiveDirectory\Users and Groups\Add-Group\CreateGroup.ps1"
. "\\helpdesk\e$\Scripts\PSH\XL2CSV.ps1"

Function New-FileShare {
    <#
    .SYNOPSIS
    Create FileShare on AD.
    .DESCRIPTION
    Author - Adam Clarke
    Date - 2016/04/14
    Script Description - Create a fileshare with or without security groups.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [String]$Csv,
        [Parameter()]
        [Boolean]$Group
    )

    # Is file CSV????
    $CheckCsv = Get-ChildItem $Csv | ? {$_.Extension -eq '.csv'}

    if ($CheckCsv -eq $Null){
        ExcelToCSV -File $Csv
        $Csv = $Csv.Replace('.xlsx','.csv')
    }

    # If a group for file share was selected.
    if ($Group -eq $true){
        Create-Group -csv $Csv
    }
    # Elseif group option is null (was not set).
    elseif ($Group -eq $null){
        echo "No group option specified."
    }
    # If the group option was set to $false.    
    else {
        echo "Not adding groups."
    }

    Create-FileShare -csv $Csv
}
