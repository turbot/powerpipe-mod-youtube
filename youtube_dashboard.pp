dashboard "youtube_statistics_dashboard" {

  title         = "YouTube Channel Dashboard"
  documentation = file("./docs/youtube_dashboard.md")

  container {
    title = "Overview"

    card {
      query = query.youtube_total_channels
      width = 3
      type  = "info"
    }

    card {
      query = query.youtube_total_uploads
      width = 3
      type  = "info"
    }

    card {
      query = query.youtube_total_categories
      width = 3
      type  = "info"
    }

    card {
      query = query.youtube_total_countries
      width = 3
      type  = "info"
    }
  }

  container {
    title = "Performance Analysis"

    chart {
      type  = "column"
      title = "Top 10 YouTube Channels by Subscribers"
      query = query.youtube_top_10_channels_by_subscribers
      width = 6
      series "subscribers" {
        title = "Number of Subscribers"
        color = "turquoise"
      }
    }

    chart {
      type     = "column"
      title    = "Top 10 YouTube Channels: Video View vs Uploads"
      query    = query.youtube_video_view_vs_uploads
      width    = 6
      grouping = "compare"
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

  container {
    title = "Category and Channel Type Analysis"

    chart {
      type     = "column"
      grouping = "compare"
      title    = "Subscriber vs Video View by Category"
      query    = query.youtube_subscriber_vs_video_view_by_category
      width    = 6
    }

    chart {
      type  = "pie"
      title = "Distribution of YouTube Channel Types"
      query = query.youtube_distribution_of_channel_types
      width = 6
    }
  }

  container {
    title = "Geographic Distribution and Earnings"

    chart {
      type  = "donut"
      title = "Distribution of YouTube Channels Based on country"
      query = query.youtube_distribution_channels_by_country
      width = 6
    }

    chart {
      type  = "column"
      title = "Top 10 Youtubers Distribution of Earnings"
      query = query.youtube_distribution_of_earnings
      width = 6
    }
  }

  container {
    title = "Subscriber and View Trends"

    chart {
      type  = "line"
      title = "Channels Subscriber Growth (Last 30 Days)"
      query = query.youtube_channels_subscriber_growth_last_30_days
      width = 6
      series "Subscriber Growth (Last 30 Days)"{
        title = "Subscriber Growth (Last 30 Days)"
        color = "green"
      }
    }

    chart {
      type  = "line"
      title = "Channels View Growth (Last 30 Days)"
      query = query.youtube_channels_view_growth_last_30_days
      width = 6
      series "View Growth (Last 30 Days)"{
        title = "View Growth (Last 30 Days)"
        color = "darkorange"
      }
    }
  }
}

# Card Queries

query "total_channels" {
  sql = <<-EOQ
    select
      count(*) as "Total Channels"
    from
      youtube_statistics;
  EOQ
}

query "total_uploads" {
  sql = <<-EOQ
    select
      sum(uploads) as "Total Uploads"
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

# Chart Queries

query "top_10_channels_by_subscribers" {
  sql = <<-EOQ
    select
      youtuber,
      subscribers
    from
      youtube_statistics
    order by
      subscribers desc
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
      video_views desc
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
      category
    order by
      TotalSubscribers, TotalVideoViews desc;
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
      NumberOfChannels desc;
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
      NumberOfChannels desc;
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
      highest_monthly_earnings desc
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
