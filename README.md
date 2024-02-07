# IMDB Movie Data Analysis Dashboard

Analyze Scripts for Monty Python's Flying Circus data using SQLite and PowerPipe.

## Installation

Download and install Powerpipe (https://powerpipe.io/downloads) and SQLite(https://www.sqlite.org/download.html). Or use Brew:

```sh
brew install powerpipe
```

## Setup:

Download the Monty Python Flying Circus Dataset (https://www.kaggle.com/datasets/allank/monty-python-flying-circus/data).

And unzip the file to a directory.

```sh
unzip archive.zip
```

## Clone:

```sh
git clone https://github.com/turbot/powerpipe-mod-monty-python-flying-circus.git
cd powerpipe-mod-monty-python-flying-circus
```

## Usage

Run the dashboard and specify the DB connection string:

```sh
powerpipe server --database sqlite:////your/path/to/the/directory/where/you/unzipped/the/dataset/database.sqlite
```