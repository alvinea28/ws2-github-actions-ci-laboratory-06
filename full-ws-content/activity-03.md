# Lab 06 · Activity 03 — Call the typed reusable workflow

[Review index](README.md) · [Previous activity](activity-02.md) · [Next activity](activity-04.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress.

<!-- FULL-WS-LESSON:START -->
# Lab 06 · Step 3 — Call a typed, allowlisted reusable workflow

**Goal:** call reusable validation **at job level**, preserving typed input, the fixed root and read-only permissions.

| Working context | Value |
| --- | --- |
| Branch | Continue `lab/ci` after repaired green CI; keep the draft PR |
| Create | [.github/workflows/validate.yml](README.md#learner-created-workflows) |
| Edit | [.github/workflows/lab-checks.yml](README.md#learner-created-workflows) |
| Starters | [exercises/validate.yml.example](../exercises/validate.yml.example), [exercises/reusable-caller.yml.example](../exercises/reusable-caller.yml.example) |
| Contract | Required string `root`; only `module` allowed |
| Tools | Node **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**; mocks only |

## Do 1 — Create the complete reusable workflow

On `lab/ci`, copy the **whole starter** into the listed new file using **Explorer**. Inspect any existing destination first:

```yaml
name: Reusable validation
on:
  workflow_call:
    inputs:
      root:
        type: string
        required: true
permissions:
  contents: read
jobs:
  validate:
    name: Validate
    runs-on: ubuntu-24.04
    env:
      ROOT: ${{ inputs.root }}
    steps:
      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
        with:
          persist-credentials: false
      - uses: actions/setup-node@820762786026740c76f36085b0efc47a31fe5020 # v7.0.0
        with:
          node-version: 24.16.0
      - uses: hashicorp/setup-terraform@dfe3c3f87815947d99a8997f908cb6525fc44e9e # v4.0.1
        with:
          terraform_version: 1.16.1
          terraform_wrapper: false
      - run: test "$ROOT" = module
      - run: node scripts/check-learner.mjs
```

| Element / command | Meaning |
| --- | --- |
| `workflow_call`, required string `root` | Declare the callable interface; typing alone is not an allowlist |
| `ROOT: ${{ inputs.root }}` | Pass input as environment data, not interpolated shell source |
| `test "$ROOT" = module` | Shell equality test, no flags: quoted input stays one argument; only literal `module` exits zero; other values stop the job before the helper |
| `node scripts/check-learner.mjs` | Run the root JavaScript checker with no flags; it selects the fixed module and executes backend-disabled, locked-provider mocks |
| SHA-pinned `uses`, exact tool versions | Reuse the supplied action code and toolchain |
| `contents: read`, `persist-credentials: false` | Read-only token; do not retain checkout authentication |
| `terraform_wrapper: false` | Preserve direct Terraform output/JSON for the helper |

## Do 2 — Inspect the guard's rejection boundary

The guard must run **before** the helper. `module` is accepted; an empty string, `.`, `../module`, other paths or shell fragments are rejected. Quotes prevent splitting/globbing, and input is never evaluated as shell code. Keep the fixed working root; do not widen the allowlist to make bad input pass.

**Expected:** typed input **and** exact-value validation, not merely a string declaration. No Azure login/OIDC/state, `id-token: write`, `secrets.`, `secrets: inherit`, `pull_request_target:`, private runner or unfinished `TODO` in either workflow.

## Do 3 — Replace the inline caller with this job-level call

```yaml
name: Lab checks
on:
  push:
  pull_request:
permissions:
  contents: read
jobs:
  validate:
    name: Validate learner code
    uses: ./.github/workflows/validate.yml
    with:
      root: module
```

**Why:** job-level `uses` calls this copy's reusable workflow at the same revision; `with` passes `module`. Events and read-only permissions stay. The caller has no `runs-on`/`steps`; the callee owns execution. `needs` can order future dependent jobs, not hide failure.

## Do 4 — Push both files and inspect real nested CI

Review both diffs. **Save → stage → commit → push → refresh the same Exercise** using the [Git guide](../docs/git-workflow.md); message: `lab: reuse typed module validation`. Confirm both destination files reached `lab/ci`, not just their examples.

![Microsoft reference showing the commit message field and Commit button](../docs/images/vscode-commit.png)

*REFERENCE — Microsoft publisher example, CC BY 3.0 US; not your files/commit. [Sources and attribution](../docs/images/NOTICE.md).*

Open **Actions → Lab checks** at the newest push SHA, then the called job, often **Validate learner code / Validate**. Inspect the allowlist and executed mocks. Check the draft PR's latest-head association; its temporary merge SHA can differ from the push SHA.

**Expected:** real nested execution; the final activity requires the **whole caller workflow** to pass. AgentAlvine checks the interface/caller files. Filenames, editor warnings and guessed job labels are not execution evidence.

**Stop/recover:** fix job indentation/leftover inline fields; supply exactly `module` for bad input. Inspect real diagnostics and [troubleshooting](../docs/troubleshooting.md) for failed/skipped/empty runs, never loosen permissions or guards. Copilot **Ask** may explain the workflows read-only.
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified.** The typed `root` interface and job-level reusable caller were accepted; real nested validation execution was proved in the original private evidence.
- **Cycle B: verified.** The fresh copy independently exercised the nested CI route while retaining the `module` allowlist and credential-free boundary.
- A reusable filename alone is not invocation proof. Original job/run URLs remain in the private review, separate from the public source preview.

See [simulation.md](simulation.md) for original evidence and whole-lab totals, not a per-activity allocation of test counts.

[Previous activity](activity-02.md) · [Review index](README.md) · [Next activity](activity-04.md)
