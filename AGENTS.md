# Working agreement — Academy Awards SQL

Effective 2026-10-17, by Dalton's explicit instruction. This is a data-only
repository, separate from the live Theme and Oscars Ledger plugin.

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
SQL is not authorization to execute it against any shared database. Applying
data or changing production needs a separate explicit instruction. This policy
does not add this repository to the active WordPress deployment set.

When resuming an old branch, read the current default-branch agreement.
Historical notes do not override current merge authority. Feature/editorial
decisions and credentials remain separate from source-control permission.
