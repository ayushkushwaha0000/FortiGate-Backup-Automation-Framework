# FortiGate Backup Automation (Tool-Independent)

A lightweight PowerShell automation framework for backing up configurations from FortiGate devices — without relying on third-party backup tools.
Designed for operational resilience, audit visibility, and DR/BCM environments.

# Why This Project?

Many firewall backup processes:
Depend on paid tools
Lack structured logging
Provide no clear failure tracking
Create audit and compliance gaps
This solution removes those limitations with a controlled, transparent automation approach.

# Key Features

Multi-device configuration backup

Sequential execution with configurable wait interval

Detailed execution logging

Dedicated failed-device tracking

Structured backup storage

Production-ready PowerShell script

# How It Works

Connects to defined FortiGate devices
Executes configuration backup
Stores backup in structured folders
Logs execution details
Records failed devices separately

# Folder Structure
FortiGate_Backup_With_Full_Logs.ps1
Backups/
Logs/

# Prerequisites

Windows OS
PowerShell 5.1+
Network access to FortiGate devices
Valid administrative credentials

# Usage
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\FortiGate_Backup_With_Full_Logs.ps1

# Business Impact

Reduces operational risk
Eliminates external tool dependency
Improves audit readiness
Enhances DR & BCM reliability

# Disclaimer

Test in a non-production environment before deploying in live infrastructure.
