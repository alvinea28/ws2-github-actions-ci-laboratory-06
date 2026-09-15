# Lab 06 · Defender DevOps: scan, inspect and repair IaC

**Goal:** scan Terraform → inspect Defender ingestion → fix → rescan, following [Microsoft's IaC DevSecOps flow](https://learn.microsoft.com/en-us/azure/architecture/solution-ideas/articles/devsecops-infrastructure-as-code). **Terraform AVM is primary**; the custom baseline is not AVM, and CodeQL is not the Terraform scanner. Microsoft Sentinel is excluded.

> **Unexecuted instructions.** This authoring change grants no cloud authorization; protected live approvals remain independent of AgentAlvine progress.

## 1. Do — check scope before onboarding

Complete [private-copy setup](../docs/start-here.md). Require an **Azure account with Defender already onboarded**, connector-management permission and a **GitHub organization owner** for installation consent.

In **Defender for Cloud → Environment settings**, inspect existing GitHub connectors first. Reuse the authorized connector; confirm organization/selected repositories include **your private Lab 06 copy** within approved scope, preserving unrelated selections.

One organization permits **only one connector per Azure tenant**. Only if none exists and creation is approved, use [official onboarding](https://learn.microsoft.com/en-us/azure/defender-for-cloud/quickstart-onboard-github) for a **dedicated lab connector/installation** within approved scope. Never duplicate onboarding/connect unrelated repositories or organizations; never enable paid features without explicit cost consent.

**Why/Expected:** a real ingestion route. **Fix:** missing scope/permissions blocks work. Private GHAS entitlement is needed to view **GitHub Code scanning**, not Defender findings; the actual connector remains mandatory.

## 2. Do — configure scanning in your copy

On controlled `lab/ci`, use **GitHub → Actions → New workflow** with the [official Microsoft Security DevOps setup](https://learn.microsoft.com/en-us/azure/defender-for-cloud/github-action). Save the definition to this branch in **your copy**; inspect diff/triggers and follow review/pinning policy. Verify the official version's full commit in GitHub; never invent a SHA or use `latest`.

Set the action's `with` input **`categories: 'IaC'`** exactly: it selects infrastructure analyzers. Retain documented Defender reporting/artifacts. Private GitHub Code scanning upload requires the entitlement; Defender findings do not.

**Why/Expected:** source scanning, not deployment. Ordinary PR checks stay read-only; any `security-events: write` belongs only to the entitled GitHub reporter job, not cloud authentication. No PR Azure login/OIDC/state/secrets, trusted deployment runners or `pull_request_target`. **Fix:** request owner help; never widen permissions.

## 3. Do — inspect actual findings

[Commit/push](../docs/git-workflow.md), then open **Actions**, the exact branch/SHA run, MSDO/analyzer logs and findings artifact. Confirm Terraform files were analyzed. Select a nonsecret misconfiguration; note its rule, file/property and severity.

Open **Defender for Cloud → DevOps security → your connected organization/repository**. Inspect the **same copy's corresponding finding**; compare rule/path and scan timestamps using [IaC findings guidance](https://learn.microsoft.com/en-us/azure/defender-for-cloud/iac-vulnerabilities).

**Why/Expected:** real scanner-to-Defender correlation. **Fix:** discovery can take **eight hours**; findings have variable latency. Check connector health/scope, reporting and timestamps; missing ingestion is not success.

## 4. Do — fix and rescan

Correct that Terraform property on `lab/ci` using the [Git workflow](../docs/git-workflow.md), inspect checks and scan the new commit. Reopen the same rule/path in Defender after processing.

**Expected:** observed resolution, not merely green CI. **Fix:** no finding means remediation unexecuted. If necessary request an instructor-approved, nonsecret **scan-only fixture outside deployable roots**; never deploy/weaken an NSG to manufacture a finding.

Keep a private manual activity record: source/run URLs, SHAs, finding, timestamps, correction and blockers. **Not an AgentAlvine grader claim or Azure approval**; never edit progress.

## 5. Cleanup — remove only activity-owned items

Remove unsafe fixtures via a **reviewed commit**; rescan and verify removal, preserving baseline checks.

Only the authorized owner may remove **dedicated lab connectors/application installations exclusively created for this activity**, after checking shared consumers. Otherwise preserve shared installations/connectors, selections and original settings. **Never turn off subscription Defender.**

**Expected/Fix:** verify authorized removals; uncertain ownership means preserve/escalate.
