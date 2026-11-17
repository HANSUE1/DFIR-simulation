# Evidence & Chain of Custody — Case DFIR-2026-001

## NIST Phase 2 (part 1): Evidence Acquisition

> **Golden rule:** acquire the most volatile evidence first (RAM), never work on originals, and prove
> integrity with hashes at the moment of acquisition.

## Order of volatility
1. **RAM** (E001) — captured *before* the VM is powered off, while the dumping process may still be resident.
2. **Disk** (E002) — bit-for-bit image after memory is safe.
3. **Logs** (E003/E004) — exported from the frozen system and the SIEM.

## Acquisition method

### Memory (E001)
- Tool: **FTK Imager** (*File → Capture Memory*) or **DumpIt**, run from a read-only USB/share.
- Output: `03-evidence/original/E001-memory.mem` (git-ignored).
- Immediately: `Get-FileHash E001-memory.mem -Algorithm SHA256` → record in the manifest.

### Disk (E002)
- Tool: **FTK Imager**, *Create Disk Image → E01 (Expert Witness Format)*.
- E01 is chosen for built-in metadata + compression + stored verification hashes.
- FTK computes MD5/SHA1 during imaging; also compute **SHA-256** and record it in the manifest.

### Integrity verification (do every time, record the output)
```powershell
Get-FileHash .\03-evidence\original\E001-memory.mem -Algorithm SHA256
Get-FileHash .\03-evidence\original\E002-disk.E01   -Algorithm SHA256
```
Before any analysis, **copy** originals to `working-copies/` and re-hash the copy — the two hashes must
match. All analysis runs on the working copy; originals are never opened directly.

## Chain of custody log

| Timestamp (UTC) | Evidence | Action | Handler | Hash verified? |
|---|---|---|---|---|
| TBD | E001 | Acquired from VICTIM RAM | analyst | TBD |
| TBD | E001 | Copied to working-copies/, re-hashed | analyst | TBD |
| TBD | E002 | Acquired from VICTIM disk | analyst | TBD |
| TBD | E002 | Copied to working-copies/, re-hashed | analyst | TBD |

## Why the images are not in git
Evidence images are large and may contain credential material dumped from LSASS. They are excluded by
[`.gitignore`](../.gitignore). This repository documents the evidence and proves its integrity with
hashes; it does not distribute it.

## Baseline snapshots (from Phase 0)
| VM | Snapshot name | Snapshot ID |
|---|---|---|
| VICTIM | baseline-clean-YYYY-MM-DD | TBD |
| ATTACKER | baseline-clean-YYYY-MM-DD | TBD |
| SIEM/SIFT | baseline-clean-YYYY-MM-DD | TBD |
