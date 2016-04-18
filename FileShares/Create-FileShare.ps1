Function Create-FileShare {
    <#
    .SYNOPSIS
    Create FileShare.
    .DESCRIPTION
    Author - Adam Clarke
    Date - 2016/04/14
    Script Description - Create a basic fileshare.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [String]$Csv
    )

    $ImportedCsv = Import-Csv $Csv

    New-Item -ItemType Directory -Name $_.RootDirectory

    Set-Location $_.RootDirectory

    $csv | ForEach-Object {
        # Set user variable.
        $Group = $_.Group

        # Create the folders.
        New-Item -ItemType Directory -Name $_.ShareName

        # Set the permissions for User
        $acl = Get-Acl $_.ShareName 
        $arg = New-Object System.Security.AccessControl.FileSystemAccessRule("gvas\$Group","FullControl","ContainerInherit, ObjectInherit","None","Allow")
        $acl.SetAccessRule($arg)
        Set-Acl $_.ShareName $acl

        # Set domain admin permissions

        $acl = Get-Acl $_.ShareName # Set the permissions
        $arg = New-Object System.Security.AccessControl.FileSystemAccessRule("gvas\Domain Admins","FullControl","ContainerInherit, ObjectInherit","None","Allow")
        $acl.SetAccessRule($arg)
        Set-Acl $_.ShareName $acl

        # Share the folder.
        New-SmbShare -Name $_.ShareName -Path $_.SharePath -FullAccess $Group,'Domain Admins' 
    }
}
