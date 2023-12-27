<powershell>

write-host "running init script"
if(!(test-path -Path "c:\temp"))
    {    
        New-Item -ItemType directory -Path "C:\temp"
        write-host "created temp directory"
    }
## AWSCLI
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn

## DotNet 6.0
$URL1 = "https://download.visualstudio.microsoft.com/download/pr/81531ad6-afa9-4b61-9d05-6a76dce81123/2885d26c1a58f37176fd7859f8cc80f1/dotnet-sdk-6.0.417-win-x64.exe"
$Path1 = "c:\temp\dotnet-sdk-6.0.417-win-x64.exe"
Invoke-WebRequest -URI $URL1 -OutFile $Path1
# Start-BitsTransfer -Source $URL1 -Destination $Path1
# (New-Object System.Net.WebClient).DownloadFile ($URL1, $Path1)
c:/temp/dotnet-sdk-6.0.417-win-x64.exe /install /quiet /norestart

## Porting Assistant
$URL2 = “https://s3.us-west-2.amazonaws.com/aws.portingassistant.dotnet.download/latest/windows/Porting-Assistant-Dotnet.exe”
$Path2 = "c:\temp\Porting-Assistant-Dotnet.exe"
Invoke-WebRequest -URI $URL2 -OutFile $Path2
# Start-BitsTransfer -Source $URL2 -Destination $Path2
# (New-Object System.Net.WebClient).DownloadFile ($URL2, $Path2)

</powershell>