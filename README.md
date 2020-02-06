# gitmirror

Simple Bash Script to replicate (mirror) a repository elsewhere and get periodically updates.

A common routine employed in system administration is backup or mirroring of Git repositories. So the goal of this project is a safe replication of source code from a repository into another.

[![GitHub forks](https://img.shields.io/github/forks/diegocoutodev/gitmirror.svg?style=social&label=Fork)](https://github.com/diegocoutodev/gitmirror/fork) [![GitHub stars](https://img.shields.io/github/stars/diegocoutodev/gitmirror?style=social&label=Star)](https://github.com/diegocoutodev/gitmirror)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)

## Table of contents
  - [System Requirements](#Systema-Requirements)
  - [Environment Variables](#Environment-Variables)
  - [Mirroring a repository](#Mirroring-a-repository)


## System Requirements

Some dependencies are required to run this script that are shown below.

- [Git](https://git-scm.com/)
- [Bash](https://www.gnu.org/software/bash/)

## Environment Variables

The mirror's configurations is based on environment variables, in general present in the file called `.env`. The variables are on table below:

|  Variable |  Description | Required  |
|---|---|---|
| `SOURCE_REPO`  |  Repository URL that will be replicated |  Yes |
| `SOURCE_USER`  |  username to be authenticated in source repository | No  |
| `SOURCE_PASS`  |  password to be authenticated in source repository |  No |
| `TARGET_REPO`  | URL that will receive replicated repository  |  Yes |
| `TARGET_USER`  | username to be authenticated in target repository  | No  |
| `TARGET_PASS`  | password to be authenticated in target repository  |  No |

## Mirroring a repository

1 - Clone this project

```bash
$ cd $HOME && git clone https://github.com/diegocoutodev/gitmirror.git
```

2 - Create a directory that will receive all updates of target repository

```bash
$ mkdir $HOME/repositories/
```

3 - Create `.env_mirror1` and set the [environment variables](#Environment-Variables)

```bash
$ touch $HOME/repositories/.env_mirror1
```

4 - Schedule the mirroring, for example, to execute every minute

```bash
$ echo "* * * * * cd $HOME/gitmirror && ./gitmirror.sh $HOME/repositories/.env_mirror1 $HOME/repositories >> /dev/null 2>&1" | crontab -
```