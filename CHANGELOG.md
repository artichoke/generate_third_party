# Changelog

## 1.13.0

Released 2024-02-19.

## Action Changes

- Permit MIT-0 license. [#142]

### Internal Changes

- Upgrade Ruby dependencies. [#138], [#139].
- Upgrade GitHub Actions dependencies. [#140]
- Upgrade npm dependencies. [#141

[#138]: https://github.com/artichoke/generate_third_party/pull/138
[#139]: https://github.com/artichoke/generate_third_party/pull/139
[#140]: https://github.com/artichoke/generate_third_party/pull/140
[#141]: https://github.com/artichoke/generate_third_party/pull/141
[#142]: https://github.com/artichoke/generate_third_party/pull/142

## 1.12.1

Released 2024-01-08.

### Internal Changes

- Update `dependabot.yml` to update npm deps. [#137]
- Upgrade Ruby dependencies. [#138]

[#137]: https://github.com/artichoke/generate_third_party/pull/137
[#138]: https://github.com/artichoke/generate_third_party/pull/138

## 1.12.0

Released 2024-01-08.

### Internal Changes

- Update `dependabot.yml` to use dependency groups. [#122]
- Upgrade Ruby dependencies. [#123], [#124], [#126], #[128], [#129].
  [#131], #[133], [#135]
- Upgrade GitHub Actions dependencies. [#125], [#127], [#129], [#132], [#134]

[#122]: https://github.com/artichoke/generate_third_party/pull/122
[#123]: https://github.com/artichoke/generate_third_party/pull/123
[#124]: https://github.com/artichoke/generate_third_party/pull/124
[#125]: https://github.com/artichoke/generate_third_party/pull/125
[#126]: https://github.com/artichoke/generate_third_party/pull/126
[#127]: https://github.com/artichoke/generate_third_party/pull/127
[#128]: https://github.com/artichoke/generate_third_party/pull/128
[#129]: https://github.com/artichoke/generate_third_party/pull/129
[#131]: https://github.com/artichoke/generate_third_party/pull/131
[#132]: https://github.com/artichoke/generate_third_party/pull/132
[#133]: https://github.com/artichoke/generate_third_party/pull/133
[#134]: https://github.com/artichoke/generate_third_party/pull/134
[#135]: https://github.com/artichoke/generate_third_party/pull/135

## 1.11.0

Released 2023-07-02.

### Action Changes

- Use stricter version pinning for GitHub Actions. [#94]
- Rollup of May 2023 dependabot RubyGems updates. [#106]
- Update deps. [#109], [#110], [#111], [#112], [#113], [#114], [#115], [#116],
  [#117], [#121]

### Internal Changes

- Use stricter version pinning for GitHub Actions. [#94]
- Bump ruby/setup-ruby from 1.147.0 to 1.148.0. [#95]
- Stop monitoring Twitter links, fix markdown link check job. [#104]
- Remove unneeded ignore pattern from markdown link check config. [#105]
- Update CI to install Ruby version compatible with gemspec. [#107]
- Update dependabot.yml. [#108]

[#94]: https://github.com/artichoke/generate_third_party/pull/94
[#95]: https://github.com/artichoke/generate_third_party/pull/95
[#104]: https://github.com/artichoke/generate_third_party/pull/104
[#105]: https://github.com/artichoke/generate_third_party/pull/105
[#106]: https://github.com/artichoke/generate_third_party/pull/106
[#107]: https://github.com/artichoke/generate_third_party/pull/107
[#108]: https://github.com/artichoke/generate_third_party/pull/108
[#109]: https://github.com/artichoke/generate_third_party/pull/109
[#110]: https://github.com/artichoke/generate_third_party/pull/110
[#111]: https://github.com/artichoke/generate_third_party/pull/111
[#112]: https://github.com/artichoke/generate_third_party/pull/112
[#113]: https://github.com/artichoke/generate_third_party/pull/113
[#114]: https://github.com/artichoke/generate_third_party/pull/114
[#115]: https://github.com/artichoke/generate_third_party/pull/115
[#116]: https://github.com/artichoke/generate_third_party/pull/116
[#117]: https://github.com/artichoke/generate_third_party/pull/117
[#121]: https://github.com/artichoke/generate_third_party/pull/121

## 1.10.0

Released 2023-04-27.

### Action Changes

- Checkout artichoke/artichoke repository in the a better temp directory. [#93]

[#93]: https://github.com/artichoke/generate_third_party/pull/93

## 1.9.0

Released 2023-04-27.

### Packaging Changes

- Add github action branding metadata, prepare v1.9.0 release. [#91]

[#91]: https://github.com/artichoke/generate_third_party/pull/91

## 1.8.0

Released 2023-04-27.

### Packaging Changes

- Upgrade gemspec minimum Ruby version to 3.0.0. [#90]

[#90]: https://github.com/artichoke/generate_third_party/pull/90

### Internal Changes

- Upgrade development Ruby version and bundler version. [#89]

[#89]: https://github.com/artichoke/generate_third_party/pull/89

## 1.7.0

Released 2023-04-26.

### Action Changes

- Echo cargo-about version in composite action. [#88]

[#88]: https://github.com/artichoke/generate_third_party/pull/88

## 1.6.0

Released 2023-04-26.

### Action Changes

- Use json output from `cargo-about`. [#87]

[#87]: https://github.com/artichoke/generate_third_party/pull/87

## 1.5.0

Released 2022-04-25.

### Bug Fixes

- Permit ISC and BSD-3-Clause license types. [#85]
- Update embedded mruby license text to v3.2.0. [#86]

[#85]: https://github.com/artichoke/generate_third_party/pull/85
[#86]: https://github.com/artichoke/generate_third_party/pull/86

## 1.4.0

Released 2023-04-01.

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
