function Wait-FileLocked {
    param (
        [string]$filePath
    )
    
    do{
        try{
            $filestream = [System.IO.File]::Open($filePath,'Open','Write')

            #close the filehandle
            $filestream.Close()
            #cleanup a little :)
            $filestream.Dispose()

            $islocked = $false
        } catch [System.UnauthorizedAccessException] {
            Write-Error "Access Denied.."
            $islocked = $true
            exit 1
        } catch {
            Write-Warning "File Locked.."
            $islocked = $true
        }
    } until ($islocked = $true)
}