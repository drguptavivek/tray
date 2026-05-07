# VCMS QZ Tray LGPL Compliance Notes

This note is an engineering checklist for maintaining a VCMS fork of QZ Tray. It is not legal advice.

## Upstream License Position

QZ Tray source code is published under the GNU Lesser General Public License version 2.1. The upstream license file is `LICENSE.txt` at the repository root. The QZ API, demo code, and wiki examples are described there as public domain unless otherwise noted.

VCMS customizations should preserve the LGPL terms when we build and distribute our own QZ Tray binary.

## Distribution Checklist

When distributing a VCMS-built QZ Tray binary:

- Include QZ Tray's upstream `LICENSE.txt`.
- Preserve copyright notices and third-party notices.
- Publish the corresponding modified source code in the public VCMS QZ Tray fork.
- Clearly mark VCMS-modified files and the reason for each modification.
- Do not represent the binary as an official QZ Industries build.
- Keep VCMS branding and support contacts distinct from QZ Industries branding and support contacts.
- Provide recipients a practical way to obtain the modified source for the same binary version.

## Modification Strategy

Keep VCMS changes modular so the fork remains easy to merge with upstream:

- Put VCMS documentation, provision files, and packaging notes under `vcms/`.
- Prefer QZ's existing configuration and provision hooks over core code changes.
- Use `authcert.override` and `tray.strictmode=true` for VCMS trust customization.
- If code changes become necessary, add new code under `src/qz/vcms/` and keep upstream-file edits to small bootstrap calls.
- Avoid changing message signature verification, certificate parsing, websocket protocol behavior, or printer command rendering unless there is no configuration-based alternative.

## Certificate Trust Boundary

The VCMS fork should not accept arbitrary self-signed certificates. It should trust only VCMS-controlled certificate material, such as:

- a VCMS root CA provisioned through QZ's `ca` provision step, or
- a deliberately pinned VCMS certificate if a future implementation chooses pinning.

This keeps silent printing tied to the VCMS trust model rather than removing the certificate boundary entirely.

## Upstream Merge Practice

Recommended branch model:

- `upstream/master`: mirror of `github.com/qzind/tray`.
- `vcms/main`: VCMS fork branch.
- VCMS changes grouped into small commits: docs/provisioning, branding, build metadata, and any code hooks separately.

Before merging upstream:

- Review upstream changes touching `src/qz/auth`, `src/qz/common`, `src/qz/installer/provision`, and `build.xml`.
- Re-run QZ build/package checks for the target operating systems.
- Re-test VCMS certificate provisioning with `authcert.override` and `tray.strictmode=true`.
