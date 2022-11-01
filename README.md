# generate_third_party

[![GitHub Actions](https://github.com/artichoke/generate_third_party/workflows/CI/badge.svg)](https://github.com/artichoke/generate_third_party/actions)
[![Discord](https://img.shields.io/discord/607683947496734760)](https://discord.gg/QCe2tp2)
[![Twitter](https://img.shields.io/twitter/follow/artichokeruby?label=Follow&style=social)](https://twitter.com/artichokeruby)

Generate listings of third party dependencies and their licenses for copyright
attribution in distributed Artichoke binaries.

## Usage

To generate a `THIRDPARTY` text file for all targets Artichoke supports:

```sh
bundle exec generate-third-party-text-file path/to/artichoke/Cargo.toml
```

To generate a `THIRDPARTY` text file for a single target triple:

```sh
bundle exec generate-third-party-text-file-single-target \
  --target x86_64-unknown-linux-gnu \
  path/to/artichoke/Cargo.toml
```

### GitHub Actions

This repository is available as a GitHub Action:

```yaml
- name: Generate THIRDPARTY license listing
  id: generate_third_party
  uses: artichoke/generate_third_party@v1.3.0
  with:
    artichoke_ref: trunk
    target_triple: x86_64-unknown-linux-gnu
    output_file: ${{ github.workspace }}/THIRDPARTY
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Supported Targets

`generate_third_party` supports all [tier 1 Rust platforms] and [tier 2 MUSL
targets].

- `aarch64-apple-darwin`
- `aarch64-unknown-linux-gnu`
- `aarch64-unknown-linux-musl`
- `i686-pc-windows-gnu`
- `i686-pc-windows-msvc`
- `i686-unknown-linux-gnu`
- `x86_64-apple-darwin`
- `x86_64-pc-windows-gnu`
- `x86_64-pc-windows-msvc`
- `x86_64-unknown-linux-gnu`
- `x86_64-unknown-linux-musl`

[tier 1 rust platforms]:
  https://doc.rust-lang.org/nightly/rustc/platform-support.html#tier-1-with-host-tools
[tier 2 musl targets]:
  https://doc.rust-lang.org/nightly/rustc/platform-support.html#tier-2-with-host-tools
