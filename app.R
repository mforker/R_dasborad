library(shiny)
source('functions.R')

ui <- navbarPage(title = "Dashboard",
                 tabPanel(
                   "Candlestick Plot",
                   sidebarLayout(
                     position = 'right',
                     sidebarPanel(
                       selectizeInput(
                         'instrument_key',
                         'Select instrument key:',
                         choices = c("Nifty 50" = 'NSE_INDEX|Nifty 50',
                                     "Reliance Industries" = "NSE_EQ|INE002A01018",
                                     "SBI Bank" = "NSE_EQ|INE062A01020",
                                     "GAIL" = "NSE_EQ|INE129A01019",
                                     "MRF" = "NSE_EQ|INE883A01011"),
                         selected = "Nifty 50"
                       ),
                       selectizeInput('duration',
                                      'Duration in months :',
                                      choices = c(1L, 2L, 3L, 4L, 5L, 6L)),
                       strong('Here, you can use the dropdown menu to select the instrument name and the duration for which you want to see the candelstick chart.')
                     ),
                     mainPanel(
                       strong(h4("Please wait. The Chart may take few seconds to load fully.")),
                       h2("Candlestick Plots:"),
                       HTML('This dashboard fetches the price data for different stock market instruments using the free <b>Upstox public api</b> and plots candle stick charts. <br/><br/>There are may features in this candelstick chart. You can hover over the candlesticks to see the OHLC values also use the slider at the bottom to zoom in and out in the chart.'),
                       br(),
                       plotlyOutput('candlestick'))
                   )
                 ),
                 tabPanel(
                   "About this Project",
                   HTML(
                     '
                     <h3>Hey !!</h3> <br/><br/>
                     <h4>
                   I am Mitesh Nandan and this is a dashboard that I made using R programming. Its hard to realise the full potential of a programming language such as R. This project uses R packages such as <b>tidyverse, httr2, shiny, lubridate and plotly</b> to fetch data and render beautiful candlestick charts.Creating an online dashboard to make information more  handy is something I believe makes an important difference in effective decision making. 
                   <br/><br/>
                   However, this may seem really basic, I can also run Linear Regression and kmeans ML algorithms on datasets using R programming. I am also learning python and can read and write basic codes in other languages such as php and javascript.
                   </h4>
                     ')
                   
                 ))

server <- function(input, output, session) {
  output$candlestick <-
    renderPlotly(get_close(input$instrument_key, input$duration))
}

shinyApp(ui, server)