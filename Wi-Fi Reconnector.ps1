# Function to disconnect from Wi-Fi network
function Disconnect-WiFi {
    try {
        Write-Debug "Attempting to disconnect from Wi-Fi network '$global:WiFiNetworkName'..."
        netsh wlan disconnect
        Write-Debug "Disconnected from Wi-Fi network '$global:WiFiNetworkName'."
    } catch {
        Write-Debug "Failed to disconnect from Wi-Fi network '$global:WiFiNetworkName'. Error: $_"
    }
}

# Function to reconnect to Wi-Fi network
function Reconnect-WiFi {
    try {
        Write-Debug "Attempting to reconnect to Wi-Fi network '$global:WiFiNetworkName'..."
        $result = netsh wlan connect name="$global:WiFiNetworkName"
        Write-Debug "Reconnect result: $result"
        if ($result -match "successfully") {
            Write-Debug "Reconnected to Wi-Fi network '$global:WiFiNetworkName'."
        } else {
            Write-Debug "Failed to reconnect to Wi-Fi network '$global:WiFiNetworkName'."
        }
    } catch {
        Write-Debug "Failed to reconnect to Wi-Fi network '$global:WiFiNetworkName'. Error: $_"
    }
}

# Function to cancel the countdown
function Cancel-Countdown {
    Write-Debug "Cancellation requested. Exiting..."
    $global:cancel = $true
}

# Function to prompt user to enter Wi-Fi network name (SSID)
function Prompt-SSID {
    $global:WiFiNetworkName = Read-Host "Please enter the name of your Wi-Fi network (SSID):"
}

# Display message
Write-Host "Please enter the SSID of your Wi-Fi network."

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
        Cancel-Countdown
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

Write-Host "Disconnected and reconnected to Wi-Fi network '$global:WiFiNetworkName'."
