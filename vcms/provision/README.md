# VCMS Provision Template

Use `provision.template.json` as the starting point for VCMS-branded installers.

Before building, place the VCMS root CA certificate beside the provision file as:

```text
vcms-root-ca.crt
```

Then build with QZ's existing provision support, for example:

```bash
ant pkgbuild -Dprovision.file=vcms/provision/provision.template.json
```

The template uses QZ's own provision invokers:

- `ca` copies the CA and appends it to `authcert.override`.
- `preference` sets `tray.strictmode=true` at startup.

This keeps VCMS trust customization out of QZ core verification code.
