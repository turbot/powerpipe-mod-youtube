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

    # Card: Total Uploads of a Channel
    card {
      query = query.total_uploads_per_channel
      width = 3
      type  = "info"
    }

    # Card: Total Categories
    card {
      query = query.total_categories
      width = 3
      type  = "info"
    }

    # Card: Total countries
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
      series "subscribers" {
        title = "Number of Subscribers"
        color = "turquoise"
      }
    }

    # Chart: YouTube Channels: Subscriber vs Video View vs Uploads
    chart {
      type  = "column"
      title = "Top 10 YouTube Channels: Video View vs Uploads"
      query = query.video_view_vs_uploads
      width = 6

      legend {
        display  = "auto"
        position = "top"
      }

      series "video_views" {
        title = "Video Views"
        color = "purple"
      }
      series "uploads" {
        title = "Uploads"
        color = "blue"
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

    # Chart: Distribution of YouTube Channels Based on country
    chart {
      type  = "donut"
      title = "Distribution of YouTube Channels Based on country"
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

  # Container: Subscriber and View Trends
  container {
    title = "Subscriber and View Trends"

    # Chart:Channels Subscriber Growth in the Last 30 Days
    chart {
      type  = "line"
      title = "Channels Subscriber Growth (Last 30 Days)"
      query = query.channels_subscriber_growth_last_30_days
      width = 6
      series "Subscriber Growth (Last 30 Days)"{
        title = "Subscriber Growth (Last 30 Days)"
        color = "green"
      }
    }

    # Chart: Channels View Growth in the Last 30 Days
    chart {
      type  = "line"
      title = "Channels View Growth (Last 30 Days)"
      query = query.channels_view_growth_last_30_days
      width = 6
      series "View Growth (Last 30 Days)"{
        title = "View Growth (Last 30 Days)"
        color = "darkorange"
      }
    }
  }
}


query "total_channels" {
  sql = <<-EOQ
    select
      count(*) as "Total Channels"
    from
      youtube_statistics;
  EOQ
}

query "total_youtubers" {
  sql = <<-EOQ
    select
      count(distinct youtuber) as "Total YouTubers"
    from
      youtube_statistics;
  EOQ
}

query "total_categories" {
  sql = <<-EOQ
    select
      count(distinct category) as "Total Categories"
    from
      youtube_statistics;
  EOQ
}

query "total_countries" {
  sql = <<-EOQ
    select
      count(distinct country) as "Total Countries"
    from
      youtube_statistics;
  EOQ
}

query "total_uploads_per_channel" {
  sql = <<-EOQ
    select
      sum(uploads) as "Total Uploads"
    from
      youtube_statistics;
  EOQ
}

query "top_10_channels_by_subscribers" {
  sql = <<-EOQ
    select
      youtuber,
      subscribers
    from
      youtube_statistics
    order by
      subscribers DESC
    limit 10;
  EOQ
}

query "video_view_vs_uploads" {
  sql = <<-EOQ
    select
      youtuber,
      video_views,
      uploads
    from
      youtube_statistics
    order by
      subscribers DESC
    limit 10;
  EOQ
}

query "subscriber_vs_video_view_by_category" {
  sql = <<-EOQ
    select
      category,
      sum(subscribers) as TotalSubscribers,
      sum(video_views) as TotalVideoViews
    from
      youtube_statistics
    group by
      category;
  EOQ
}

query "distribution_of_channel_types" {
  sql = <<-EOQ
    select
      channel_type,
      count(*) as NumberOfChannels
    from
      youtube_statistics
    group by
      channel_type
    order by
      NumberOfChannels DESC;
  EOQ
}

query "distribution_channels_by_country" {
  sql = <<-EOQ
    select
      country,
      count(*) as NumberOfChannels
    from
      youtube_statistics
    group by
      country
    order by
      NumberOfChannels DESC;
  EOQ
}

query "distribution_of_earnings" {
  sql = <<-EOQ
    select
      youtuber,
      highest_monthly_earnings,
      highest_yearly_earnings
    from
      youtube_statistics
    order by
      highest_monthly_earnings DESC
    limit 10;
  EOQ
}

query "channels_subscriber_growth_last_30_days" {
  sql = <<-EOQ
    select
      youtuber,
      subscribers_for_last_30_days as "Subscriber Growth (Last 30 Days)"
    from
      youtube_statistics
    order by
      youtuber;
  EOQ
}

query "channels_view_growth_last_30_days" {
  sql = <<-EOQ
    select
      youtuber,
      video_views_for_the_last_30_days as "View Growth (Last 30 Days)"
    from
      youtube_statistics
    order by
      youtuber;
  EOQ
}
