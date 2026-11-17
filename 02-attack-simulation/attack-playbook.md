# Attack Playbook — T1003.001 (LSASS Memory)

## NIST Phase 1: Attack Simulation ("the crime")

**Goal:** generate real, observable forensic artifacts for a single, well-scoped technique so the
investigation has something genuine to find.

## Technique

| | |
|---|---|
| **Tactic** | Credential Access (TA0006) |
| **Technique** | T1003 — OS Credential Dumping |
| **Sub-technique** | T1003.001 — LSASS Memory |
| **Simulator** | Atomic Red Team, test(s) under T1003.001 |
| **Expected detection** | Sysmon Event ID 10 (ProcessAccess) targeting `lsass.exe` with high-risk access rights (e.g. `0x1010`, `0x1410`) |

### Why this technique
LSASS holds credential material in memory. Dumping it is one of the most common real-world steps after
initial access, it is cleanly covered by Atomic Red Team, and it leaves artifacts in **all three**
places this lab analyses: memory (the dumping process + handles), disk (any dump file written,
prefetch, event logs), and SIEM telemetry (Sysmon 10). That makes it ideal for a lifecycle exercise.

## Pre-conditions
- Baseline snapshots taken (see Phase 0).
- Wazuh showing the VICTIM agent active.
- You are running on a machine you own, in the isolated network, with the Wazuh dashboard open on a
  second screen so you can watch the alert fire.

## Execution steps (record the real timestamps as you go)

| # | Time (UTC) | Actor | Action |
|---|---|---|---|
| 1 | `TBD` | Analyst | Confirm isolation (`ping 8.8.8.8` fails from VICTIM). |
| 2 | `TBD` | Attacker | Run the Atomic test — see [atomic-red-team-script.ps1](atomic-red-team-script.ps1). |
| 3 | `TBD` | SOC | Observe Sysmon EID 10 / Wazuh alert; screenshot it. |
| 4 | `TBD` | Analyst | **Freeze the VM** (do not power off) to preserve memory for acquisition. |

> Fill the `Time (UTC)` column from the actual run. These timestamps are what you later line up against
> the super-timeline in Phase 2 — they are your ground truth.

## Expected artifacts to hunt for in Phase 2
- **Memory:** the dumping process (e.g. a PowerShell or tool process), a handle to `lsass.exe`, any
  injected or suspicious modules.
- **Disk:** a credential dump file if the test writes one, Prefetch entries for the tools, Security /
  Sysmon EVTX entries, PowerShell operational logs.
- **SIEM:** Sysmon EID 10, plus process-creation (EID 1) for the tooling.

## Cleanup / re-run
Revert VICTIM to `baseline-clean` to run again. Keep acquired images from each run under a distinct
evidence ID.
