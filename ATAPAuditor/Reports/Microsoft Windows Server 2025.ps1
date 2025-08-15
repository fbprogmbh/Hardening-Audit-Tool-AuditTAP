
[Report] @{
	Title = "Windows Server 2025 Audit Report"
	ModuleName = "ATAPAuditor"
	BasedOn = @(
		"CIS Microsoft Windows Server 2025, Version: 1.0.0, Date 2025-03-19"
		"Microsoft Security baseline for Microsoft Windows Server 2022, Version: FINAL, Date 2021-09-27"
		"DISA Windows Server 2022, Version: V1R1, Date 2022-09-28"
		"FB Pro recommendations 'Ciphers Protocols and Hashes Benchmark', Version 1.2.1, Date: 2023-11-03"
		"FB Pro recommendations 'Enhanced settings', Version 1.2.1, Date: 2023-11-03"
	)
	Sections = @(
		[ReportSection] @{
			Title = "CIS Benchmarks"
			Description = "This section contains all CIS recommendations"
			SubSections = @(
				[ReportSection] @{
					Title = "Registry Settings/Group Policies"
					AuditInfos = Test-AuditGroup "Microsoft Windows Server 2025-CIS-1.0.0#RegistrySettings"
				}
				[ReportSection] @{
					Title = "User Rights Assignment"
					AuditInfos = Test-AuditGroup "Microsoft Windows Server 2025-CIS-1.0.0#UserRights"
				}
				[ReportSection] @{
					Title = "Account Policies"
					AuditInfos = Test-AuditGroup "Microsoft Windows Server 2025-CIS-1.0.0#AccountPolicies"
				}
				[ReportSection] @{
					Title = "Advanced Audit Policy Configuration"
					AuditInfos = Test-AuditGroup "Microsoft Windows Server 2025-CIS-1.0.0#AuditPolicies"
				}
				[ReportSection] @{
					Title = "Security Options"
					AuditInfos = Test-AuditGroup "Microsoft Windows Server 2025-CIS-1.0.0#SecurityOptions"
				}
			)
		}
	)
}