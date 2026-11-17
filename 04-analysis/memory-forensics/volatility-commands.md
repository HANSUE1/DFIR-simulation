# Volatility 3 — Commands Run (E001)

All commands run against the **working copy** of the memory image, never the original.

```bash
IMG=../../03-evidence/working-copies/E001-memory.mem
```

| Plugin | Command | Purpose |
|---|---|---|
| Image info | `vol -f $IMG windows.info` | Confirm OS build / profile so later plugins parse correctly. |
| Process list | `vol -f $IMG windows.pslist` | Processes seen via the kernel's active list. |
| Process scan | `vol -f $IMG windows.psscan` | Finds processes by pool scan — catches hidden/terminated ones `pslist` misses. |
| Process tree | `vol -f $IMG windows.pstree` | Parent/child lineage — spot a suspicious child of a normal process. |
| Command lines | `vol -f $IMG windows.cmdline` | Full command line of each process — catches the dumping command. |
| Handles to LSASS | `vol -f $IMG windows.handles --pid <lsass_pid>` | Who held a handle to lsass.exe (the credential-access tell). |
| DLL list | `vol -f $IMG windows.dlllist --pid <suspect_pid>` | Modules loaded by the suspect process. |
| Malfind | `vol -f $IMG windows.malfind` | Injected/executable private memory — classic injection finder. |
| Network | `vol -f $IMG windows.netscan` | Connections/listeners — any C2 or lateral movement. |
| Dump a process | `vol -f $IMG windows.pslist --pid <pid> --dump` | Carve the suspect process for hashing / AV / strings. |

## Procedure
1. Run `windows.info` first; record the build.
2. `pslist` → `psscan` → `pstree`, comparing results. Note any PID in `psscan` but not `pslist`.
3. `cmdline` across all PIDs; flag anything matching the Atomic tooling.
4. Find the `lsass.exe` PID, then `handles` across processes for handles **to** that PID with
   read access — that is the T1003.001 signature in memory.
5. `malfind` and `netscan` for injection and network IOCs.
6. Dump any suspect process; SHA-256 it and add it to [../../05-reporting/iocs.csv](../../05-reporting/iocs.csv).

Record what each command actually returned in [findings-memory.md](findings-memory.md).
