# Check if OPENAI_API_KEY environment variable is set
if (-not $env:OPENAI_API_KEY) {
    Write-Host "OPENAI_API_KEY environment variable not detected" -ForegroundColor Yellow
    Write-Host "Please enter your OpenAI API Key:" -ForegroundColor Cyan
    $apiKey = Read-Host -AsSecureString

    # Convert SecureString to plain string
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($apiKey)
    $plainApiKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

    # Set environment variable
    $env:OPENAI_API_KEY = $plainApiKey
    Write-Host "API Key has been set" -ForegroundColor Green
} else {
    Write-Host "OPENAI_API_KEY environment variable is already set" -ForegroundColor Green
}

# Start magentic ui
Write-Host "Starting Magentic UI..." -ForegroundColor Cyan
magentic ui --port 8081