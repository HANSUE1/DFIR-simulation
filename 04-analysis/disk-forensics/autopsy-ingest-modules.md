# Autopsy — Ingest Modules Used (E002)

Open the **working copy** of the E01 in a new Autopsy case (`Case → New Case → DFIR-2026-001`), add
`working-copies/E002-disk.E01` as a *Disk Image* data source, and enable these ingest modules.

| Module | Why it matters for this case |
|---|---|
| **Recent Activity** | Parses Windows artifacts: run/executed programs, USB, accounts — ties tooling to a user. |
| **Hash Lookup** | Flags known-bad files; add the hashes of any dumped binaries here. |
| **File Type Identification** | Correct typing so other modules parse correctly. |
| **Extension Mismatch Detector** | Catches a tool renamed to hide (e.g. `.txt` that is really a PE). |
| **Keyword Search** | Search for `lsass`, the dump filename, tool names, `mimikatz`, etc. |
| **Windows Event Logs** (via plugins / parse EVTX) | Security, Sysmon, PowerShell operational logs on disk. |
| **PhotoRec / Carving (PhotoRec Carver)** | Recover deleted files — a dump file the attacker removed. |
| **Prefetch** | Evidence a program executed, with run count and last-run time. |

## Procedure
1. Create the case, add the data source (verify Autopsy's hash matches the manifest).
2. Enable the modules above; run ingest.
3. Review in this order: **Prefetch** (did the tooling run?) → **Recent Activity** (which user?) →
   **Keyword Search** (`lsass`, dump filename) → **Carving** (deleted dump) → **Event Logs**.
4. Tag findings in Autopsy and export the tagged-results report.
5. Record file paths, MAC times, and hashes in [findings-disk.md](findings-disk.md).
