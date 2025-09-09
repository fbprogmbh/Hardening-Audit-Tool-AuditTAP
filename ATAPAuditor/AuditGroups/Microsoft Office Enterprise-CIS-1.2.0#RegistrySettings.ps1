# Office root folder
$officePaths = @(
    # Office 365 / 2019 / 2021 (the standard install paths)
    "C:\Program Files\Microsoft Office\root\Office16",
    "C:\Program Files (x86)\Microsoft Office\root\Office16"
    
    # Office 2016 (MSI)
    "C:\Program Files\Microsoft Office\Office16",
    "C:\Program Files (x86)\Microsoft Office\Office16",

    # Office 2016 (x32 MSI on x64 OS)
    "C:\Program Files (x86)\Microsoft Office\root\Office16",
    "C:\Program Files (x86)\Microsoft Office\Office16\",
    
    # Office 2016 (x64 MSI on x64 OS)
    "C:\Program Files\Microsoft Office\Office16\"
)

# Mapping of applications to exe names
$exeMap = @{
    "Groove"              = "GROOVE.EXE"
    "Excel"               = "EXCEL.EXE"
    "Publisher"           = "MSPUB.EXE"
    "PowerPoint"          = "POWERPNT.EXE"
    "PowerPoint Viewer"   = "PPTVIEW.EXE"
    "Project"             = "WINPROJ.EXE"
    "Word"                = "WINWORD.EXE"
    "Outlook"             = "OUTLOOK.EXE"
    "SharePoint Designer" = "SPDESIGN.EXE"
    "Expression Web"      = "EXPRWD.EXE"
    "Access"              = "MSACCESS.EXE"
    "OneNote"             = "ONENOTE.EXE"
    "MS Script Editor"    = "MSE7.EXE"
    "Visio"               = "VISIO.EXE"
    
}

# Check if any Office installation path exists -> if not existend, then Office is not installed
$OfficeInstalled = $false
foreach ($path in $officePaths) {
    if (Test-Path $path) {
        $OfficeInstalled = $true
        break
    }
}

# Determine which Office apps are installed
$installedOfficeApps = @{}

if ($OfficeInstalled) {
    foreach ($app in $exeMap.Keys) {
        foreach ($path in $officePaths) {
            $exePath = Join-Path $path $exeMap[$app]
            if (Test-Path $exePath) {
                $installedOfficeApps[$app] = $true
                break
            }
        }
        if (-not $installedOfficeApps.ContainsKey($app)) {
            $installedOfficeApps[$app] = $false
        }
    }
}
else {
    Write-Warning "Office could not be found on this system."
    Write-Warning "If Office is installed, please leave a comment in Issue-718 (https://github.com/fbprogmbh/Hardening-Audit-Tool-AuditTAP/issues/718) and provide requested information from 'What happened?' section."
}

[AuditTest] @{
    Id   = "1.1.4.1.1 A"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"
            
                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }
        
            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}

[AuditTest] @{
    Id   = "1.1.4.1.1 B"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 C"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"
                
                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 D"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"
                
                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }
        
            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 E"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"
            
                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }
        
            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 F"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 G"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"
                
                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 H"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"
                
                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 I"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 J"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 K"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 L"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 M"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.1 N"
    Task = "(L1) Ensure 'Add-on Management' is set to Enabled (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 A"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 B"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 C"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 D"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 E"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 F"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
            else {
                try {
                    $regValue = Get-ItemProperty -ErrorAction Stop `
                        -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                        -Name "visio.exe" `
                    | Select-Object -ExpandProperty "visio.exe"

                    if (($regValue -ne 1)) {
                        return @{
                            Message = "Registry value is '$regValue'. Expected: x == 1"
                            Status  = "False"
                        }
                    }
                }
                catch [System.Management.Automation.PSArgumentException] {
                    return @{
                        Message = "Registry value not found."
                        Status  = "False"
                    }
                }
                catch [System.Management.Automation.ItemNotFoundException] {
                    return @{
                        Message = "Registry key not found."
                        Status  = "False"
                    }
                }

                return @{
                    Message = "Compliant"
                    Status  = "True"
                }
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 G"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 H"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 I"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 J"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 K"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 L"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 M"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.2 N"
    Task = "(L1) Ensure 'Bind to object' is set to 'Enabled' (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 A"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled'"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 B"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 C"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 D"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 E"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 F"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 G"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 H"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 I"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 J"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 K"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 L"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 M"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.3 N"
    Task = "(L1) Ensure 'Consistent Mime Handling' is set to 'Enabled' (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_HANDLING" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 A"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 B"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 C"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 D"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 E"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 F"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {        
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 G"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 H"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 I"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 J"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 K"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 L"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 M"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.4 N"
    Task = "(L1) Ensure 'Disable user name and password' is set to 'Enabled' (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 A"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 B"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 C"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 D"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {    
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 E"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 F"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 G"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 H"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 I"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 J"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 K"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 L"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 M"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.5 N"
    Task = "(L1) Ensure 'Information Bar' is set to 'Enabled' (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SECURITYBAND" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 A"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneDrive for Business"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 B"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 C"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 D"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 E"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 F"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 G"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 H"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 I"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 J"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}

[AuditTest] @{
    Id   = "1.1.4.1.6 K"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 L"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 M"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.6 N"
    Task = "(L1) Ensure 'Local Machine Zone Lockdown Security' is set to Enabled  (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 A"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 B"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 C"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 D"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 E"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 F"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 G"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 H"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 I"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 J"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 K"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 L"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 M"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.7 N"
    Task = "(L1) Ensure 'Mime Sniffing Safety Feature' is set to Enabled (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MIME_SNIFFING" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 A"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 B"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 C"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 D"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 E"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 F"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 G"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 H"
    Task = "(L1) Ensure 'Navigate URL' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\microsoft\internet explorer\main\featurecontrol\feature_validate_navigate_url" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 I"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 J"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 K"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 L"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 M"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.8 N"
    Task = "(L1) Ensure 'Navigate URL' is set to Enabled  (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 A"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 B"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 C"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 D"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 E"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 F"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 G"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 H"
    Task = "(L1) Ensure 'Object Caching Protection' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\microsoft\internet explorer\main\featurecontrol\feature_object_caching" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 I"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 J"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 K"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 L"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 M"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.9 N"
    Task = "(L1) Ensure 'Object Caching Protection' is set to Enabled  (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_OBJECT_CACHING" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 A"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 B"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 C"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 D"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 E"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 F"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 G"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 H"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\microsoft\internet explorer\main\featurecontrol\feature_zone_elevation" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 I"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 J"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 K"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 L"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 M"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.10 N"
    Task = "(L1) Ensure 'Protection From Zone Elevation' is set to Enabled (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 A"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 B"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 C"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 D"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 E"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 F"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 G"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 H"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\microsoft\internet explorer\main\featurecontrol\feature_restrict_activexinstall" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 I"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 J"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 K"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 L"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 M"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.11 N"
    Task = "(L1) Ensure 'Restrict ActiveX Install' is set to Enabled  (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 A"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 B"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 C"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 D"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 E"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 F"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 G"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 H"
    Task = "(L1) Ensure 'Restrict File Download' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\microsoft\internet explorer\main\featurecontrol\feature_restrict_filedownload" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 I"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 J"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 K"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 L"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 M"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.12 N"
    Task = "(L1) Ensure 'Restrict File Download' is set to Enabled  (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 A"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 B"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 C"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 D"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 E"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 F"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 G"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 H"
    Task = "(L1) Ensure 'Saved from URL' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\microsoft\internet explorer\main\featurecontrol\feature_unc_savedfilecheck" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 I"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 J"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 K"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 L"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 M"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.13 N"
    Task = "(L1) Ensure 'Saved from URL' is set to Enabled  (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 A"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (groove.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Groove"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "groove.exe" `
                | Select-Object -ExpandProperty "groove.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 B"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 C"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 D"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 E"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (pptview.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint Viewer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "pptview.exe" `
                | Select-Object -ExpandProperty "pptview.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 F"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 G"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 H"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\microsoft\internet explorer\main\featurecontrol\feature_window_restrictions" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 I"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 J"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (spDesign.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["SharePoint Designer"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "spDesign.exe" `
                | Select-Object -ExpandProperty "spDesign.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 K"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (exprwd.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Expression Web"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "exprwd.exe" `
                | Select-Object -ExpandProperty "exprwd.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 L"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 M"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (onent.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "onent.exe" `
                | Select-Object -ExpandProperty "onent.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.4.1.14 N"
    Task = "(L1) Ensure 'Scripted Window Security Restrictions' is set to Enabled  (mse7.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["MS Script Editor"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" `
                    -Name "mse7.exe" `
                | Select-Object -ExpandProperty "mse7.exe"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.5.1"
    Task = "(L1) Ensure 'Enable Automatic Updates' is set to Enabled"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\policies\microsoft\office\16.0\common\officeupdate" `
                    -Name "enableautomaticupdates" `
                | Select-Object -ExpandProperty "enableautomaticupdates"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.1.5.2"
    Task = "(L1) Ensure 'Hide Option to Enable or Disable Updates' is set to Enabled"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\software\policies\microsoft\office\16.0\common\officeupdate" `
                    -Name "hideenabledisableupdates" `
                | Select-Object -ExpandProperty "hideenabledisableupdates"

                if (($regValue -ne 1)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 A"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation'"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\office\Common\COM Compatibility" `
                    -Name "Comment" `
                | Select-Object -ExpandProperty "Comment"

                if ($regValue -ne "Block all Flash activation") {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: Block all Flash activation"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 B"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (ActivationFilterOverride)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Common\COM Compatibility\{D27CDB6E-AE6D-11CF-96B8-444553540000}" `
                    -Name "ActivationFilterOverride" `
                | Select-Object -ExpandProperty "ActivationFilterOverride"

                if (($regValue -ne 0)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 0"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 C"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (Compatibility Flags)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Common\COM Compatibility\{D27CDB6E-AE6D-11CF-96B8-444553540000}" `
                    -Name "Compatibility Flags" `
                | Select-Object -ExpandProperty "Compatibility Flags"

                if (($regValue -ne 1024)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1024"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 D"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (ActivationFilterOverride)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Common\COM Compatibility\{D27CDB70-AE6D-11CF-96B8-444553540000}" `
                    -Name "ActivationFilterOverride" `
                | Select-Object -ExpandProperty "ActivationFilterOverride"

                if (($regValue -ne 0)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 0"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 E"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (Compatibility Flags)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Common\COM Compatibility\{D27CDB70-AE6D-11CF-96B8-444553540000}" `
                    -Name "Compatibility Flags" `
                | Select-Object -ExpandProperty "Compatibility Flags"

                if (($regValue -ne 1024)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1024"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 F"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (ActivationFilterOverride, WOW6432)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Office\Common\COM Compatibility\{D27CDB6E-AE6D-11CF-96B8-444553540000}" `
                    -Name "ActivationFilterOverride" `
                | Select-Object -ExpandProperty "ActivationFilterOverride"

                if (($regValue -ne 0)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 0"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 G"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (Compatibility Flags, WOW6432)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Office\Common\COM Compatibility\{D27CDB6E-AE6D-11CF-96B8-444553540000}" `
                    -Name "Compatibility Flags" `
                | Select-Object -ExpandProperty "Compatibility Flags"

                if (($regValue -ne 1024)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1024"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 H"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (ActivationFilterOverride, WOW6432)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Office\Common\COM Compatibility\{D27CDB70-AE6D-11CF-96B8-444553540000}" `
                    -Name "ActivationFilterOverride" `
                | Select-Object -ExpandProperty "ActivationFilterOverride"

                if (($regValue -ne 0)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 0"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.1 I"
    Task = "(L1) Ensure 'Block Flash activation in Office documents' is set to 'Enabled: Block all activation' (Compatibility Flags, WOW6432)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Office\Common\COM Compatibility\{D27CDB70-AE6D-11CF-96B8-444553540000}" `
                    -Name "Compatibility Flags" `
                | Select-Object -ExpandProperty "Compatibility Flags"

                if (($regValue -ne 1024)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 1024"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 A"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (excel.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Excel"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "excel.exe" `
                | Select-Object -ExpandProperty "excel.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 B"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (msaccess.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Access"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "msaccess.exe" `
                | Select-Object -ExpandProperty "msaccess.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 C"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (mspub.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Publisher"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "mspub.exe" `
                | Select-Object -ExpandProperty "mspub.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 D"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (onenote.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["OneNote"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {        
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "onenote.exe" `
                | Select-Object -ExpandProperty "onenote.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 E"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (outlook.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Outlook"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "outlook.exe" `
                | Select-Object -ExpandProperty "outlook.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 F"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (powerpnt.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["PowerPoint"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "powerpnt.exe" `
                | Select-Object -ExpandProperty "powerpnt.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 G"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (visio.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Visio"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "visio.exe" `
                | Select-Object -ExpandProperty "visio.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 H"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (winproj.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Project"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "winproj.exe" `
                | Select-Object -ExpandProperty "winproj.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
[AuditTest] @{
    Id   = "1.3.2 I"
    Task = "(L1) Ensure 'Restrict legacy JScript execution for Office' is set to 'Enabled' (winword.exe)"
    Test = {
        # new logic: 
        # - if no Office installed at all -> skip test 
        # - if Office installed but app not installed -> skip test
        # - else run test as normal

        if (-not $OfficeInstalled) {
            return @{
                Message = "No Office installation detected, skipping test."
                Status  = "None"
            }
        }
        elseif (-not $installedOfficeApps["Word"]) {
            return @{
                Message = "Application not installed, skipping test."
                Status  = "None"
            }
        }
        else {
            try {
                $regValue = Get-ItemProperty -ErrorAction Stop `
                    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\internet explorer\main\featurecontrol\FEATURE_RESTRICT_LEGACY_JSCRIPT_PER_SECURITY_ZONE" `
                    -Name "winword.exe" `
                | Select-Object -ExpandProperty "winword.exe"

                if (($regValue -ne 69632)) {
                    return @{
                        Message = "Registry value is '$regValue'. Expected: x == 69632"
                        Status  = "False"
                    }
                }
            }
            catch [System.Management.Automation.PSArgumentException] {
                return @{
                    Message = "Registry value not found."
                    Status  = "False"
                }
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                return @{
                    Message = "Registry key not found."
                    Status  = "False"
                }
            }

            return @{
                Message = "Compliant"
                Status  = "True"
            }
        }
    }
}
