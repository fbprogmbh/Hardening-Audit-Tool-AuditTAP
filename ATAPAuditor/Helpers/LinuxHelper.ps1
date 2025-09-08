$script:LinuxDistroId = $null


$rcTrue = "True"
$rcCompliant = "Compliant"
$rcFalse = "False"
$rcNone = "None"
$rcNonCompliant = "Non-Compliant"
$rcNonCompliantManualReviewRequired = "Manual review required"
$rcCompliantIPv6isDisabled = "IPv6 is disabled"

if (Test-Path "/etc/os-release") {
    $osRelease = @{}
    Get-Content "/etc/os-release" | ForEach-Object {
        if ($_ -match "^(?<key>\w+)=(?<val>.+)$") {
            $osRelease[$matches.key] = $matches.val.Trim('"')
        }
    }

    $script:LinuxDistroId = $osRelease["ID"]

    if (-not $script:LinuxDistroId) {
        throw "Could not detect Linux distribution from /etc/os-release"
    }

    switch ($script:LinuxDistroId) {
        "ubuntu" {}
        "debian" {}
        "rhel" {}
        "centos" {}
        "fedora" {}
        "opensuse" {}
        default {
            throw "Unsupported Linux distribution: $script:LinuxDistroId"
        }
    }
    Write-Verbose "Detected $script:LinuxDistroId"
} else {
    throw "/etc/os-release not found. Cannot detect Linux distribution."
}

function Test-PackageInstalled {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName
    )

    switch ($script:LinuxDistroId) {
        "ubuntu" 
        { 
            dpkg-query -W -f='${db:Status-Abbrev}' $PackageName 2>/dev/null | Out-Null
            return ($LASTEXITCODE -eq 0)
        }

        "debian" 
        { 
            dpkg-query -W -f='${db:Status-Abbrev}' $PackageName 2>/dev/null | Out-Null
            return ($LASTEXITCODE -eq 0)
        }

        "rhel" 
        { 
            rpm -q $PackageName >/dev/null 2>&1
            return ($LASTEXITCODE -eq 0)
        }

        "centos" 
        { 
            rpm -q $PackageName >/dev/null 2>&1
            return ($LASTEXITCODE -eq 0)
        }

        "fedora" 
        { 
            rpm -q $PackageName >/dev/null 2>&1
            return ($LASTEXITCODE -eq 0)
        }

        "opensuse" 
        { 
            rpm -q $PackageName >/dev/null 2>&1
            return ($LASTEXITCODE -eq 0)
        }

        default 
        { throw "Unexpected distro in module runtime: $script:LinuxDistroId" }
    }
}

function Test-ServiceActiveOrEnabled {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ServiceName
    )

    # Check if the service is active
    systemctl is-active --quiet $ServiceName
    $isActive = ($LASTEXITCODE -eq 0)

    # Check if the service is enabled
    systemctl is-enabled --quiet $ServiceName
    $isEnabled = ($LASTEXITCODE -eq 0)

    return ($isActive -or $isEnabled)
}

