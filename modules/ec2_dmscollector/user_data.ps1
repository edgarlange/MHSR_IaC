<powershell>

write-host "running init script"
if(!(test-path -Path "c:\temp"))
    {    
        New-Item -ItemType directory -Path "C:\temp"
        write-host "created temp directory"
    }
## AWSCLI
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn

## DMS Collector
$URL1 = "https://cnam-qwerty-01.s3.amazonaws.com/dms/AWS_DMS_Collector_Installer_1.4.1.msi"
$Path1 = "c:\temp\AWS_DMS_Collector_Installer_1.4.1.msi"
Invoke-WebRequest -URI $URL1 -OutFile $Path1

</powershell>