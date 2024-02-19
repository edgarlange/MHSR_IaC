<powershell>
if(!(test-path -Path "c:\temp"))
    {    
    New-Item -ItemType directory -Path "c:\temp"
}

## AWSCLI
$URL0 = "https://awscli.amazonaws.com/AWSCLIV2.msi"
msiexec.exe /i $URL0 /quiet /LEI "c:\temp\AWSCLI.log"
Start-Sleep -Seconds 60

## Open JDK 11
$URL1 = "https://cnam-qwerty-01.s3.amazonaws.com/cast/microsoft-jdk-11.0.22-windows-x64.msi"
$Path1 = "c:\temp\microsoft-jdk-11.0.22-windows-x64.msi"
Invoke-WebRequest -URI $URL1 -OutFile $Path1

## CAST Highlight Code Reader
$URL2 = "https://cnam-qwerty-01.s3.amazonaws.com/cast/CastHighlightSetup.exe"
$Path2 = "c:\temp\CastHighlightSetup.exe"
Invoke-WebRequest -URI $URL2 -OutFile $Path2
