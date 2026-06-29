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

## Building

| Arg | Description |
|---|---|
| `VALKEY_VERSION` | Version of Valkey to use
| `ZLIB_VERSION` | Version of zlib to use
| `OPENSSL_VERSION` | Version of openssl to use

Build container using build-args from versions.yaml:

```bash
docker build -t \
  distroless-valkey:$(yq -r .valkey versions.yaml) \
  $(yq -r 'to_entries | .[] | "--build-arg \(.key | ascii_upcase)_VERSION=\(.value)"' versions.yaml) -f Containerfile .
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
