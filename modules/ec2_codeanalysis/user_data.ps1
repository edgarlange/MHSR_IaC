<powershell>
$folder     = "c:\temp"
$logfile    = "UserData.log"
$awscliurl  = "https://awscli.amazonaws.com/AWSCLIV2.msi"
$dotnet6    = "https://download.visualstudio.microsoft.com/download/pr/81531ad6-afa9-4b61-9d05-6a76dce81123/2885d26c1a58f37176fd7859f8cc80f1/dotnet-sdk-6.0.417-win-x64.exe"
$dotnet6exe = "dotnet-sdk-6.0.417-win-x64.exe"
$porting    = "https://s3.us-west-2.amazonaws.com/aws.portingassistant.dotnet.download/latest/windows/Porting-Assistant-Dotnet.exe"
$portingexe = "Porting-Assistant-Dotnet.exe"  
    
if(!(test-path -Path "${folder}"))
    {    
    New-Item -ItemType directory -Path "${folder}"
}

## AWSCLI
$URL0 = "${awscliurl}"
msiexec.exe /i $URL0 /quiet /LEI "c:\temp\AWSCLI.log"
Start-Sleep -Seconds 60

## DotNet 6.0
$URL1 = "${dotnet6}"
$Path1 = "${folder}\${dotnet6exe}"
Invoke-WebRequest -URI $URL1 -OutFile $Path1

## Porting Assistant
$URL2 = "${porting}"
$Path2 = "${folder}/${portingexe}"
Invoke-WebRequest -URI $URL2 -OutFile $Path2
</powershell>