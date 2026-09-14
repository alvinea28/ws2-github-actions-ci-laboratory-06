# Lab 06 · Activity 03 — Call the typed reusable workflow

[Review index](README.md) · [Previous activity](activity-02.md) · [Next activity](activity-04.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress.

<!-- FULL-WS-LESSON:START -->
# Lab 06 · Step 3 — Call a typed, allowlisted reusable workflow

| Before you start | This step |
| --- | --- |
| Goal | Reuse validation without widening permissions or accepting arbitrary paths |
| Start / working branch | Continue `lab/ci` after the repaired green run; keep the draft PR |
| Create | [.github/workflows/validate.yml](README.md#learner-created-workflows) |
| Edit | [.github/workflows/lab-checks.yml](README.md#learner-created-workflows) |
| Copy from | [exercises/validate.yml.example](../exercises/validate.yml.example) and [exercises/reusable-caller.yml.example](../exercises/reusable-caller.yml.example) |
| Typed contract | Required string input `root`; the only allowed value is `module` |
| Toolchain | Node **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**; locked, backend-disabled, mock-only validation |

A reusable workflow is called **at job level**. It is not an action placed under a job's `steps`.
The caller chooses a supported input; it does not acquire credentials or choose an arbitrary command.

## 1. Add the reusable entry point from the supplied starter

1. In VS Code confirm this clone and the `lab/ci` status-bar branch. Do not open the public template for editing.
2. Press **Ctrl+P**, enter `exercises/validate.yml.example`, and read the complete starter.
3. Select its contents with **Ctrl+A**, then **Ctrl+C**.
4. Use **Explorer** → **New File** at this clone's root and enter `.github/workflows/validate.yml`; paste with **Ctrl+V**.
5. If the destination already exists, open it with **Ctrl+P** and inspect it first. Replace only the intended exercise workflow, not other automation.
6. Press **Ctrl+S**. Keep the full supplied action SHAs, pinned tool versions, read-only permissions, and helper unchanged.

The typed entry point must remain:

```yaml
on:
  workflow_call:
    inputs:
      root:
        type: string
        required: true
permissions:
  contents: read
```

## 2. Understand the root allowlist before editing the caller

1. In the reusable file, locate the job's `ROOT` environment mapping from `inputs.root`.
2. Locate the step that runs `test "$ROOT" = module` before the learner helper.
3. Explain why the quoted variable and equality guard reject every value except `module`, including paths outside the root and shell fragments.
4. Keep the guard before the helper. Do not interpolate untrusted input directly into a shell command or allow arbitrary working directories.
5. Keep `persist-credentials: false` on checkout. The local helper chooses the Lab 06 module and uses no Azure credentials or state.

These are the relevant starter fragments, not replacements for the complete workflow:

```yaml
env:
  ROOT: ${{ inputs.root }}
```

```yaml
- run: test "$ROOT" = module
- run: node scripts/check-learner.mjs
```

**Expected result:** an explicit typed interface and a runtime allowlist. `type: string` alone does not make arbitrary strings safe.

## 3. Replace the caller's inline job with a job-level call

1. Press **Ctrl+P**, open `exercises/reusable-caller.yml.example`, and read the short supplied caller.
2. Open `.github/workflows/lab-checks.yml` with **Ctrl+P**.
3. Replace its initial inline validation workflow with the supplied caller below, preserving the event and permission declarations:

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

4. Notice that `uses` is alongside the job's `name`, not nested beneath `steps`.
5. The calling job has no `runs-on` or `steps`; the reusable workflow owns them. Do not combine both job shapes.
6. Press **Ctrl+S** for both files. Keep the destinations under the real workflow directory, not only under the examples directory.
7. Check neither file contains `TODO`, `id-token: write`, `secrets.`, `secrets: inherit`, or `pull_request_target:`.

Do not add Azure login, environment secrets, a backend, a trusted runner, or an elevated token.
If later adding jobs, use `needs` for a genuine dependency, not to turn skipped or failed validation into success.

## 4. Review the two-file change, commit, and push

1. Open **Source Control** and select each workflow under **Changes** to inspect the entire diff.
2. Verify the reusable file retains checkout, Node/Terraform setup, the allowlist, and the real learner helper; verify the caller supplies only `root: module`.
3. Select each intended file's **+**, inspect **Staged Changes**, and enter `lab: reuse typed module validation` in **Message**.
4. Select **Commit**, then **...** → **Push**. If the task branch was never published, choose **Publish Branch** to your copy's existing `origin`.
5. Refresh GitHub **Code**, choose `lab/ci`, and open the newest commit to confirm both workflows and its SHA.

![Microsoft reference showing the commit message field and Commit button](../docs/images/vscode-commit.png)

*REFERENCE — Microsoft publisher example, CC BY 3.0 US. Its files, repository, message, and branch are examples, not your actual change. [Sources and attribution](../docs/images/NOTICE.md).*

## 5. Follow the real nested validation job

1. Open your private copy's **Actions** → **Lab checks**.
2. Select the push run for `lab/ci` at the SHA just verified, not an older inline-workflow run.
3. Open the called validation job. GitHub may label it **Validate learner code / Validate**.
4. Expand the allowlist step, then the learner helper step. Confirm both executed successfully and tests were not empty or skipped.
5. Open the draft PR's **Checks** tab and confirm current-head association. A temporary PR merge SHA can differ from the branch SHA; the push run is the direct branch comparison.
6. Refresh the existing **Exercise** issue body after the guide processes the push and checks.

## Expected result and precise gate

AgentAlvine checks the required string `root` interface, read-only reusable workflow, and actual local job-level caller with `root: module`.
Both workflows must lack the forbidden credential/privileged-PR patterns and unfinished text.
The final step requires the **complete caller workflow** to pass; a file named like a reusable workflow or a guessed nested job label does not prove it was invoked.

## Stuck?

- **Unexpected `uses` or `runs-on` error:** compare job indentation and remove the old inline job fields, not permission boundaries.
- **Input missing or invalid:** preserve `required: true` and supply exactly `module`; never widen the allowlist to pass.
- **Editor flags the nested workflow:** inspect the real GitHub diagnostic before deciding; an editor warning is not proof that a real run passed or failed.
- **No nested test execution:** inspect the caller and actual current-SHA run. Do not accept a skipped job or solution-only test.

Optional Copilot **Ask** question: “Read these two workflows without editing or running anything. Explain the job-level call and why only `module` is allowed; identify any credential escalation.”

**Full beginner help:** [start-here.md](../docs/start-here.md) · [git-workflow.md](../docs/git-workflow.md) · [copilot-guide.md](../docs/copilot-guide.md) · [toolchain.md](../docs/toolchain.md) · [troubleshooting.md](../docs/troubleshooting.md).
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified.** The typed `root` interface and job-level reusable caller were accepted; real nested validation execution was proved in the original private evidence.
- **Cycle B: verified.** The fresh copy independently exercised the nested CI route while retaining the `module` allowlist and credential-free boundary.
- A reusable filename alone is not invocation proof. Original job/run URLs remain in the private review, separate from the public source preview.

See [simulation.md](simulation.md) for original evidence and whole-lab totals, not a per-activity allocation of test counts.

[Previous activity](activity-02.md) · [Review index](README.md) · [Next activity](activity-04.md)
