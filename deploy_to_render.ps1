param (
    [string]$RepoUrl = "https://github.com/akulattre-31/AdiShila-AI_TaskPilot"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Render Terminal Deployment Automator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Prompt for Render API Key securely
$SecureKey = Read-Host "Please enter your Render API Key (input is hidden)" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureKey)
$ApiKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

if ([string]::IsNullOrWhiteSpace($ApiKey)) {
    Write-Host "Error: Render API Key is required." -ForegroundColor Red
    exit 1
}

Write-Host "Connecting to Render API..." -ForegroundColor Yellow

$Headers = @{
    "Authorization" = "Bearer $ApiKey"
    "Accept" = "application/json"
    "Content-Type" = "application/json"
}

# 1. Fetch the user's Render Account ID (Owner ID)
try {
    $UserResponse = Invoke-RestMethod -Uri "https://api.render.com/v1/users" -Headers $Headers -Method Get
    $OwnerId = $UserResponse[0].user.id
} catch {
    Write-Host "Failed to authenticate with Render. Please check your API Key." -ForegroundColor Red
    exit 1
}

Write-Host "Authenticated successfully! Setting up the Web Service..." -ForegroundColor Green

# 2. Create the Web Service payload
$Payload = @{
    ownerId = $OwnerId
    type = "web_service"
    name = "adishila-ai-backend"
    autoDeploy = "yes"
    repo = $RepoUrl
    branch = "main"
    serviceDetails = @{
        env = "python"
        region = "oregon"
        plan = "free"
        buildCommand = "cd backend && pip install -r requirements.txt"
        startCommand = "cd backend && uvicorn main:app --host 0.0.0.0 --port `$PORT"
        envVars = @(
            @{ key = "PYTHON_VERSION"; value = "3.11.0" },
            @{ key = "GEMINI_API_KEY"; value = "<YOUR_GEMINI_API_KEY>" },
            @{ key = "DATABASE_URL"; value = "<YOUR_NEON_DB_URL>" },
            @{ key = "JWT_SECRET_KEY"; value = "<YOUR_JWT_SECRET>" }
        )
    }
}

# 3. Send Request to Render
try {
    $CreateResponse = Invoke-RestMethod -Uri "https://api.render.com/v1/services" -Headers $Headers -Method Post -Body ($Payload | ConvertTo-Json -Depth 10)
    
    $ServiceId = $CreateResponse.id
    $ServiceUrl = $CreateResponse.service.url
    
    Write-Host "`nSUCCESS!" -ForegroundColor Green
    Write-Host "Your deployment has been triggered." -ForegroundColor Green
    Write-Host "Live URL (Pending Build): $ServiceUrl" -ForegroundColor Cyan
    Write-Host "You can now update your index.html to point to this URL!" -ForegroundColor Yellow
} catch {
    Write-Host "Failed to create service. Render might require you to connect GitHub manually first." -ForegroundColor Red
    Write-Host $_.Exception.Message
}
