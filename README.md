# Youtube Channel Statistics Mod for PowerPipe

Analyze youtube channel statistics data using PostgreSQL and PowerPipe.

![youtuber-analysis-dashboard-image](https://github.com/turbot/powerpipe-mod-youtube/assets/78197905/98553c5b-b9da-4b51-9142-174363bad15d)

## Getting Started

### Installation

Download and install Powerpipe (https://powerpipe.io/downloads) and PostgreSQL (https://www.postgresql.org/download/). Or use Brew:

```sh
brew install turbot/tap/powerpipe
brew install turbot/tap/postgresql
```

Clone:

```sh
git clone https://github.com/turbot/powerpipe-mod-youtuber.git
cd powerpipe-mod-youtuber
```

### Setup Data

Download the dataset:

- Download the [Global YouTube Statistics dataset](https://www.kaggle.com/code/nelgiriyewithana/an-introduction-to-the-global-youtube-statistics) (requires signup with [Kaggle](https://www.kaggle.com/))
  
Create a PostgreSQL database:

```sh
psql -U <username> -d postgres
create database youtube;
```

Connect to the database:

```sh
\c youtube
```

Create a table:

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

Load the dataset into the table:

```sh
\copy youtube_statistics(rank, youtuber, subscribers, video_views, category, title, uploads, country, abbreviation, channel_type, video_views_rank, country_rank, channel_type_rank, video_views_for_the_last_30_days, lowest_monthly_earnings, highest_monthly_earnings, lowest_yearly_earnings, highest_yearly_earnings, subscribers_for_last_30_days, created_year, created_month, created_date, gross_tertiary_education_enrollment_percent, population, unemployment_rate, urban_population, latitude, longitude)
from '~/Downloads/Global YouTube Statistics.csv' DELIMITER ',' CSV HEADER ENCODING 'ISO-8859-1';
```

## Usage

Run the dashboard and specify the DB connection string:

```sh
powerpipe server --database postgres://<username>@localhost:5432/youtube
```

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Powerpipe](https://powerpipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://powerpipe.io/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [Youtube Statistic Mod](https://github.com/turbot/powerpipe-mod-youtuber/labels/help%20wanted)
