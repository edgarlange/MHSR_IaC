<powershell>
if(!(test-path -Path "c:\temp"))
    {    
    New-Item -ItemType directory -Path "c:\temp"
}

## AWSCLI
$URL0 = "https://awscli.amazonaws.com/AWSCLIV2.msi"
msiexec.exe /i $URL0 /quiet /LEI "c:\temp\AWSCLI.log"
Start-Sleep -Seconds 60

## DotNet 6.0
$URL1 = "https://download.visualstudio.microsoft.com/download/pr/81531ad6-afa9-4b61-9d05-6a76dce81123/2885d26c1a58f37176fd7859f8cc80f1/dotnet-sdk-6.0.417-win-x64.exe"
$Path1 = "c:\temp\dotnet-sdk-6.0.417-win-x64.exe"
Invoke-WebRequest -URI $URL1 -OutFile $Path1

## Porting Assistant for .NET
$URL2 = "https://s3.us-west-2.amazonaws.com/aws.portingassistant.dotnet.download/latest/windows/Porting-Assistant-Dotnet.exe"
$Path2 = "c:\temp\Porting-Assistant-Dotnet.exe"
Invoke-WebRequest -URI $URL2 -OutFile $Path2

## Microservice Extractor for .NET
$URL3 = "https://s3.us-west-2.amazonaws.com/aws.serviceextract.download/latest/windows/ServiceExtract.exe"
$Path3 = "c:\temp\ServiceExtract.exe"
Invoke-WebRequest -URI $URL3 -OutFile $Path3

## GIT
$URL4 = "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe"
$Path4 = "c:\temp\Git-2.43.0-64-bit.exe"
Invoke-WebRequest -URI $URL4 -OutFile $Path4

## Visual Studio 2022
$URL5 = "https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2022&source=VSLandingPage&cid=2030:8ba2e2e7033440aca7520ae7345774cc"
$Path5 = "c:\temp\VisualStudioSetup.exe"
Invoke-WebRequest -URI $URL5 -OutFile $Path5
    # Under Workloads, >> ASP.NET and Web Development
    # Under Individual Components:
    # .NET 4.7.1 Targeting Pack
    # SQL Server Express 2019

## WinRm
$URL6 = "https://cnam-qwerty-01.s3.amazonaws.com/winrm/WinRMSetup.ps1"
$Path6 = "c:\temp\WinRMSetup.ps1"
$URL7 = "https://cnam-qwerty-01.s3.amazonaws.com/winrm/New-SelfSignedCertificateEx.ps1"
$Path7 = "c:\temp\New-SelfSignedCertificateEx.ps1"
Invoke-WebRequest -URI $URL6 -OutFile $Path6
Invoke-WebRequest -URI $URL7 -OutFile $Path7
</powershell>