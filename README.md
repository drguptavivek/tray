QZ Tray
========

 [![Build Status](https://github.com/qzind/tray/actions/workflows/build.yaml/badge.svg)](../../actions) [![Downloads](https://img.shields.io/github/downloads/qzind/tray/latest/total.svg)](../../releases) [![Issues](https://img.shields.io/github/issues/qzind/tray.svg)](../../issues) [![Commits](https://img.shields.io/github/commit-activity/m/qzind/tray.svg)](../../commits)

Browser plugin for sending documents and raw commands to a printer or attached device

## QZ Tray VCMS fork behavior

This vendored fork is used by the Vision Centre Management System for direct browser-to-workstation barcode printing. It keeps QZ Tray's normal local HTTPS/WSS behavior, and adds VCMS-specific browser-app root CA trust management.

### Key features

* Trusted browser-app root CAs can be loaded from:
  * `authcert.override`
  * app-local `override.crt`
  * user-managed `~/.qz/trusted-root-certs/`
* Imported root CAs are stored as `~/.qz/trusted-root-certs/<fingerprint>.crt`.
* Imports are deduplicated by certificate fingerprint.
* Imported certificates are loaded immediately with `Certificate.scanAdditionalCAs()`; restart is not required.
* Imported/pasted certificates must be CA certificates. Browser leaf certificates, including the VCMS Digital Certificate served to web clients, are rejected.
* No private keys are stored in QZ Tray's trusted root CA store.

For strict VCMS deployments, run QZ Tray with `tray.strictmode=true` and trust only the VCMS Root CA.

### Tray menu additions

The `Advanced` tray menu includes:

* `Import trusted root CA...` - select one or more `.crt`, `.pem`, or `.cer` root CA files and import them into `~/.qz/trusted-root-certs/`.
* `Paste trusted root CA PEM...` - paste the VCMS admin page Root CA Certificate PEM directly into the local trust store.
* `Trusted root CAs...` - list imported root CAs with common name, organization, validity dates, fingerprint, and stored filename.

Use the VCMS admin page **Root CA Certificate** for import or paste. Do not import the **Digital Certificate**; it is the browser-presented leaf certificate and is served to clients by VCMS.

### JSON endpoints

The fork exposes a read-only local trust diagnostic endpoint:

* `https://localhost.qz.io:8181/trusted-root-cas`
* `https://localhost.qz.io:8181/trusted-root-cas.json`
* `http://localhost:8182/trusted-root-cas`
* `http://localhost:8182/trusted-root-cas.json`

The response contains public metadata only:

* `trustBuiltIn`
* `trustedRootCertDirectory`
* `activeRootCAs[]`
* `importedRootCAs[]`

Each certificate entry includes common name, organization, fingerprint, validity dates, and CA flag. Imported entries also include stored filename and path. Web apps should compare the expected VCMS Root CA fingerprint against `activeRootCAs[].fingerprint` to detect local trust mismatches.

## Getting Started
  * Download here https://qz.io/download/
  * See our [Getting Started](../../wiki/getting-started) guide.
  * Visit our home page https://qz.io.
  
## Support
  * File a bug via our [issue tracker](../../issues)
  * Ask the community via our [community support page](https://qz.io/support/)
  * Ask the developers via [premium support](https://qz.io/contact/) (fees may apply)

## Changelog
  * See our [most recent releases](../../releases)

## Java Developer Resources
  * [Install dependencies](../../wiki/install-dependencies)
  * [Compile, Package](../../wiki/compiling)
