# Forensic Report — Case DFIR-2026-001

**Classification:** Training exercise / Internal
**Examiner:** TBD
**Date of report:** TBD
**Evidence covered:** E001 (memory), E002 (disk), E003–E004 (logs)

---

## 1. Executive Summary
A single-paragraph, non-technical summary a manager can read: what happened, what was confirmed, and
the bottom line. Written **last**, after findings. `TBD`

## 2. Scope & Authorisation
- **Scope:** forensic analysis of the VICTIM endpoint (10.10.10.10) following a detected credential-
  access alert, within an isolated lab the examiner owns.
- **Authorisation:** self-authorised training exercise on owned equipment.
- **Limitations:** single endpoint; simulated adversary (Atomic Red Team T1003.001).

## 3. Methodology
NIST SP 800-61 lifecycle. Tools: Sysmon + Wazuh (detection); FTK Imager (acquisition);
Volatility 3 (memory); Autopsy + Sleuth Kit (disk); Plaso (timeline). Integrity enforced with SHA-256
at acquisition and before analysis; all analysis on working copies.

## 4. Findings
Each finding: **observation → evidence reference → interpretation.**
- **F1 — Detection:** `TBD` (Sysmon EID 10 / Wazuh rule, with timestamp).
- **F2 — Memory:** `TBD` (dumping process + handle to lsass.exe; cite findings-memory.md).
- **F3 — Disk:** `TBD` (tool execution, dump file, user attribution; cite findings-disk.md).
- **F4 — Timeline:** `TBD` (ordered sequence; cite timeline-summary.md).

## 5. Indicators of Compromise
See [iocs.csv](iocs.csv). Summarise the key ones here: `TBD`.

## 6. Timeline of Events
See [timeline-summary.md](timeline-summary.md) for the narrative; key rows: `TBD`.

## 7. Containment, Eradication & Recovery (simulated)
What a responder would do: isolate the host, kill the process, rotate exposed credentials, restore
from the clean baseline snapshot, and add/confirm the detection rule. `TBD`

## 8. Conclusion
`TBD` — did the evidence confirm T1003.001 credential access? Confidence level and reasoning.

## 9. Appendices
- Evidence manifest: [../03-evidence/evidence-manifest.csv](../03-evidence/evidence-manifest.csv)
- Chain of custody: [../03-evidence/evidence-metadata.md](../03-evidence/evidence-metadata.md)
- Commands run: Volatility, Autopsy, Plaso (see `04-analysis/`)
- Screenshots: `TBD` (attach alert + key tool output)
