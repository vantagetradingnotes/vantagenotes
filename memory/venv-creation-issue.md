---
name: venv-creation-issue
description: Troubleshooting steps for venv creation issues on Windows
metadata:
  node_type: memory
  type: project
  originSessionId: 34ff75c6-e980-4817-aeb7-e4f8270dd4c6
  modified: 2026-10-05T13:59:42.679Z
---

# venv Creation Issues on Windows

## Problem

Attempting to create a virtual environment (`python -m venv venv`) in the backend directory fails with permission errors, specifically at the `Scripts` subdirectory level.

## Troubleshooting Steps

1. **Check and reset permissions**:
   - Used `icacls` to reset permissions on the `venv/Scripts` directory and its contents.
   - Explicitly granted full permissions to the user on the `venv/Scripts` directory.

2. **Delete existing venv directory**:
   - Attempted to delete the existing venv directory using `rmdir /s /q venv` and `Remove-Item -Recurse -Force venv`.
   - Encountered permission issues due to locked files.

3. **Kill python processes and force remove**:
   - Used `taskkill /F /IM python.exe /T` to kill python processes.
   - Attempted to force remove the venv directory using PowerShell.

4. **Manual cleanup**:
   - Recommended manual cleanup by closing all terminals, terminating python processes, and using PowerShell as Administrator to remove the venv directory.

## Current Status

The venv directory is still present and locked. The user needs to manually delete it using PowerShell as Administrator after ensuring all python processes are terminated.

## Next Steps

Once the venv directory is manually deleted, proceed to recreate the virtual environment and install Django.

## Related Memories

[[django-setup]]
[[vue-dev-server]]
