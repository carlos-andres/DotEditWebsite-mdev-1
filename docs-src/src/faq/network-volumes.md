# Network Volumes

DotEdit can work with `.env` files stored on network volumes (NAS, SMB shares, NFS mounts, etc.), but there are some limitations to be aware of.

## Opening Files from Network Volumes

You can open `.env` files from network volumes using the same methods as local files:
- Browse button (file picker)
- Drag and drop from Finder

DotEdit detects when a file is on a non-local volume and adjusts its behavior accordingly.

## File Watching Limitations

DotEdit monitors open files for external changes using macOS file system events (FSEvents). On network volumes, FSEvents may not work reliably:

- **SMB/CIFS shares:** FSEvents may not detect changes made by other machines on the network
- **NFS mounts:** Event delivery can be delayed or missed entirely
- **SSHFS/FUSE mounts:** Behavior varies by implementation

### Workaround

If file watching doesn't work on your network volume, use **manual reload** (`Cmd+R`) to refresh the file from disk when you know it has changed externally.

## Saving to Network Volumes

Saving generally works on network volumes, but you may encounter issues:

### Slow Writes

Network latency can make saves noticeably slower than local saves. DotEdit uses atomic writes (write temp file, then rename), which requires two file operations over the network.

### Permission Errors

Network shares often have different permission models than local file systems. Common issues:

- The share is mounted read-only
- Your network user doesn't have write access
- The share restricts file creation (needed for temp files and backups)

If you encounter permission errors, check:
1. That the share is mounted with write access
2. Your user permissions on the network share
3. Whether the share allows file creation in the target directory

### Backup Files

If DotEdit can't create a backup file on a network volume (due to permissions or naming restrictions), the backup step fails with a toast notification. The save itself may still succeed.

## Disconnection Handling

If a network volume disconnects while DotEdit has files open:

- DotEdit catches the read/write error and shows an error message with a note about potential network disconnection
- Your in-memory edits are preserved
- The file watcher for that file stops working
- You can reconnect the volume and use **Reload** (`Cmd+R`) to re-establish the connection

DotEdit does not automatically reconnect to network volumes — this is managed by macOS and your network configuration.

## Performance Considerations

For the best experience with large `.env` files on network volumes:

- Use manual reload instead of relying on file watching
- Be patient with save operations — network latency affects atomic writes
- Consider copying files locally for editing, then copying back when done

## Recommendations

For reliable operation, we recommend:

1. **Local copies for editing:** Copy `.env` files from the network volume to a local directory, edit in DotEdit, then copy back
2. **Manual reload:** Don't rely on automatic file watching for network files
3. **Check mount options:** Ensure the volume is mounted with read-write access

## Related

- [File Watching](../features/file-watching.md) — How DotEdit monitors files for changes
- [File Permissions](file-permissions.md) — General permission troubleshooting
- [Common Errors](common-errors.md) — Error messages you might see
