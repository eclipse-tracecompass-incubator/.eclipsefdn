local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local tc_default_branch_protection_rule(pattern) =
  orgs.newBranchProtectionRule(pattern) {
        dismisses_stale_reviews: true,
          is_admin_enforced: true,
          required_approving_review_count: 1,
          requires_status_checks: false,
          requires_strict_status_checks: true,
  };

orgs.newOrg('eclipse-tracecompass-incubator') {
  settings+: {
    blog: "https://projects.eclipse.org/projects/tools.tracecompass.incubator",
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "Permanent incubator for the Eclipse Trace Compass Project.",
    email: "webmaster@eclipse-foundation.org",
    name: "Eclipse Trace Compass Incubator",
    readers_can_create_discussions: true,
    two_factor_requirement: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('org.eclipse.tracecompass.incubator') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      topics+: [
        "profiling",
        "trace-compass",
        "trace",
        "trace-viewer",
        "trace-visualization"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "read",
      },
      branch_protection_rules: [
        tc_default_branch_protection_rule('master')
      ],
    },
  ],
}
