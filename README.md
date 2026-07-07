[![Current Version](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/release.svg)](https://github.com/simons-containers/distroless-valkey/pkgs/container/distroless-valkey) [![Tags](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/tags.svg)](https://github.com/simons-containers/distroless-valkey/pkgs/container/distroless-valkey) <br> ![Current Size](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/size.svg) ![Wasted Size](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/wasted.svg) ![Efficiency](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/efficiency.svg) <br> ![Critical](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/critical.svg) ![High](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/high.svg) ![Medium](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/medium.svg) ![Low](https://raw.githubusercontent.com/simons-containers/distroless-valkey/badges/.badges/main/low.svg) <br> [![Publish Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-valkey/deploy.yaml?label=Publish%20Workflow&logo=github)](https://github.com/simons-containers/distroless-valkey/actions/workflows/deploy.yaml) [![Update Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-valkey/update-versions.yaml?label=Update%20Workflow&logo=github)](https://github.com/simons-containers/distroless-valkey/actions/workflows/update-versions.yaml)

# Distroless Valkey container

Bare-bones distroless Valkey container image.

## Running

Mount configuration at `/etc/valkey/server.conf`. Use `/var/lib/valkey` for persistence.

Example:

```bash
docker run -it --rm -v ./data:/var/lib/valkey \
  -v valkey.conf:/etc/valkey/server.conf \
  ghcr.io/simons-containers/distroless-valkey:latest
```

## License

Repository contents (e.g., `Containerfile`, build scripts, and configuration) are licensed under the **MIT License**.

Software included in built container images (such as **Valkey**, **openssl**, **zlib**, etc...) are provided under their respective upstream licenses and are not covered by the MIT license for this repository.

## Acknowledgements

This project depends on a number of upstream components and data sources:

- **Valkey** - Valkey is an open source (BSD) high-performance key/value datastore that supports a variety of workloads such as caching, message queues, and can act as a primary database.  
  https://valkey.io

- **zlib** – A foundational compression library implementing the DEFLATE algorithm, widely used across system software for efficient data compression and decompression.  
  https://zlib.net/

- **OpenSSL** – A comprehensive cryptographic library offering TLS, hashing, and encryption primitives required for secure communication and data integrity.  
  https://www.openssl.org/

- **glibc** – GNU C Library providing the standard C runtime and POSIX interfaces used by most Linux systems.  
  https://www.gnu.org/software/libc/

- **tzdata** – The IANA Time Zone Database, which provides the canonical global timezone definitions used for correct time handling.  
  https://www.iana.org/time-zones

- **Mozilla CA Certificates** – The curated set of trusted root Certificate Authorities maintained by Mozilla and used by many systems for TLS verification.  
  https://wiki.mozilla.org/CA
