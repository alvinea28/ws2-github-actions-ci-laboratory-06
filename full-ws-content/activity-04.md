# Lab 06 · Activity 04 — Explain safe promotion and finish CI

[Review index](README.md) · [Previous activity](activity-03.md) · [Setup](00-start-here.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress.

<!-- FULL-WS-LESSON:START -->
# Lab 06 · Step 4 — Explain safe promotion and finish current-revision CI

| Before you start | This step |
| --- | --- |
| Goal | Separate reusable validation from environment-specific deployment decisions |
| Start / working branch | Continue `lab/ci`, with the typed reusable caller in place |
| Edit | [exercise/promotion.md](../exercise/promotion.md) only |
| Inspect | [.github/workflows/lab-checks.yml](README.md#learner-created-workflows) and [.github/workflows/validate.yml](README.md#learner-created-workflows) |
| Required phrases | `fresh plan`, `separate state`, `dev-only` |
| Completion check | Successful **Lab checks** caller at the newest pushed SHA |
| Tools | Node **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**; credential-free mocks only |

You have reused **checks**, not an Azure identity, state backend, or saved plan.
Promotion to another environment is a design discussion in this lab. Do not create test, staging, or production infrastructure to demonstrate it.

## 1. Open the note in the correct clone

1. Return to desktop VS Code and confirm this private Lab 06 clone in **Explorer**.
2. Check that the status bar says `lab/ci`; do not switch to the public template or default branch to make the edit.
3. Press **Ctrl+P**, enter `exercise/promotion.md`, and open it.
4. If the requested note is missing, use **Explorer** → **New File** at this clone's root and enter the same path.
5. Read the starter before replacing its unfinished text; remove every `TODO`.

## 2. Write three concrete decisions

Use the following Markdown structure, keeping the three exact lowercase phrases and explaining each in your own words:

```markdown
# Promotion decisions

- fresh plan: a hypothetical next environment plans its own approved inputs
  and reviewed revision; a saved dev plan is not replayed elsewhere.
- separate state: each environment needs its own explicit state boundary,
  scoped identity, locking, and ownership; a name alone is not isolation.
- dev-only: this workshop permits live work only in an instructor-approved
  private Lab 7 delivery copy after its independent controls are ready.

The reusable workflow provides credential-free validation, not deployment
authorization. This Lab 6 copy receives no Azure identity, backend, secrets,
or extra deployment workflow. Test, staging, and production are not deployed.
```

1. Explain why a saved plan binds a particular revision, input set, dependency selection, environment, and state rather than a generic instruction to create a network.
2. Explain that another environment would need a **fresh plan** and its own review; “the dev checks passed” is not permission to apply there.
3. Explain **separate state** without suggesting a second writer for the same state. GitHub concurrency is repository-scoped, not a cross-repository lock.
4. State **dev-only** explicitly. Lab 06 must remain without Azure/OIDC/state access.
5. Press **Ctrl+S** and verify the editor's unsaved dot disappears.

### Questions you should be able to answer

| Question | Contract-preserving answer |
| --- | --- |
| Can a passing reusable workflow approve a deployment? | No; validation and independent deployment approval are different gates |
| Can the same saved dev plan be used in production? | No; a new environment requires its own approved inputs, state, fresh plan, and review |
| Is a different branch sufficient state isolation? | No; explicit scoped backend/state ownership is necessary |
| Should this copy get credentials to practice promotion? | No; this is a credential-free design exercise |
| Must Lab 07 be completed to finish Lab 06? | No; numbered order is recommended, not a dependency |

## 3. Check locally, then inspect what will be committed

1. Select **Terminal** → **New Terminal** and verify the prompt identifies this clone's root.
2. Run the approved local check, keeping the supplied provider lock and mocks intact:

```powershell
node scripts/check-learner.mjs
```

3. Read the actual executed test summary. If formatting, validation, or tests fail, correct the named task behavior; do not remove assertions or pretend skipped cases passed.
4. Open **Source Control** and select the promotion note under **Changes**.
5. Read the complete diff. Confirm there are no added secrets, backend settings, Azure workflows, or unrelated changes.
6. Select the note's **+**, inspect **Staged Changes**, enter `lab: explain safe environment promotion`, and select **Commit**.
7. Select **...** → **Push**, or **Publish Branch** to the existing own-copy `origin` only if this task branch is still unpublished.

## 4. Verify the complete caller workflow on the newest SHA

1. In the browser, refresh **your copy's Code** page and select `lab/ci`.
2. Open the newest commit. Confirm its message and promotion-note content match the work you just pushed.
3. Open **Actions** → **Lab checks** and select the push run at this exact branch SHA.
4. Inspect the workflow graph and open the called validation job, often **Validate learner code / Validate**.
5. Confirm the root allowlist and learner helper ran, using the supplied pinned tools and provider-mocked tests.
6. Wait for the **whole Lab checks caller workflow** to conclude successfully. A green setup step or separate reusable file is not sufficient.
7. Open **Pull requests** → your draft PR → **Checks** and confirm the newest PR head is associated with those checks.
8. Refresh the existing **Exercise** issue body after the workflow completion event reaches AgentAlvine.

![GitHub reference highlighting the Actions tab](../docs/images/github-actions.webp)

*REFERENCE — GitHub publisher example, CC BY 4.0. Repository names and badges are not your result; inspect your private copy's current run. [Sources and attribution](../docs/images/NOTICE.md).*

## Expected result and precise gate

- The promotion note contains `fresh plan`, `separate state`, and `dev-only`, with no unfinished `TODO`.
- The actual **Lab checks** caller succeeds at the latest observed pushed SHA, after the course started.
- The real caller invokes the reusable validation and tests your learner code. An old green SHA, empty test run, skipped job, or solution-only test does not satisfy current validation.
- AgentAlvine updates the same issue automatically; no manual check command, run-ID submission, evidence PR, or checkbox edit is needed.
- A merge is not required by this step's completion gate. Any later merge follows your copy's normal review rules; never merge the earlier intentional red revision.

## Stuck?

If a new note commit has no green run, first compare the branch and SHA, then read the current job's first meaningful failure.
If the nested workflow is not invoked, check the job-level `uses` and exact `root: module` rather than loosening the input contract.
Do not use `continue-on-error`, skipped tests, write tokens, or secret inheritance as a repair.
If policy blocks the supplied pinned actions, ask the instructor instead of enabling every action or changing public/private visibility.

Optional Copilot **Ask** prompt: “Read this promotion note and identify any place it confuses reusable checks with state, planning, or independent approval. Do not edit, execute, or access Azure.”

**Full beginner help:** [start-here.md](../docs/start-here.md) · [git-workflow.md](../docs/git-workflow.md) · [copilot-guide.md](../docs/copilot-guide.md) · [toolchain.md](../docs/toolchain.md) · [troubleshooting.md](../docs/troubleshooting.md).

Optional next topic: [public Lab 07](https://github.com/alvinea28/ws2-azure-delivery-laboratory-07). That link is a template to study or copy, **not** your authorized live writer; its offline route requires no earlier lab.
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified.** The promotion note and successful current-revision caller completed the original private Exercise at **4/4**.
- **Cycle B: verified.** The fresh copy independently completed all four activities with the actual nested credential-free CI route.
- Promotion remained a design exercise: no Azure identity, remote state, or test/staging/production deployment was added. A merge was not this activity's completion gate.

See [simulation.md](simulation.md) for original private run links, whole-lab totals, and pending new capture verification.

[Previous activity](activity-03.md) · [Review index](README.md)
