# Changelog

## 1.5.0

Released 2022-04-25.

### Internal Changes

- Use json output from `cargo-about`. [#87]

[#87]: https://github.com/artichoke/generate_third_party/pull/87

### Bug Fixes

- Permit ISC and BSD-3-Clause license types. [#85]
- Update embedded mruby license text to v3.2.0. [#86]

[#85]: https://github.com/artichoke/generate_third_party/pull/85
[#86]: https://github.com/artichoke/generate_third_party/pull/86

## 1.4.0

Released 2022-04-01.

### Internal Changes

Many dependency upgrades. See GitHub PRs [#40] through [#84].

[#40]: https://github.com/artichoke/generate_third_party/pull/40
[#84]: https://github.com/artichoke/generate_third_party/pull/84

## 1.3.0

Released 2022-10-31.

### Bug Fixes

- Address deprecated 'set-output' command in GitHub Actions. [#38]

[#38]: https://github.com/artichoke/generate_third_party/pull/38

## 1.2.0

Released 2022-10-15.

### Bug Fixes

- Fix cargo-about Artichoke license checksum errors on Windows. [#36]

[#36]: https://github.com/artichoke/generate_third_party/pull/36

### Internal Changes

- Bump tapioca from 0.10.0 to 0.10.2. [#32]
- Bump regexp_parser from 2.5.0 to 2.6.0. [#33]
- Bump unicode-display_width from 2.2.0 to 2.3.0. [#34]
- Bump sorbet from 0.5.10413 to 0.5.10473. [#35]

[#32]: https://github.com/artichoke/generate_third_party/pull/32
[#33]: https://github.com/artichoke/generate_third_party/pull/33
[#34]: https://github.com/artichoke/generate_third_party/pull/34
[#35]: https://github.com/artichoke/generate_third_party/pull/35

### Changes

## 1.1.0

Released 2022-09-23.

### Bug Fixes

- Always update stable rust using rustup. [#30]

[#30]: https://github.com/artichoke/generate_third_party/pull/30

### Internal Changes

- Enforce Ruby files have 'strict' as the minimum sorbet typed level. [#29]

[#29]: https://github.com/artichoke/generate_third_party/pull/29

## 1.0.0

Released 2022-09-10. Initial release of `generate_third_party`.

Generate THIRDPARTY license listings using the bin script:

- `generate-third-party-text-file`
- `generate-third-party-text-file-single-target`

This gem exposes a bin script for installing `cargo-about` in GitHub Actions at
`install-cargo-about`.
