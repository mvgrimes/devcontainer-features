# Devcontainer Features

[![Tests](https://github.com/mvgrimes/devcontainer-features/actions/workflows/test.yaml/badge.svg)](https://github.com/mvgrimes/devcontainer-features/actions/workflows/test.yaml)

This repo contains my custom devcontainer features.

## Features

| Feature                                                      | Description                                                                                                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| [asdf](./src/)sdf       | Install asdf from github releases.                                                                                                |
| [claud-code-persistance](./src/claude-code-persistence) | Avoid extra logins from the Claude Code CLI by preserving the `~/.claude/.credentials.json` folder across container instances.                                        |
| [pnpm-store-persistence](./src/pnpm-store-persistence)             | Sets pnpm store to ~/.pnpm-store and mounts it to a volume to share between multiple devcontainers. |


## References

https://github.com/joshuanianji/devcontainer-features
https://gist.github.com/PatrickChoDev/81d36159aca4dc687b8c89983e64da2e
