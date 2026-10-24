# Working agreement — Academy Awards SQL

Effective 2026-10-17, by Dalton's explicit instruction. This is a data-only
repository, separate from the live Theme and Oscars Ledger plugin.

## Dalton's confirmation — effective 2026-10-23

Dalton's confirmation of a website implementation task (for example "yes",
"go ahead", "do it" or "begin/create it") authorizes the requested work through
task-branch commits, PRs, passing checks, agent merge, manual deployment and
live verification. Do not ask for a second deployment confirmation or require
a new approval naming the final version. Reuse the confirmation in the current
conversation; instructions to hold, prepare only, leave a draft, or not deploy
take precedence. Ask only about a real missing decision, access, changed
destination or work beyond that confirmed scope.

Keep branch protections, required CI and exact-head PR merges. Manual
deployment means the agent uses the existing host action; it does not mean
Dalton must click it. Auto-deploy stays off unless he specifically changes it.
A confirmation never makes a merge evidence of deployment: verify and report
both states separately.

## Agent merge authority

Agents have standing permission to commit, push, open/update PRs and merge
completed, verified work within Dalton's approved task. Do not require Dalton
to click Merge or reconfirm a routine merge. An explicit instruction to hold a
particular PR takes precedence. Follow the shared
[Lunara merge policy](https://github.com/Lunara-Film/lunara-theme-blocks/blob/main/docs/AGENT-MERGE-POLICY.md).

- Branch from current `main`; never commit directly to main.
- Review the complete diff, identify the exact repository/base/PR/head SHA,
  and preserve unrelated drafts and unfinished work.
- Run relevant validation and any applicable CI for the final candidate.
  This repository has no CI workflow as of this agreement; disclose that fact
  and record local verification rather than claiming CI passed. Data changes
  need appropriate SQL/schema/integrity checks in an isolated local database.
  Documentation-only changes need a diff and link review, not database writes.
- Merge through the PR with an exact-head guard and a supported merge method.
  Do not bypass protections, weaken checks or force push. Read back the merged
  commit and verify any main checks. Do not merge branches back and forth just
  to change ahead/behind counts.
- Record the result in the shared Theme `docs/SESSION-LOG.md`; preserve history.

## Data and deployment boundary

Preserve canonical records, sources and existing migration ordering. Merging
SQL alone is not authorization to execute it against a shared database.
Dalton's task confirmation must include that data application and its target;
when it does, do not request the same approval again. A website implementation
confirmation does not authorize unrelated database writes. This policy does
not add this repository to the active WordPress deployment set.

When resuming an old branch, read the current default-branch agreement.
Historical notes do not override current merge authority. Feature/editorial
decisions and credentials remain separate from source-control permission.
