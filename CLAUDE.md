# CLAUDE.md — working rules for this repo

## Always give comments
For every prompt in this repo, end the reply with a **Comments** section that covers:
- what changed (files touched) and why,
- what was skipped or not checked,
- what the user must do by hand in the lab (VMs, acquisition, screenshots).

New scripts and config files carry short inline comments that explain *why*, not *what*.

## Case-file rules
- Never commit evidence: `*.E01`, `*.raw`, `*.mem`, `*.vmem`, `*.plaso`, `03-evidence/original/`, `03-evidence/working-copies/`.
- Findings are never invented. Templates hold `TBD` markers until the user records real results from the lab.
- Every evidence item gets a SHA-256 in `03-evidence/evidence-manifest.csv` at acquisition time, and that hash is re-verified before analysis.
- The `docs/` folder is the GitHub Pages case site (static HTML + GSAP, no build step).

## Skills used here
ponytail (smallest change), superpowers (plan → verify), impeccable + taste-skill (the `docs/` site), gsap (motion on the site).
