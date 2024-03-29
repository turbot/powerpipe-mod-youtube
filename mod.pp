mod "youtube" {
  title         = "YouTube"
  description   = "Explore comprehensive insights into YouTube channel performance, including subscriber growth, video engagement, and earnings analysis, through interactive visualizations crafted with PostgreSQL queries via Powerpipe."
  color         = "#FF0000"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/youtube-insights.svg"
  categories    = ["dashboard", "postgres"]

  opengraph {
    title       = "Powerpipe Mod for YouTube"
    description = "Explore comprehensive insights into YouTube channel performance, including subscriber growth, video engagement, and earnings analysis, through interactive visualizations crafted with PostgreSQL queries via Powerpipe."
    image       = "/images/mods/turbot/youtube-insights-social-graphic.png"
  }
}
