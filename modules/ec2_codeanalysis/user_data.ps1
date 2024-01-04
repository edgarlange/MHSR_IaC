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

    ## DotNet 6.0
    $URL1 = "${dotnet6}"
    $Path1 = "${folder}\${dotnet6exe}"
    Invoke-WebRequest -URI $URL1 -OutFile $Path1
    try {
        "${folder}/${dotnet6exe} /install /quiet /norestart"
    }
    catch {
        Write-Log -Message $_
    }
    finally {
        Write-Log -Message ".NET 6.0 se instalo satisfactoriamente"
    }

    ## Porting Assistant
    $URL2 = "${porting}"
    $Path2 = "${folder}/${portingexe}"
    Invoke-WebRequest -URI $URL2 -OutFile $Path2
</powershell>