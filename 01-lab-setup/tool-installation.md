# Tool Installation

Order matters: telemetry on the victim first, then the collector, then confirm logs flow, *then*
snapshot, *then* attack.

## On VICTIM (Windows 10)

### 1. Sysmon (Sysinternals) + SwiftOnSecurity config
```powershell
# Download Sysmon from https://learn.microsoft.com/sysinternals/downloads/sysmon
# Download the SwiftOnSecurity config: https://github.com/SwiftOnSecurity/sysmon-config
.\Sysmon64.exe -accepteula -i sysmonconfig-export.xml
# Verify the service is running and logging:
Get-Service Sysmon64
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 5
```
The config used in this case is copied to [../06-siem-detections/sysmon-config.xml](../06-siem-detections/sysmon-config.xml).
Event **ID 10 (ProcessAccess)** is the one that catches LSASS credential access.

### 2. Wazuh agent
```powershell
# Install the agent and point it at the Wazuh Manager on 10.10.10.30
# (installer from https://documentation.wazuh.com/current/installation-guide/)
# After install, set the manager IP in C:\Program Files (x86)\ossec-agent\ossec.conf  ->  <address>10.10.10.30</address>
# Forward the Sysmon channel by adding to ossec.conf:
#   <localfile><location>Microsoft-Windows-Sysmon/Operational</location><log_format>eventchannel</log_format></localfile>
net start WazuhSvc
```

## On SIEM/SIFT (Ubuntu + SIFT)

### 3. Wazuh Manager + dashboard
```bash
# Quick single-host install (lab only — not production hardening):
curl -sO https://packages.wazuh.com/4.x/wazuh-install.sh
sudo bash ./wazuh-install.sh -a
# Dashboard: https://10.10.10.30 ; confirm the VICTIM agent shows "Active".
```

### 4. SIFT Workstation
SIFT ships Volatility 3, Autopsy, Sleuth Kit, and Plaso pre-installed. If starting from plain Ubuntu:
```bash
# SIFT installer:
wget https://raw.githubusercontent.com/teamdfir/sift-cli/main/sift && chmod +x sift && sudo ./sift install
# Spot-check the forensic tools:
vol --help            # Volatility 3
log2timeline.py --version
autopsy --version
```

## On ATTACKER (Kali)

### 5. Atomic Red Team
```powershell
# Atomics are cross-platform; run the T1003.001 test from PowerShell (pwsh on Kali, or on VICTIM).
# Install the execution framework (Invoke-AtomicRedTeam):
Install-Module -Name invoke-atomicredteam -Scope CurrentUser -Force
Import-Module invoke-atomicredteam
# Metasploit is pre-installed on Kali if an interactive shell is wanted instead.
```

## Verify, then snapshot

1. On VICTIM, trigger any process-creation event and confirm it appears in the Wazuh dashboard.
2. Only when logs flow end-to-end, take the `baseline-clean` snapshots (see
   [lab-architecture.md](lab-architecture.md)).
