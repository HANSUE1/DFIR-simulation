# Plaso / log2timeline — Super-Timeline Workflow

A **super-timeline** fuses timestamps from the file system (MACB), registry, EVTX logs, Prefetch, and
more into one chronological view, so the attacker's actions can be read step by step.

Run on the **working copy** of the disk image on SIFT.

## 1. Extract events → .plaso
```bash
log2timeline.py --storage-file timeline.plaso \
  ../../03-evidence/working-copies/E002-disk.E01
# Narrow to Windows artifacts for speed if needed:
#   log2timeline.py --parsers "win7,winevtx,prefetch,filestat" --storage-file timeline.plaso <image>
```

## 2. (Optional) Add the memory-derived and SIEM events
Keep the SIEM export (E004) handy to correlate; Plaso handles the disk side.

## 3. Export → CSV
```bash
psort.py -o dynamic -w super-timeline.csv timeline.plaso
# Filter to the attack window to keep it readable (adjust the dates to your run):
psort.py -o dynamic -w super-timeline.csv timeline.plaso \
  "date > '2026-01-01 00:00:00' AND date < '2026-01-01 23:59:59'"
```

## 4. Analyse
- Open `super-timeline.csv` and jump to the attack window recorded in
  [../../02-attack-simulation/attack-playbook.md](../../02-attack-simulation/attack-playbook.md).
- Line up: tool execution (Prefetch) → LSASS access (Sysmon) → dump file created (filestat) → cleanup.
- Pull the key rows into [../../05-reporting/timeline-summary.md](../../05-reporting/timeline-summary.md).

> `timeline.plaso` and the full `super-timeline.csv` are git-ignored if large. Commit only a
> **sanitised / filtered** CSV of the relevant window.
