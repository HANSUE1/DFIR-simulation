# Memory Forensics — Findings (E001)

> Fill each section from the real Volatility output. Do not write a finding you have not observed.
> Paste the relevant command output and a one-line interpretation under each heading.

## Image info
- OS build: `TBD`
- Acquisition verified against manifest SHA-256: `TBD`

## Suspicious processes
`TBD` — list PID, name, parent, command line. Note anything in `psscan` but not `pslist`.

## LSASS access (the T1003.001 signature)
`TBD` — which process held a handle to `lsass.exe`, with what access mask.

## Injected memory (malfind)
`TBD`

## Network artifacts (netscan)
`TBD`

## Extracted IOCs
`TBD` — process names, hashes of dumped binaries, IPs. Mirror these into
[../../05-reporting/iocs.csv](../../05-reporting/iocs.csv).

## Interpretation
`TBD` — in plain English: what the memory shows the attacker did.
