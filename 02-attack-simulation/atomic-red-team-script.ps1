# atomic-red-team-script.ps1
# Case DFIR-2026-001 — simulate MITRE ATT&CK T1003.001 (LSASS Memory) with Atomic Red Team.
#
# WHY this file exists: a reviewer must be able to reproduce the exact "crime" that the evidence
# captures. This is the single source of truth for what was run on VICTIM.
#
# SAFETY: run ONLY on the isolated VICTIM VM that you own. The test touches LSASS; it is a
# detection/forensics exercise, not something to run on any machine you rely on.
# Run from an elevated PowerShell. Record the real start/end times in attack-playbook.md.

Import-Module invoke-atomicredteam -Force

$technique = 'T1003.001'

# 1. Show what the atomics for this technique do BEFORE running — so the playbook can cite them.
Invoke-AtomicTest $technique -ShowDetailsBrief

# 2. Check prerequisites (some atomics need a tool like ProcDump staged first).
Invoke-AtomicTest $technique -GetPrereqs

# 3. Run the test(s). Pick the specific test number(s) you intend to run and pin them here so the
#    run is deterministic and documented. Example runs test #1; adjust after -ShowDetailsBrief.
#    shortcut: hard-coded to test 1; change -TestNumbers when you choose a different atomic.
$startUtc = (Get-Date).ToUniversalTime()
Invoke-AtomicTest $technique -TestNumbers 1

$endUtc = (Get-Date).ToUniversalTime()
Write-Host "T1003.001 run window (UTC): $startUtc  ->  $endUtc"
Write-Host "Record this window in 02-attack-simulation/attack-playbook.md"

# 4. Do NOT auto-clean yet: the artifacts are the point. Acquire memory + disk first (Phase 2),
#    THEN optionally clean:
#    Invoke-AtomicTest $technique -TestNumbers 1 -Cleanup
