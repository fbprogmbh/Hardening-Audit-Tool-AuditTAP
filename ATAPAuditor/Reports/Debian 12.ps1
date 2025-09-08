[Report] @{
	Title = "Debian 12 Report"
	ModuleName = "ATAPAuditor"
	BasedOn = @(
		"CIS Debian 12, Version: 1.0.1, Date: 2024-04-15"
    )
	Sections = @(
		[ReportSection] @{
			Title = "CIS Benchmarks"
			Description = "This section contains the general benchmark results"
			SubSections = @(
				[ReportSection] @{
					Title = 'CIS Recommendations'
					AuditInfos = Test-AuditGroup "Debian Linux 12-CIS-1.0.1"
				}
			)
		}
	)
}
