[Report] @{
    Title      = 'Microsoft Office Enterprise Audit Report'
    ModuleName = 'ATAPAuditor'
    BasedOn    = @(
        'CIS Microsoft Office Enterprise Benchmark, Version: 1.2.0, Date: 2024-07-19'
    )
    Sections   = @(
        [ReportSection] @{
            Title       = "CIS Benchmarks"
            Description = "This section contains all CIS recommendations"
            SubSections = @(
                [ReportSection] @{
                    Title      = 'Registry Settings/Group Policies'
                    AuditInfos = Test-AuditGroup "Microsoft Office Enterprise-CIS-1.2.0#RegistrySettings"
                }
                [ReportSection] @{
                    Title      = 'User Rights Assignment'
                    AuditInfos = Test-AuditGroup "Microsoft Office Enterprise-CIS-1.2.0#UserRights"
                }
                [ReportSection] @{
                    Title      = 'Advanced Audit Policy Configuration'
                    AuditInfos = Test-AuditGroup "Microsoft Office Enterprise-CIS-1.2.0#AuditPolicies"
                }
            )
        }
    )
}