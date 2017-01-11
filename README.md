Budget
---

A collection of ledger-cli scripts we use to balance our family budget.

## Usage

In order to use these scripts, you'll need to set a `$BUDGET_FILE` variable in
your environment. With that set, usage of each script file is pretty
straight-forward. Just follow along with the documentation below. Most commands
are based of previous scripts which are basic ledger commands.

### Scripts

In the `scripts/` directory, you'll find `balance*` and `register*` scripts.
These scripts are documented below.

#### Balance

The `scripts/balance` file is a simple wrapper around the `ledger balance`
command. This script allows you to leverage everything from running `ledger
balance` directly by appending all arguments at the end. It has `--no-total`
hard-coded by default.

#### Balance watch

The `scripts/balancew` file watches at a two-second interval for any changes to
the ledger file. It also is hard-coded to only look at the `Assets` and
`Liabilities:Credit` categories which we use to consider our debt ratio.

#### Register

The `scripts/register` file is a simple wrapper around the `ledger register`
command. This script allows you to leverage everything from running `ledger
register` directly by appending all arguments at the end.

#### Register Last Month ( 30 Days )

The `scripts/registerlm` file runs `ledger register` with the `--begin`
constraint to be 30 days from the current date. We use this to plan for the next
thirty days using the last thirty days as a barometer. It's not perfect, but it
certainly allows you to course-correct at times. As with the `scripts/register`
all arguments are appended at the end. It's also sometimes useful to run this
command with the `-M` flag if you're at the middle of a month.

#### Register tags

The `scripts/registert` file runs `ledger register` with the `"tag()"` query
set. All arguments are placed within the query. We mostly use this to aggregate
entries that are tagged in a particular way that don't cater well into the
description or the category for the entry.
