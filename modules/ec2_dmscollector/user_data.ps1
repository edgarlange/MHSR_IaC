<powershell>

write-host "running init script"
if(!(test-path -Path "c:\temp"))
    {    
        New-Item -ItemType directory -Path "C:\temp"
        write-host "created temp directory"
    }
## AWSCLI
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn

</powershell>