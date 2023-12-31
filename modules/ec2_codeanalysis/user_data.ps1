<powershell>
    if(!(test-path -Path "c:\temp"))
        {    
            New-Item -ItemType directory -Path "c:\temp"
            write-host "created temp directory"
        }

    function Write-Log {
        [CmdletBinding()]
        param(
            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [string]$Message
        )
        [pscustomobject]@{
            Time = (Get-Date -f g)
            Message = $Message
        } | Export-Csv -Path "c:\temp\UserDataLogFile.log" -Append -NoTypeInformation
    }

    Write-Log "running script"

    ## AWSCLI
    try {
        msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn
    }catch {
        Write-Log -Message $_
    }finally {
        Write-Log -Message "AWS CLI se instaló satisfactoriamente"
    }

    ## DotNet 6.0
    try {
        $URL1 = "https://download.visualstudio.microsoft.com/download/pr/81531ad6-afa9-4b61-9d05-6a76dce81123/2885d26c1a58f37176fd7859f8cc80f1/dotnet-sdk-6.0.417-win-x64.exe"
        $Path1 = "c:\temp\dotnet-sdk-6.0.417-win-x64.exe"
        Invoke-WebRequest -URI $URL1 -OutFile $Path1
        c:/temp/dotnet-sdk-6.0.417-win-x64.exe /install /quiet /norestart
    }
    catch {
        Write-Log -Message $_
    }finally {
        Write-Log -Message ".NET 6.0 se instaló satisfactoriamente"
    }

    ## Porting Assistant

    try {
        $URL2 = “https://s3.us-west-2.amazonaws.com/aws.portingassistant.dotnet.download/latest/windows/Porting-Assistant-Dotnet.exe”
        $Path2 = "c:\temp\Porting-Assistant-Dotnet.exe"
        Invoke-WebRequest -URI $URL2 -OutFile $Path2
    }
    catch {
        Write-Log -Message $_
    }finally {
        Write-Log -Message "Porting Assistant de descargo satisfactoriamente"
    }
</powershell>