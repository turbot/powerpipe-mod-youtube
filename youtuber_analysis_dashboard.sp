dashboard "youtube_statistics_dashboard" {
  title = "YouTube Channel Statistics Dashboard"

  # Container: Overview
  container {
    title = "Overview"

    # Card: Total Channels
    card {
      query = query.total_channels
      width = 3
      type  = "info"
    }

    # Card: Total YouTubers
    card {
      query = query.total_youtubers
      width = 3
      type  = "info"
    }

    # Card: Total Categories
    card {
      query = query.total_categories
      width = 3
      type  = "info"
    }

    # Card: Total Countries
    card {
      query = query.total_countries
      width = 3
      type  = "info"
    }
  }

  # Container: Top Channels and Performance Analysis
  container {
    title = "Performance Analysis"

    # Chart: Top 10 YouTube Channels by Subscriber
    chart {
      type  = "column"
      title = "Top 10 YouTube Channels by Subscribers"
      query = query.top_10_channels_by_subscribers
      width = 6
    }

    # Chart: YouTube Channels: Subscriber vs Video View vs Uploads
    chart {
      type  = "column"
      title = "Top 10 YouTube Channels: Video View vs Uploads"
      query = query.subscriber_vs_video_view_vs_uploads
      width = 6

      legend {
        display  = "auto"
        position = "top"
      }

      series "Video Views" {
        title = "Video Views"
        color = "green"
      }
      series "Uploads" {
        title = "Uploads"
        color = "red"
      }
    }
  }

  # Container: Category and Channel Type Analysis
  container {
    title = "Category and Channel Type Analysis"

    # Chart: Subscriber vs Video View by Category
    chart {
      type  = "column"
      title = "Subscriber vs Video View by Category"
      query = query.subscriber_vs_video_view_by_category
      width = 6
    }

    # Chart: Distribution of YouTube Channel Types
    chart {
      type  = "pie"
      title = "Distribution of YouTube Channel Types"
      query = query.distribution_of_channel_types
      width = 6
    }
  }

  # Container: Geographic Distribution and Earnings
  container {
    title = "Geographic Distribution and Earnings"

    # Chart: Distribution of YouTube Channels Based on Country
    chart {
      type  = "donut"
      title = "Distribution of YouTube Channels Based on Country"
      query = query.distribution_channels_by_country
      width = 6
    }

    # Chart: Distribution of Earnings
    chart {
      type  = "column"
      title = "Top 10 Youtubers Distribution of Earnings"
      query = query.distribution_of_earnings
      width = 6
    }
  }
}


query "total_channels" {
  sql = <<-EOQ
    SELECT COUNT(*) AS "Total Channels"
    FROM YouTubeStatistics;
  EOQ
}

query "total_youtubers" {
  sql = <<-EOQ
    SELECT COUNT(DISTINCT Youtuber) AS "Total YouTubers"
    FROM YouTubeStatistics;
  EOQ
}

query "total_categories" {
  sql = <<-EOQ
    SELECT COUNT(DISTINCT category) AS "Total Categories"
    FROM YouTubeStatistics;
  EOQ
}

query "total_countries" {
  sql = <<-EOQ
    SELECT COUNT(DISTINCT Country) AS "Total Countries"
    FROM YouTubeStatistics;
  EOQ
}

query "top_10_channels_by_subscribers" {
  sql = <<-EOQ
    SELECT Youtuber, subscribers
    FROM YouTubeStatistics
    ORDER BY subscribers DESC
    LIMIT 10;
  EOQ
}

query "subscriber_vs_video_view_vs_uploads" {
  sql = <<-EOQ
    SELECT Youtuber, video_views, uploads
    FROM YouTubeStatistics
    ORDER BY subscribers DESC
    limit 10;
  EOQ
}

query "subscriber_vs_video_view_by_category" {
  sql = <<-EOQ
    SELECT category, SUM(subscribers) AS TotalSubscribers, SUM(video_views) AS TotalVideoViews
    FROM YouTubeStatistics
    GROUP BY category;
  EOQ
}

query "distribution_of_channel_types" {
  sql = <<-EOQ
    SELECT channel_type, COUNT(*) AS NumberOfChannels
    FROM YouTubeStatistics
    GROUP BY channel_type
    ORDER BY NumberOfChannels DESC;
  EOQ
}

query "distribution_channels_by_country" {
  sql = <<-EOQ
    SELECT Country, COUNT(*) AS NumberOfChannels
    FROM YouTubeStatistics
    GROUP BY Country
    ORDER BY NumberOfChannels DESC;
  EOQ
}

query "distribution_of_earnings" {
  sql = <<-EOQ
    SELECT Youtuber, highest_monthly_earnings, highest_yearly_earnings
    FROM YouTubeStatistics
    ORDER BY highest_monthly_earnings DESC
    LIMIT 10;
  EOQ
}
