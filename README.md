# rohitdiagen

🔷 Rohit Azure Map Generator — A PowerShell module to automatically generate professional Azure infrastructure diagrams using GraphViz and official Azure icons.

## Features
- Auto-discovers Azure resources
- Visualizes RG → VNet → Subnet → VMs → Dependencies
- PNG/SVG output
- Supports light/dark/neon themes

## Usage
```powershell
Export-rohitazmap -ResourceGroup "my-rg" -Theme light -Show -OutputFormat png
