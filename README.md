# Laboratory 06 · GitHub Actions and reusable validation

**Public source template (not the clone URL after copying):** [alvinea28/ws2-github-actions-ci-laboratory-06](https://github.com/alvinea28/ws2-github-actions-ci-laboratory-06) · **Recommended order:** 06 of 08 · **Time:** 75–105 minutes

**Goal:** build push/PR checks, repair real red CI and reuse validation. **This lab is independent:** module, mocks and starters included; no earlier lab or Azure account.

## Start once

1. **Account:** GitHub → **Sign up** (verify email) or sign in; accept any assigned organization invitation.
2. **Install:** [Git, desktop VS Code and toolchain](docs/toolchain.md): Node **24.16.0**, Terraform **1.16.1**, pinned AzureRM **5.4.0**. Restart VS Code.
3. **Copy:** create one **Private** copy below with **-laboratory-06** suffix; reuse an existing copy.
4. **Clone/open:** from **your copy**, copy **Code → HTTPS**. VS Code: **Ctrl+Shift+P → Git: Clone** (macOS **Cmd**), paste **your own URL**, choose a parent folder, then **Open** the clone. Trust only it; Explorer must show the clone root.
5. **Setup:** [Git authorship/Copilot account checks](docs/start-here.md); then **Terminal → New Terminal** at the clone root:

```powershell
node scripts/doctor.mjs
```

**Why:** Node runs the read-only doctor, without flags; it cannot certify sign-in/seat. **Expected:** no errors; **stop** for [setup recovery](docs/troubleshooting.md).

Open **your copy's Exercise**. **Save → stage → commit → push → refresh the same Exercise** ([Git guide](docs/git-workflow.md)). AgentAlvine updates it automatically; never edit progress.

![Microsoft reference: cloning from GitHub in VS Code](docs/images/vscode-clone-github.png)

*REFERENCE — Microsoft, CC BY 3.0 US; not your account/repository. [Attribution](docs/images/NOTICE.md).*

<!-- AGENTALVINE:START -->
## Copy this exercise once

[![Copy exercise](.github/images/copy-exercise.svg)](https://github.com/new?template_owner=alvinea28&template_name=ws2-github-actions-ci-laboratory-06&owner=%40me&name=my-ws2-github-actions-ci-laboratory-06&visibility=private)

Select the intended Owner, keep **Private**, leave **Include all branches** off, and create the copy. Its own AgentAlvine issue will appear automatically.
<!-- AGENTALVINE:END -->

## Review and boundaries

[Complete lessons and historical A/B outcomes](full-ws-content/README.md) · [Read-only public Exercise preview](https://github.com/alvinea28/ws2-github-actions-ci-laboratory-06/issues/1), not learner progress.

**Additional hands-on:** [Defender DevOps: scan, inspect, repair and rescan](docs/defender-devops-hands-on.md). Requires separate Azure/connector authorization; not historical A/B proof, an automatic grade or deployment approval.

**Credential-free:** retain read-only permissions, action SHAs and mocks; no Azure/OIDC/state/secrets in PR validation. Never merge the deliberate red revision. Completion needs current caller CI, not deployment.

Optional [Azure inputs](docs/azure-setup.md#1-find-the-three-values-before-opening-the-terminal) · [login/RG check](docs/azure-setup.md#4-reuse-an-existing-login-or-sign-in-when-required) are preparation, not protected live approval. Lab 06 requires no merge.

[All laboratories](https://github.com/alvinea28/ws2-workshop-catalogue) · [Copilot help](docs/copilot-guide.md) · [Glossary](docs/glossary.md) · [MIT license](LICENSE)
