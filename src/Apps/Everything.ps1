# Define the base URL where the download links are listed
$baseUrl = "https://www.voidtools.com/downloads/"

# Use Invoke-WebRequest to fetch the content of the page
$response = Invoke-WebRequest -Uri $baseUrl -ErrorAction Stop

$regexPattern = "Everything-\d+\.\d+\.\d+\.\d+\.x64-Setup\.exe"

# Find all matches in the content
$matches = [regex]::Matches($response.Content, $regexPattern)

# If there are any matches, proceed to download the latest version based on the naming convention
if ($matches.Count -gt 0) {
    # Assuming that the last match is the latest version
    $latestVersionUrl = $matches[-1].Value

    # Combine the base URL with the latest version URL snippet
    $downloadUrl = $baseUrl.TrimEnd('/') + '/' + $latestVersionUrl

    # Define the path where the file will be saved (in this example, the temp directory)
    $downloadPath = "C:\temp" + $latestVersionUrl

    # Download the file
#    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath -ErrorAction Stop

    Invoke-WebRequest -Uri $downloadUrl -ErrorAction Stop
    Write-Host "Downloaded latest version to $downloadPath"
} else {
    Write-Error "No matching links found on the page."
}
