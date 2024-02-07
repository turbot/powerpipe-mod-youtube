dashboard "monty_python_series_analysis_dashboard" {

  title = "Monty Python Series Analysis Dashboard"

  container {

    title = "Overview"

    card {
      query = query.total_episodes
      width = 3
    }

    card {
      query = query.total_segments
      width = 3
    }

    card {
      query = query.unique_characters
      width = 3
    }

    card {
      query = query.total_actors_participated
      width = 3
    }
  }

  container {

    title = "Series and Episode Analysis"

    chart {
      title = "Episodes by Series"
      query = query.episodes_by_series
      type  = "bar"
      width = 4
    }

    chart {
      title = "Number of Segments per Episode"
      query = query.segments_per_episode
      type  = "bar"
      width = 4
    }

    chart {
      title = "Episode Frequency by Transmission Date"
      query = query.episode_frequency_by_transmission_date
      type  = "line"
      width = 4
    }
  }

  container {

    title = "Content and Script Insights"

    chart {
      title = "Most Frequent Characters"
      query = query.most_frequent_characters
      type  = "bar"
      width = 4
    }

    chart {
      title = "Most Active Actors"
      query = query.most_active_actors
      type  = "bar"
      width = 4
    }

    chart {
      title = "Segment Types Distribution"
      query = query.segment_types_distribution
      type  = "pie"
      width = 4
    }
  }

  container {

    title = "Temporal Analysis"

    chart {
      title = "Episodes Over Time"
      query = query.episodes_over_time
      type  = "line"
      width = 6
    }

    chart {
      title = "Actor Participation Over Time"
      query = query.actor_participation_over_time
      type  = "line"
      width = 6
    }
  }
}

# Card Queries

query "total_episodes" {
  sql = <<-EOQ
    select
      count(distinct episode) as total_episodes
    from
      scripts;
  EOQ
}

query "total_segments" {
  sql = <<-EOQ
    select
      count(distinct segment) as total_segments
    from
      scripts;
  EOQ
}

query "unique_characters" {
  sql = <<-EOQ
    select
      count(distinct character) as unique_characters
    from
      scripts;
  EOQ
}

query "total_actors_participated" {
  sql = <<-EOQ
    select
      count(distinct actor) as total_actors_participated
    from
      scripts;
  EOQ
}

# Chart Queries

query "episodes_by_series" {
  sql = <<-EOQ
    select 
      series,
      count(distinct episode) as episode_count
    from
      scripts
    group by 
      series;
  EOQ
}

query "segments_per_episode" {
  sql = <<-EOQ 
    select
      episode,
      count(distinct segment) as segment_count
    from 
      scripts
    group by
      episode;
  EOQ
}

query "episode_frequency_by_transmission_date" {
  sql = <<-EOQ 
    select 
      date(transmission_date) as transmission_date,
      count(distinct episode) as episode_count
    from 
      scripts
    group by 
      transmission_date;
  EOQ 
}

query "most_frequent_characters" {
  sql = <<-EOQ 
    select
      character,
      count(*) as character_count
    from 
      scripts
    group by
      character
    order by
      character_count desc limit 5;
  EOQ
}

query "most_active_actors" {
  sql = <<-EOQ
    select
      actor,
      count(*) as actor_count
    from
      scripts
    group by
      actor
    order by
      actor_count desc limit 5;
  EOQ
}

query "segment_types_distribution" {
  sql = <<-EOQ 
    select
      type,
      count(*) as type_count
    from
      scripts
    group by 
      type;
  EOQ
}

query "episodes_over_time" {
  sql = <<-EOQ 
    select
      date(record_date) as record_date,
      count(distinct episode) as episode_count
    from
      scripts
    group by
      record_date;
  EOQ
}

query "actor_participation_over_time" {
  sql = <<-EOQ 
    select
      date(record_date) as record_date,
      count(distinct actor) as actor_count
    from
      scripts
    group by
      record_date;
  EOQ
}