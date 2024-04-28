# Function to disconnect from Wi-Fi network
function Disconnect-WiFi {
    netsh wlan disconnect
}

# Function to reconnect to Wi-Fi network
function Reconnect-WiFi {
    netsh wlan connect ssid="$SSID" name="$SSID"
}

# Function to cancel the countdown
function Cancel-Countdown {
    $global:cancel = $true
}

# Prompt user for Wi-Fi network name (SSID)
$SSID = Read-Host "Enter the name of your Wi-Fi network (SSID):"

# Display message
Write-Host "Attempting to disconnect and reconnect to Wi-Fi network '$SSID'..."
Write-Host "Press any key within 5 seconds to cancel."

# Initialize cancellation flag
$global:cancel = $false

# Countdown timer
for ($i = 5; $i -gt 0; $i--) {
    if ($global:cancel) {
        Write-Host "Cancellation requested. Exiting..."
        exit
    }
    Write-Host "Countdown: $i"
    Start-Sleep -Seconds 1
}

# Disconnect from Wi-Fi network
Disconnect-WiFi

# Wait for a few seconds (adjust as needed)
Start-Sleep -Seconds 5

# Reconnect to Wi-Fi network
Reconnect-WiFi

Write-Host "Disconnected and reconnected to Wi-Fi network '$SSID'."
