<powershell>
$folder    = "c:\temp"
$logfile   = "UserData.log"
$awscliurl = "https://awscli.amazonaws.com/AWSCLIV2.msi"
$dmscurl   = "https://cnam-qwerty-01.s3.amazonaws.com/dms/AWS_DMS_Collector_Installer_1.4.1.msi"    

if(!(test-path -Path "${folder}"))
        {    
            New-Item -ItemType directory -Path "${folder}"
    }

## AWSCLI
msiexec.exe /i $awscliurl /quiet /LEI "c:\temp\AWSCLI.log"
Start-Sleep -Seconds 60

## DMS Collector
msiexec.exe /i $dmscurl /quiet /LEI "c:\temp\DMSCollector.log"
</powershell>