## Overview

The mq-rest-admin libraries are tested against IBM MQ for Distributed
Platforms (Linux, via container images). IBM also ships MQ for z/OS, a
separate implementation that runs natively on the mainframe. This page
documents the platform coverage gap and the research behind it.

## What we test

Integration tests run against the `icr.io/ibm-messaging/mq` container
image, which provides IBM MQ Advanced for Developers on Linux. The
containerized environment hosts two queue managers (QM1 and QM2) and
exercises the full REST-based MQSC pathway end-to-end. See
[Local MQ Container](local-mq-container.md) for setup details.

## What we do not test

We do not test against z/OS queue managers. z/OS MQ is a distinct
implementation from Distributed MQ, sharing the MQSC command interface
but differing in platform-specific attributes, status values, and
operational behaviour. The REST API surface is largely identical, but
response payloads can differ in subtle ways.

## Why z/OS testing is not feasible

A thorough investigation (February 2026) evaluated every publicly
available option for z/OS MQ access. None met the requirements for
automated, CI/CD-ready testing in an open source project.

### Container images

IBM publishes MQ container images for amd64, ppc64le, and s390x.
The s390x images run the **distributed Linux** build of MQ, not the
z/OS variant. All images are licensed under the International License
Agreement for Non-Warranted Programs, which restricts usage to a single
developer and does not clearly permit automated CI/CD pipelines.

### IBM Z Development and Test Environment (ZD&T)

ZD&T emulates z/Architecture on x86 Linux and can run z/OS (and
therefore z/OS MQ). Three editions exist:

| Edition | Cost | Open source viable |
|---|---|---|
| Learners | ~$120/year | No (prohibits commercial use) |
| Personal | ~$5,000+ | Possibly (high cost barrier) |
| Enterprise | Undisclosed | Unknown |

All editions require a separate z/OS license on top of the ZD&T cost.

### IBM Z Xplore

A free, challenge-based learning platform that provides actual z/OS MQ
access through web-based exercises. MQ is available in the Extended
Challenges track. However, access is interactive only with no
programmatic or API access suitable for automated testing.

### IBM Wazi as a Service

Cloud-based z/OS environment on IBM Cloud VPC. Provisions quickly and
offers trial access. Pricing is not publicly disclosed and MQ
availability is not explicitly confirmed.

### IBM Z Trial Program

No-cost cloud environment for evaluating IBM Z. Trial duration and
terms are not specified, production use is not allowed, and MQ inclusion
is unconfirmed.

### Community and academic options

| Option | Limitation |
|---|---|
| IBM Academic Initiative | Restricted to accredited institutions |
| Open Mainframe Project | Educational resources only, no infrastructure |
| Hercules emulator | Running z/OS violates IBM licensing |

## Summary

There is no publicly available, free, CI/CD-ready option for testing
against z/OS queue managers. The closest free option (IBM Z Xplore)
provides z/OS MQ access only through a web-based challenge interface,
not programmatic access suitable for automated pipelines.

The project mitigates this gap by:

- Testing thoroughly against distributed MQ, which shares the MQSC
  command interface and REST API surface with z/OS MQ.
- Maintaining mapping data that documents known platform differences
  in attribute names and values.
- Accepting contributions and bug reports from users running against
  z/OS queue managers in production.
