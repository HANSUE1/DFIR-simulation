# DFIR Lab — Case DFIR-2026-001: Credential Access on a Windows Endpoint

A full-lifecycle digital forensics and incident response (DFIR) exercise run in an isolated home
lab, following the **NIST SP 800-61** phases. A simulated credential-access technique (MITRE ATT&CK
**T1003.001**, LSASS memory) is executed against a Windows victim, detected with Sysmon + Wazuh, then
acquired and analysed with Volatility 3, Autopsy, and Plaso, and written up as a defensible report.

> **Training exercise.** Every artifact here was produced in a host-only lab against machines I own.
> No real systems, people, or data are involved. Findings are recorded only after they are observed
> in the lab — nothing in the analysis or report templates is invented.

## The case at a glance

| | |
|---|---|
| **Case ID** | DFIR-2026-001 |
| **Framework** | NIST SP 800-61 (Preparation → Detection & Analysis → Containment/Eradication/Recovery → Post-Incident) |
| **Technique** | MITRE ATT&CK T1003.001 — OS Credential Dumping: LSASS Memory |
| **Simulation** | Atomic Red Team T1003.001 |
| **Detection** | Sysmon (Event ID 10, process access to `lsass.exe`) → Wazuh |
| **Acquisition** | FTK Imager — RAM (`.mem`) + disk (`.E01`), SHA-256 verified |
| **Analysis** | Volatility 3 (memory), Autopsy + Sleuth Kit (disk), Plaso/log2timeline (super-timeline) |

## Repository map

```
.
├── 01-lab-setup/         # VM specs, isolated network, tool install, baselines
├── 02-attack-simulation/ # The attack playbook + the exact Atomic script
├── 03-evidence/          # Evidence manifest + chain of custody (images are git-ignored)
├── 04-analysis/          # Memory, disk, and timeline findings
├── 05-reporting/         # The forensic report, IOCs, and executive timeline
├── 06-siem-detections/   # Sysmon config + Wazuh rules
└── docs/                 # GitHub Pages case site (static, animated)
```

Start at [01-lab-setup/lab-architecture.md](01-lab-setup/lab-architecture.md) and follow the numbered
folders in order — they are the engagement timeline.

## How to read this as a reviewer

1. **Setup** — how the range was built and isolated, and the baseline snapshots.
2. **Attack** — what was run, mapped to ATT&CK, reproducible from the script.
3. **Evidence** — what was collected, how, and the hashes that prove it is unaltered.
4. **Analysis** — the three analysis tracks and what each found.
5. **Report** — the deliverable: summary, findings, IOCs, timeline, conclusion.

## Status

Scaffold complete. Lab execution and real findings are filled in as the exercise is performed; every
file marked `TBD` is waiting on lab output.

---
*Isolated lab exercise. See [03-evidence/evidence-metadata.md](03-evidence/evidence-metadata.md) for the chain-of-custody narrative.*
