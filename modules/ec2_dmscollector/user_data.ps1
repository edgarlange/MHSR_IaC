<powershell>
    if(!(test-path -Path "${folder}"))
        {    
            New-Item -ItemType directory -Path "${folder}"
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
        } | Export-Csv -Path "${folder}\UserDataLogFile.log" -Append -NoTypeInformation
    }

    Write-Log "running script"

    ## AWSCLI
    try {
        msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn
    }catch {
        Write-Log -Message $_
    }finally {
        Write-Log -Message "AWS CLI se instalo satisfactoriamente"
    }

## DMS Collector
    try {
        "msiexec.exe /i ${dmsc} /qn"
    }catch {
        Write-Log -Message $_
    }finally {
        Write-Log -Message "AWS DMS Collector se instalo satisfactoriamente"
    }
</powershell>