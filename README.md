# Budget

<p align="center">
<img width="250" src="https://user-images.githubusercontent.com/706004/38782280-0d68f35c-40bf-11e8-8ece-1d9b045ea9d7.gif" alt="flying money">
</p>

A collection of [ledger-cli][] scripts we use to balance our family budget.

[ledger-cli]: http://ledger-cli.org "Ledger is a powerful, double-entry accounting system that is accessed from the UNIX command-line."

## Docker support

This collection of scripts has Docker support. The [Docker image][docker-ledger]
contains Ledger 3.1 built on top of Ubuntu 14.04. The scripts referenced below
are intended to be run within this Docker image. Your mileage may vary if you
run these directly on your machine.

[docker-ledger]: https://hub.docker.com/r/rogeruiz/ledger/

## Usage

Leverage these scripts on your system directly or use the Docker image. The
scripts are aware of a `${BUDGET_FILE}` environment variable to make running
them easier and avoid having to pass a `--file` flag to Ledger.

If you use the Docker image, the `.ledgerrc` file included automatically sets
the `--file` flag to `STDIN` so you can pipe your ledger file into the `docker
run` commands. The examples included below use this method.

### Scripts

All of the script commands below use the Docker image rather than a locally
installed Ledger binary. Examples below include paths from the `examples/`
directory in this repository. Inspect those files if you'd like to see an
example of how we use Ledger.

#### Balance

The `scripts/balance` file is a simple wrapper around the `ledger balance`
command. This script allows you to leverage everything from running `ledger
balance` directly by appending all arguments at the end. It has `--no-total`
hard-coded by default.

```sh
cat example/file.ledger | docker run -i rogeruiz/ledger balance
```

#### Balance watch

The `scripts/balancew` file watches at a two-second interval for any changes to
the ledger file. It also is hard-coded to only look at the `Assets` and
`Liabilities:Credit` categories which we use to consider our debt ratio.

```sh
cat example/file.ledger | docker run -i rogeruiz/ledger balancew
```

#### Balances

The `scripts/balancess` file reports out the same categories that Balance watch
reports but without the actual watching. Useful when you want to leave a
snapshot up on the screen when you step away from ledger for a little while.

```sh
cat example/file.ledger | docker run -i rogeruiz/ledger balancess
```

#### Register

The `scripts/register` file is a simple wrapper around the `ledger register`
command. This script allows you to leverage everything from running `ledger
register` directly by appending all arguments at the end.

```sh
cat example/file.ledger | docker run -i rogeruiz/ledger register
```

#### Register Last Month ( 30 Days )

The `scripts/registerlm` file runs `ledger register` with the `--begin`
constraint to be 30 days from the current date. We use this to plan for the next
thirty days using the last thirty days as a barometer. It's not perfect, but it
certainly allows you to course-correct at times. As with the `scripts/register`
all arguments are appended at the end. It's also sometimes useful to run this
command with the `-M` flag if you're at the middle of a month.

```sh
cat example/file.ledger | docker run -i rogeruiz/ledger registerlm
```

Note for the example you will probably have to modify the `file.ledger` to have
a date that occurs in the last thirty days when you run it.

#### Register tags

The `scripts/registert` file runs `ledger register` with the `"tag()"` query
set. All arguments are placed within the query. We mostly use this to aggregate
entries that are tagged in a particular way that don't cater well into the
description or the category for the entry.

```sh
cat example/file.ledger | docker run -i rogeruiz/ledger registert "Expensive"
```

#### Convert

The `scripts/convert` file runs `ledger convert` with some whitespace processing
on the CSV file we download from our bank. The preprocessing removes newlines
from the Description fields of the CSV file and is needed because ledger chokes
on the newlines within it. This takes two arguments, `path/to/file.csv` and
`path/to/file.ledger`. The latter is needed by `ledger convert` to process the
CSV file.

```sh
docker run -i -v $PWD:/data rogeruiz/ledger convert /data/example/file.csv /data/example/file.ledger
```
