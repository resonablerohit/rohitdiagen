# Set project root and load all functions from /src/
$ProjectRoot = (Get-Location).Path
$Path = Join-Path $PSScriptRoot 'src'

# Import all function files
Get-ChildItem $Path -Filter *.ps1 -Recurse | ForEach-Object {
    . $_.FullName
}

# Ensure dependencies are loaded (optional runtime check)
$RequiredModules = 'PSGraph', 'Az.Accounts', 'Az.Resources', 'Az.Network', 'Az.Compute'
foreach ($module in $RequiredModules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Write-Verbose "🔄 Installing missing module: $module"
        Install-Module $module -Force -Scope CurrentUser -Confirm:$false
    }
    Import-Module $module -ErrorAction SilentlyContinue
}

Write-Verbose "✅ rohitazmap module loaded."

