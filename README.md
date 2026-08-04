# LineageOS 19.1 Build for Huawei ANE-LX1 (P20 Lite) with MicroG

Builds LineageOS 19.1 (Android 12L) for **ANE-LX1 / hi6250 (Kirin 659)** with **MicroG** (no Google Play).

## Hardware
- Device: Huawei P20 Lite (ANE-LX1)
- SoC: Kirin 659 (hi6250)
- Architecture: arm64
- Current kernel: 4.9.148 (vendor)

## Sources Used
- **Device trees**: `hisi-oss/android_device_huawei_anne` + `hi6250-9-common` (branch `lineage-19.1`)
- **Kernel**: `Meticulus/android_kernel_huawei_hi6250` (branch `lineage-19.1`)
- **Vendor blobs**: `Meticulus/android_vendor_huawei_hi6250` (branch `lineage-19.1`)
- **MicroG**: `microg/GmsCore`, `GsfProxy`, `FakeStore` (branch `lineage-19.1`)

## Features
- ✅ MicroG pre-installed (GmsCore, GsfProxy, FakeStore)
- ✅ Signature spoofing enabled
- ✅ No Google Play Services / Play Store
- ✅ F-Droid / Aurora Store ready
- ✅ Rethink DNS backup included (restore after flash)

## Quick Start (2 minutes)

### 1. Create your GitHub repo
1. Go to **GitHub.com** → **New repository**
2. Name: `lineage-anne-build` (or whatever)
3. **Public** (required for free Actions minutes)
4. Create repository → **Upload files** → drag this entire folder

### 2. Trigger the build
1. In your repo: **Actions** tab → **Build LineageOS 19.1**
2. Click **Run workflow** → choose `userdebug` (default)
3. Click **Run workflow** (green button)
4. Wait **2-4 hours** (GitHub compiles on 32-core servers)

### 3. Download the ROM
1. Actions → your workflow run → **Artifacts**
2. Download `lineage-19.1-anne-userdebug.zip`
3. Extract → you get `lineage-19.1-<date>-UNOFFICIAL-anne.zip`

### 4. Flash on your phone
```bash
# Prerequisites: TWRP installed, bootloader unlocked
adb reboot recovery
# In TWRP: Install → lineage zip → Swipe to flash → Reboot System
```

### 5. Restore Rethink DNS config
```bash
# After first boot, from your PC:
adb push rethink_backup.tar.gz /sdcard/
adb shell "tar -xzf /sdcard/rethink_backup.tar.gz -C /sdcard/ && \
  cp -r /sdcard/rethink_backup/shared_prefs/* /data/data/com.celzero.bravedns/shared_prefs/ && \
  cp -r /sdcard/rethink_backup/databases/* /data/data/com.celzero.bravedns/databases/ && \
  cp -r /sdcard/rethink_backup/files/* /data/data/com.celzero.bravedns/files/ && \
  chown -R 10197:10197 /data/data/com.celzero.bravedns/ && \
  restorecon -R /data/data/com.celzero.bravedns/"
```

## What works / Known issues

| Feature | Status |
|---------|--------|
| Boot | ✅ |
| Display | ✅ |
| WiFi | ✅ |
| Bluetooth | ✅ |
| Camera | ✅ (2 sensors) |
| Audio | ✅ |
| Sensors | ✅ |
| Modem/RIL | ⚠️ May need vendor shims |
| Fast charging | ⚠️ Limited to 500mA USB |
| SELinux | Enforcing (some denials) |

## Build locally (if you have Linux + 16GB RAM + 200GB SSD)
```bash
git clone https://github.com/YOUR_USERNAME/lineage-anne-build
cd lineage-anne-build
# Copy local_manifests to your LineageOS source tree
# Then: source build/envsetup.sh && lunch lineage_anne-userdebug && mka bacon
```

## Support
- Device: ANE-LX1 only (tested on ANE-LX1 9.1.0.410 C109)
- Bootloader must be unlocked (verifiedbootstate=orange)
- TWRP required for flash

## Credits
- hisi-oss (device trees)
- Meticulus (kernel + vendor)
- microg project (GmsCore, GsfProxy, FakeStore)
- LineageOS project
- phhusson (Treble experimentation)