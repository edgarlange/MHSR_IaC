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

## DMS Collector
    try {
        $URL1 = "https://cnam-qwerty-01.s3.amazonaws.com/dms/AWS_DMS_Collector_Installer_1.4.1.msi"
        $Path1 = "c:\temp\AWS_DMS_Collector_Installer_1.4.1.msi"
        Invoke-WebRequest -URI $URL1 -OutFile $Path1
    }catch {
        Write-Log -Message $_
    }finally {
        Write-Log -Message "AWS CLI se instaló satisfactoriamente"
    }
</powershell>