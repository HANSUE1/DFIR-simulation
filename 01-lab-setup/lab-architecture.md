# Lab Architecture — Case DFIR-2026-001

## Objective (NIST Phase 0: Preparation)

Build a **completely isolated** virtual range so a simulated attack can generate realistic forensic
artifacts without any risk of leaking to the internet or the host network, and establish a known-good
baseline to compare against.

## Host requirements

| Item | Minimum | Notes |
|---|---|---|
| Hypervisor | VirtualBox 7.x **or** VMware Workstation 17 | Type-2, on the physical PC |
| Host RAM | 16 GB | 3 VMs run at once; 32 GB is comfortable |
| Host disk | 250 GB free | Images are large; keep them off the system drive if possible |
| CPU | 4+ cores with virtualization (VT-x/AMD-V) enabled in BIOS | |

## Virtual machines

| VM | OS | vCPU | RAM | Disk | IP | Role |
|---|---|---|---|---|---|---|
| **VICTIM** | Windows 10 (22H2) | 2 | 4 GB | 60 GB | 10.10.10.10 | Target endpoint. Runs Sysmon + Wazuh agent. |
| **ATTACKER** | Kali Linux (latest) | 2 | 4 GB | 40 GB | 10.10.10.20 | Launch point. Metasploit, Atomic runner. |
| **SIEM/SIFT** | Ubuntu 22.04 + SIFT | 2 | 6 GB | 80 GB | 10.10.10.30 | Wazuh Manager + analysis tools (Volatility, Autopsy, Plaso). |

> If RAM is tight, run the attack phase (VICTIM + ATTACKER) and the analysis phase (SIEM/SIFT) at
> different times rather than all three together.

## Network — isolation is the whole point

- One **Host-Only** (VirtualBox) or **Host-only / Internal** (VMware) adapter, subnet **10.10.10.0/24**.
- **No NAT, no Bridged adapter on any VM.** There must be no route to the internet or the physical LAN.
- Static IPs as in the table above. No DHCP leakage from the host.
- Verify isolation before starting: from VICTIM, `ping 8.8.8.8` must fail; `ping 10.10.10.30` must succeed.

```
            Host-Only vSwitch  —  10.10.10.0/24  (no gateway, no DNS to WAN)
            ┌───────────────┬───────────────┬───────────────┐
         VICTIM .10      ATTACKER .20     SIEM/SIFT .30
      Win10 + Sysmon     Kali + Atomic    Wazuh + Volatility
        + Wazuh agent                       + Autopsy + Plaso
```

See [network-diagram.png](network-diagram.png) for the visual (export it from the `docs/` site or draw
it in draw.io). <!-- TBD: add the exported diagram image -->

## Baselines (do this BEFORE the attack)

1. Install and fully configure every VM.
2. Install Sysmon + Wazuh agent on VICTIM; confirm logs reach the Wazuh Manager.
3. **Snapshot every VM** and name it `baseline-clean-YYYY-MM-DD`. This is the "known good" state.
4. Record the baseline snapshot IDs in [../03-evidence/evidence-metadata.md](../03-evidence/evidence-metadata.md).

A snapshot taken *after* configuration but *before* the attack lets you (a) prove what changed and
(b) reset the range to re-run the exercise cleanly.

## Next

Install the telemetry and tools: [tool-installation.md](tool-installation.md).
