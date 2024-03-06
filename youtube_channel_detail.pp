dashboard "youtube_channel_detail" {

  title         = "YouTube Channel Detail"
  documentation = file("./docs/youtube_channel_detail.md")

  input "youtube_id" {
    title = "Select a Channel:"
    query = query.youtube_channel_input
    width = 4
  }

  container {
    width = 12

    card {
      query = query.youtube_channel_type
      width = 2
      args  = [self.input.youtube_id.value]
      type  = "info"
    }

    card {
      query = query.youtube_video_view_rank
      width = 2
      args  = [self.input.youtube_id.value]
      type  = "info"
    }

    card {
      query = query.youtube_channel_uploads
      width = 2
      args  = [self.input.youtube_id.value]
      type  = "info"
    }

    card {
      query = query.youtube_channel_subscribers
      width = 2
      args  = [self.input.youtube_id.value]
      type  = "info"
    }

    card {
      query = query.youtube_channel_video_views
      width = 2
      args  = [self.input.youtube_id.value]
      type  = "info"
    }

    card {
      query = query.youtube_channel_rank
      width = 2
      args  = [self.input.youtube_id.value]
      type  = "info"
    }
  }

  container {
    width = 12

    table {
      title = "Channel Overview"
      width = 4
      type  = "line"
      query = query.youtube_channel_overview
      args  = [self.input.youtube_id.value]
    }

    chart {
      title = "Monthly Earnings Distribution"
      width = 4
      type  = "column"
      query = query.youtube_channel_monthly_earnings_distribution
      args  = [self.input.youtube_id.value]
    }

    chart {
      title = "Yearly Earnings Distribution"
      width = 4
      type  = "column"
      query = query.youtube_channel_yearly_earnings_distribution
      args  = [self.input.youtube_id.value]
    }
  }

}

# Input query

query "youtube_channel_input" {
  sql = <<-EOQ
    select
      youtuber as label,
      rank as value
    from
      youtube_statistics
    order by
      youtuber;
  EOQ
}

# Card queries

query "youtube_channel_uploads" {
  sql = <<-EOQ
    select
      'Total Uploads' as label,
      uploads as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

query "youtube_channel_subscribers" {
  sql = <<-EOQ
    select
      'Total Subscribers' as label,
      subscribers as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

query "youtube_channel_video_views" {
  sql = <<-EOQ
    select
      'Total Video Views' as label,
      video_views as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

query "youtube_channel_rank" {
  sql = <<-EOQ
    select
      'Channel Rank' as label,
      channel_type_rank as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

query "youtube_channel_type" {
  sql = <<-EOQ
    select
      'Channel Type' as label,
      channel_type as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

query "youtube_video_view_rank" {
  sql = <<-EOQ
    select
      'Video View Rank' as label,
      video_views_rank as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

# Overview table query

query "youtube_channel_overview" {
  sql = <<-EOQ
    select
      youtuber as "Channel",
      created_month as "Created Month",
      created_year as "Created Year",
      country_rank as "Country Rank",
      video_views_for_the_last_30_days as "Views (Last 30 Days)",
      subscribers_for_last_30_days as "Subscribers (Last 30 Days)",
      country as "Country",
      population as "Country Population",
      unemployment_rate as "Country Unemployment Rate",
      gross_tertiary_education_enrollment_percent as "Country Gross Tertiary Education Enrollment Percent"
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

# Additional queries

query "youtube_channel_monthly_earnings_distribution" {
  sql = <<-EOQ
    select
      'Lowest Monthly Earnings' as label,
      lowest_monthly_earnings as value
    from
      youtube_statistics
    where
      rank = $1
    union
    select
      'Highest Monthly Earnings' as label,
      highest_monthly_earnings as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}

query "youtube_channel_yearly_earnings_distribution" {
  sql = <<-EOQ
    select
      'Lowest Yearly Earnings' as label,
      lowest_yearly_earnings as value
    from
      youtube_statistics
    where
      rank = $1
    union
    select
      'Highest Yearly Earnings' as label,
      highest_yearly_earnings as value
    from
      youtube_statistics
    where
      rank = $1;
  EOQ
}