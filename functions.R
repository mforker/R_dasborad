library(shinythemes)
library(lubridate)
library(tidyverse)
library(httr2)
library(jsonlite)
library(plotly)

get_close <- function(inst_key, duration) {
  end_point <- 'https://api.upstox.com/v2/historical-candle'
  instrument_key <- inst_key
  intv <- 'day'
  to_date <- today()
  from_date <- today() - (30 * as.numeric(duration))
  
  url <-
    paste0(end_point,
           '/',
           instrument_key,
           '/',
           intv,
           '/',
           to_date,
           '/',
           from_date)
  url <-
    url %>% URLencode()
  req <- request(url)
  res <<- req_perform(req)
  
  data <-
    resp_body_json(res)$data$candles %>% toJSON(pretty = TRUE) %>% fromJSON() %>% as.data.frame()
  data$V1 <- date(data$V1)
  data$V2 <- data$V2 %>% as.numeric()
  data$V3 <- data$V3 %>% as.numeric()
  data$V4 <- data$V4 %>% as.numeric()
  data$V5 <- data$V5 %>% as.numeric()
  
  y <- data[2:5]
  
  # PlotCandlestick(
  #   as.Date(data$V1),
  #   as.matrix(y),
  #   border = NA,
  #   las = 2,
  #   ylab = "",
  #   ylim = NULL,
  #   main = paste0(instrument_key,' Plot for ',duration, ' week(s)')
  # )
  data %>% 
    plot_ly(x = as.Date(data$V1),
            type = "candlestick",
            open = data$V2,
            high = data$V3,
            low = data$V4,
            close = data$V5)
  # return(p)
}

# get_close('Nifty 50',5)
