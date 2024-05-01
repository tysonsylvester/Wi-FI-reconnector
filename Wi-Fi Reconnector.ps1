# Function to play success tone
function Play-SuccessTone {
    [console]::Beep(800, 500) # Play a beep tone
    Start-Sleep -Milliseconds 200
    [console]::Beep(1200, 300) # Play ascending tone
    Start-Sleep -Milliseconds 200
    [console]::Beep(1600, 300)
}

# Function to play failure tone
function Play-FailureTone {
    1..3 | ForEach-Object {
        [console]::Beep(300, 100) # Play a rapid sequence of lower-pitched beeps
        Start-Sleep -Milliseconds 100
    }
}

# Function to disconnect from Wi-Fi network
function Disconnect-WiFi {
    try {
        netsh wlan disconnect | Out-Null
        Play-FailureTone # Play failure tone
    } catch {
        Play-FailureTone # Play failure tone
    }
}

# Function to reconnect to Wi-Fi network
function Reconnect-WiFi {
    try {
        $result = netsh wlan connect name="$global:WiFiNetworkName" | Out-Null
        if ($result -match "successfully") {
            Play-SuccessTone # Play success tone
        } else {
            Play-FailureTone # Play failure tone
        }
    } catch {
        Play-FailureTone # Play failure tone
    }
}

# Function to prompt user to enter Wi-Fi network name (SSID)
function Prompt-SSID {
    $global:WiFiNetworkName = Read-Host "Please enter the name of your Wi-Fi network (SSID):"
}

# Main script
Write-Host "Welcome to the Wi-Fi Reconnector script."

# Prompt user to enter Wi-Fi network name (SSID)
Prompt-SSID

# Display message
Write-Host "Attempting to disconnect and reconnect to Wi-Fi network '$global:WiFiNetworkName'..."
Write-Host "Press any key within 5 seconds to cancel."

# Initialize cancellation flag
$global:cancel = $false

# Countdown timer
for ($i = 5; $i -gt 0; $i--) {
    if ($global:cancel) {
        exit
    }
    Start-Sleep -Seconds 1
}

# Disconnect from Wi-Fi network
Disconnect-WiFi

# Wait for a few seconds (adjust as needed)
Start-Sleep -Seconds 5

# Reconnect to Wi-Fi network
Reconnect-WiFi

Write-Host "Disconnected and reconnected to Wi-Fi network '$global:WiFiNetworkName'."
