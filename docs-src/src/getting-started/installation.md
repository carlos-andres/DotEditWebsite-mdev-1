# Installation

## System Requirements

| Requirement | Minimum |
|-------------|---------|
| macOS | 15.0 Sequoia or later |
| Architecture | Apple Silicon (M1+) and Intel (x86_64) |
| Disk space | ~25 MB |

DotEdit is a universal binary that runs natively on both Apple Silicon and Intel Macs.

## Download

1. Go to the [DotEdit releases page](https://github.com/carlos-andres/DotEdit/releases)
2. Download the latest `.dmg` file
3. Open the DMG and drag **DotEdit.app** into your Applications folder
4. Eject the DMG

On first launch, macOS may show a security prompt because the app is distributed outside the Mac App Store. To open it:

1. Right-click (or Control-click) on **DotEdit.app** in your Applications folder
2. Select **Open** from the context menu
3. Click **Open** in the confirmation dialog

This only needs to be done once. Subsequent launches work normally.

## Verifying the Installation

After installing, launch DotEdit from your Applications folder or via Spotlight (press `Cmd+Space` and type "DotEdit").

You should see the file selection screen with two drop zones — one for each `.env` file you want to compare.

## Updating

Download the latest DMG from the releases page and replace the existing app in your Applications folder. Your settings and recent files are preserved since they are stored in your user preferences, not inside the app bundle.

## Uninstalling

1. Drag **DotEdit.app** from your Applications folder to the Trash
2. Optionally, remove preferences:
   ```bash
   defaults delete com.dotedit.DotEdit
   ```

## Next Steps

Once installed, follow the [Quick Start](quick-start.md) guide to compare your first pair of `.env` files.
