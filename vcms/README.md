# VCMS QZ Tray Fork Notes

This folder contains VCMS-specific packaging guidance and provision templates. Keep VCMS additions here so upstream QZ Tray changes can be merged with minimal conflicts.

## Trust Model

VCMS should not accept arbitrary self-signed browser certificates. The fork should trust a VCMS-controlled root CA or a VCMS-pinned certificate and should keep QZ's message-signing flow intact.

Preferred runtime behavior:

- `authcert.override` points to the VCMS root CA certificate.
- `tray.strictmode=true` disables QZ Tray's built-in CA and restricts trust to override certificates.
- Browser pages provide a VCMS-issued `digital-certificate.txt`.
- The VCMS web server signs QZ payloads with a server-only private key.

QZ already implements `authcert.override`, `trustedRootCert`, `override.crt`, and `tray.strictmode`, so core certificate parsing and signature verification should remain upstream-compatible.

## Fork Hygiene

- Keep upstream remote as `upstream`.
- Keep VCMS changes on a small named branch, for example `vcms/main`.
- Avoid editing `src/qz/auth/Certificate.java` unless the existing override/strict-mode path is insufficient.
- If a code hook becomes necessary, add new VCMS code under `src/qz/vcms/` and keep upstream-file changes to a small bootstrap call.
- Document every changed upstream file in this folder.
