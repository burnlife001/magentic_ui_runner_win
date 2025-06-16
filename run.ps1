$envName = ".venv"
$envPath = "$PSScriptRoot\$envName"
$ps1File = "$envPath\Scripts\activate.ps1"


function Activate-VirtualEnvironment{
    if (Test-Path $ps1File) {
        Write-Host "Activating virtual environment..." -ForegroundColor Cyan
        try {
            . $ps1File
        } catch {
            Write-Host "Failed to activate virtual environment: $_" -ForegroundColor Red
            Write-Host "Please try running this script as Administrator" -ForegroundColor Yellow
            exit 1
        }
    } else {
        Write-Host "Virtual environment not found. Please run 'python -m venv $envName' to create it." -ForegroundColor Red
        exit 1
    }
}
function ChekAPIKey {
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
}
function ChekFFmpeg {
    # Check if FFmpeg is installed
    if (-not (Get-Command "ffmpeg" -ErrorAction SilentlyContinue)) {
        Write-Host "FFmpeg is not installed. Please install it from https://ffmpeg.org/" -ForegroundColor Red
        Write-Host "FFmpeg is not in PATH. Please add it to PATH or run this script from the directory where ffmpeg is installed." -ForegroundColor Red
        exit 1
    }
}

Activate-VirtualEnvironment
# ChekAPIKey
ChekFFmpeg
Write-Host "Starting Magentic UI..." -ForegroundColor Cyan
magentic ui --port 8081
pause