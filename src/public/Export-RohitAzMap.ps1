function Export-rohitazmap {
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = 'AzLogin', Mandatory = $true, Position = 0)]
        [string[]] $ResourceGroup,

        [Parameter(ParameterSetName = 'AzLogin')]
        [switch] $Show,

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateSet(1, 2, 3)]
        [int] $LabelVerbosity = 1,

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateSet(1, 2, 3)]
        [int] $CategoryDepth = 1,

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateSet('png', 'svg')]
        [string] $OutputFormat = 'png',

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateSet('light', 'dark', 'neon')]
        [string] $Theme = 'light',

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateSet('left-to-right', 'top-to-bottom')]
        [string] $Direction = 'top-to-bottom',

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateScript( { Test-Path -Path $_ -IsValid })]
        [string] $OutputFilePath = (Join-Path ([System.IO.Path]::GetTempPath()) "output.$OutputFormat"),

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateSet('polyline', 'curved', 'ortho', 'line', 'spline')]
        [string] $Splines = 'spline',

        [Parameter(ParameterSetName = 'AzLogin')]
        [ValidateNotNullOrEmpty()]
        [string[]] $ExcludeTypes
    )

    try {
        $StartTime =  [datetime]::Now

        $ErrorActionPreference = 'stop'

        Write-Host ""
        Write-CustomHost "Testing Graphviz installation..." -Indentation 0 -color Magenta -AddTime

        $GraphViz = Get-DOTExecutable

        if ( $null -eq $GraphViz ) {
            Write-Error "'GraphViz' is not installed on this system and is a prerequisites for this module to work. Please download and install from https://graphviz.org/download/ and re-run this command." -ErrorAction Stop
        } else {
            Write-CustomHost "GraphViz installation path : $GraphViz" -Indentation 1 -color Green
        }

        switch ($Theme) {
            'light' {
                $VisualizationGraphColor = 'White'
                $MainGraphBGColor = 'ivory1'
                $ResourceGroupGraphColor = 'black'
                $ResourceGroupGraphBGColor = 'ghostwhite'
                $VNetGraphColor = 'mintcream'
                $SubnetGraphBGColor = 'whitesmoke'
                $SubnetGraphColor = 'black'
                $GraphFontColor = 'black'
                $DependencyEdgeColor = 'lightslategrey'
                $NetworkEdgeColor = 'royalblue2'
                $EdgeFontColor = 'black'
                $NodeColor = 'black'
                $NodeFontColor = 'black'
                break
            }
            'dark' {
                $VisualizationGraphColor = 'White'
                $MainGraphBGColor = 'Black'
                $ResourceGroupGraphColor = 'white'
                $ResourceGroupGraphBGColor = 'grey7'
                $VNetGraphColor = 'white'
                $VNetGraphBGColor = 'grey15'
                $SubnetGraphColor = 'white'
                $SubnetGraphBGColor = 'grey23'
                $GraphFontColor = 'white'
                $DependencyEdgeColor = 'lightslategrey'
                $NetworkEdgeColor = 'royalblue2'
                $EdgeFontColor = 'white'
                $NodeColor = 'white'
                $NodeFontColor = 'white'
                break
            }
            'neon' {
                $VisualizationGraphColor = 'White'
                $MainGraphBGColor = 'grey14'
                $ResourceGroupGraphColor = 'white'
                $ResourceGroupGraphBGColor = 'midnightblue'
                $VNetGraphColor = 'white'
                $VNetGraphBGColor = 'darkslategray'
                $SubnetGraphColor = 'white'
                $SubnetGraphBGColor = 'maroon4'
                $GraphFontColor = 'gold2'
                $DependencyEdgeColor = 'olivedrab1'
                $NetworkEdgeColor = 'lightpink2'
                $EdgeFontColor = 'gold2'
                $NodeColor = 'gold2'
                $NodeFontColor = 'gold2'
                break
            }
        }

        $TargetType = 'Azure Resource Group'
        $Targets = $ResourceGroup

        $rank = @{
            "Microsoft.Network/publicIPAddresses"     = 1
            "Microsoft.Network/loadBalancers"         = 2
            "Microsoft.Network/virtualNetworks"       = 3
            "Microsoft.Network/networkSecurityGroups" = 4
            "Microsoft.Network/networkInterfaces"     = 5
            "Microsoft.Compute/virtualMachines"       = 6
        }

        Write-CustomHost "Configuring Defaults..." -Indentation 0 -color Magenta -AddTime
        Write-CustomHost " Target Type            : $TargetType" -Indentation 1 -color Green
        Write-CustomHost " Output Format          : $OutputFormat" -Indentation 1 -color Green
        Write-CustomHost " Excluded Resource Types: $($ExcludeTypes.foreach({"'$_'"}))" -Indentation 1 -color Green
        Write-CustomHost " Output File Path       : $OutputFilePath" -Indentation 1 -color Green
        Write-CustomHost " Label Verbosity        : $LabelVerbosity" -Indentation 1 -color Green
        Write-CustomHost " Category Depth         : $CategoryDepth" -Indentation 1 -color Green
        Write-CustomHost " Sub-graph Direction    : $Direction" -Indentation 1 -color Green
        Write-CustomHost " Theme                  : $Theme" -Indentation 1 -color Green
        Write-CustomHost " Launch Visualization   : $Show" -Indentation 1 -color Green

        Write-CustomHost "Target ${TargetType}s..." -Indentation 0 -color Magenta -AddTime
        $Targets.ForEach({ Write-CustomHost $_ -Indentation 1 -color Green })

        Write-CustomHost "Starting to generate Azure visualization..." -Indentation 0 -color Magenta -AddTime

        $graph = ConvertTo-DOTLanguage -TargetType $TargetType -Targets $Targets -CategoryDepth $CategoryDepth -LabelVerbosity $LabelVerbosity -Splines $Splines -ExcludeTypes $ExcludeTypes

        if ($graph) {
            @"
strict $graph
"@ | Export-PSGraph -GraphVizPath $GraphViz.FullName -ShowGraph:$Show -OutputFormat $OutputFormat -DestinationPath $OutputFilePath -OutVariable output | Out-Null

            Write-CustomHost ("Visualization exported to path: {0}" -f $output.fullname) -Indentation 0 -color Magenta -AddTime
            Write-CustomHost "Finished Azure visualization." -Indentation 0 -color Magenta -AddTime
        }
    } catch {
        $_
    }
}

Export-ModuleMember Export-rohitazmap

