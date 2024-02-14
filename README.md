# Youtube Channel Statistics Mod for PowerPipe

Analyze youtube channel statistics data using Postgres and PowerPipe.

![youtuber-analysis-dashboard-image](https://github.com/turbot/powerpipe-mod-youtuber/assets/72413708/d1e7a0dd-0222-4032-bc24-ec614dfbc41d)

![youtube-statistics-detail-image](https://github.com/turbot/powerpipe-mod-youtuber/assets/72413708/0b3af586-cc1f-4917-bc86-7130db28ad46)

## Installation

Download and install Powerpipe (https://powerpipe.io/downloads) and PostgreSQL (https://www.postgresql.org/download/). Or use Brew:

```sh
brew install turbot/tap/powerpipe
brew install turbot/tap/postgresql
```

## Get the Dataset

Download the [Global YouTube Statistics](https://www.kaggle.com/code/nelgiriyewithana/an-introduction-to-the-global-youtube-statistics/input).

## Create a PostgreSQL Database

Replace `username` with your PostgreSQL username and `mydatabase` with your desired database name.

```sh
psql -U username -d postgres
create database mydatabase;
```

## Connect to the Database

```sh
\c mydatabase
```

## Create a Table

```sh
create table youtube_statistics (
    rank INT,
    youtuber VARCHAR(255),
    subscribers NUMERIC,
    video_views NUMERIC,
    category VARCHAR(255),
    title VARCHAR(255),
    uploads NUMERIC,
    country VARCHAR(100),
    abbreviation VARCHAR(10),
    channel_type VARCHAR(100),
    video_views_rank NUMERIC,
    country_rank NUMERIC,
    channel_type_rank NUMERIC,
    video_views_for_the_last_30_days NUMERIC,
    lowest_monthly_earnings NUMERIC,
    highest_monthly_earnings NUMERIC,
    lowest_yearly_earnings NUMERIC,
    highest_yearly_earnings NUMERIC,
    subscribers_for_last_30_days NUMERIC,
    created_year TEXT, -- Changed from INT to TEXT
    created_month VARCHAR(10),
    created_date FLOAT,
    gross_tertiary_education_enrollment_percent NUMERIC,
    population NUMERIC,
    unemployment_rate NUMERIC,
    urban_population NUMERIC,
    latitude NUMERIC,
    longitude NUMERIC
);
```

## Load the Dataset into the Table

```sh
copy youtube_statistics(rank, youtuber, subscribers, video_views, category, title, uploads, country, abbreviation, channel_type, video_views_rank, country_rank, channel_type_rank, video_views_for_the_last_30_days, lowest_monthly_earnings, highest_monthly_earnings, lowest_yearly_earnings, highest_yearly_earnings, subscribers_for_last_30_days, created_year, created_month, created_date, gross_tertiary_education_enrollment_percent, population, unemployment_rate, urban_population, latitude, longitude)
from '/path/to/your/file/Global YouTube Statistics.csv' DELIMITER ',' CSV HEADER ENCODING 'ISO-8859-1';
```

## Clone the Mod Repository

```sh
git clone https://github.com/turbot/powerpipe-mod-youtuber.git
cd powerpipe-mod-youtuber
```

## Usage

Run the dashboard and specify the DB connection string:

```sh
powerpipe server --database postgres://username@localhost:5432/mydatabase
```

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Powerpipe](https://powerpipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://powerpipe.io/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [Youtube Statistic Mod](https://github.com/turbot/powerpipe-mod-youtuber/labels/help%20wanted)
