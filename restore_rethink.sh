#!/bin/bash
# Restore Rethink DNS configuration after flashing LineageOS + MicroG
# Run this from your PC with ADB after the phone has booted

set -e

BACKUP_FILE="rethink_backup.tar.gz"
PACKAGE="com.celzero.bravedns"

echo "=== Rethink DNS Restore Script ==="
echo "Backup file: $BACKUP_FILE"
echo "Target package: $PACKAGE"
echo ""

# Check if backup exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERROR: $BACKUP_FILE not found in current directory"
    exit 1
fi

# Check ADB connection
echo "Checking ADB connection..."
adb devices | grep -q "device$" || { echo "ERROR: No device connected via ADB"; exit 1; }

echo "Device connected. Pushing backup to phone..."
adb push "$BACKUP_FILE" /sdcard/

echo "Extracting and restoring..."
adb shell "
  set -e
  tar -xzf /sdcard/$BACKUP_FILE -C /sdcard/
  cp -r /sdcard/rethink_backup/shared_prefs/* /data/data/$PACKAGE/shared_prefs/
  cp -r /sdcard/rethink_backup/databases/* /data/data/$PACKAGE/databases/
  cp -r /sdcard/rethink_backup/files/* /data/data/$PACKAGE/files/
  chown -R 10197:10197 /data/data/$PACKAGE/
  restorecon -R /data/data/$PACKAGE/
  echo 'Restore complete!'
"

echo ""
echo "=== Restore finished ==="
echo "Open Rethink DNS app to verify your settings are restored."