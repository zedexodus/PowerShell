Function Create-Group {
    <#
    .SYNOPSIS
    Create Active Directory groups.
    .DESCRIPTION
    Author - Adam Clarke
    Date - 2016/04/14
    Script Description - Create Active Directory Groups based on template and parameters given.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [String]$Csv
    )

    $ImportedCsv = Import-Csv "$Csv"

    $ImportedCsv | ForEach-Object {
        New-ADGroup -Name $_.Name -SamAccountName $_.SamAccountName -DisplayName $_.DisplayName `
        -GroupCategory $_.GroupCategory -GroupScope $_.GroupScope -Description $_.Description `
        -Path $_.OUPath -Verbose -PassThru
     }
}