Function ExcelToCSV {
    <#
    .SYNOPSIS
    Convert xlsx into a csv.
    .DESCRIPTION
    Author - Adam Clarke
    Date - 2016/04/14
    Script Description - Takes an .xlsx file and converts into csv.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [String]$File
    )

    $Excel = New-Object -ComObject Excel.Application
    $Excel.Visible = $false
    $Excel.DisplayAlerts = $false
    $wb = $Excel.Workbooks.Open($File)
    foreach ($ws in $wb.Worksheets)
    {
        $File = $File.Replace('.xlsx','')
        $ws.SaveAs($File + ".csv", 6)
    }
    $Excel.Quit()
}
