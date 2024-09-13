library(shiny)
library(rgl)
library(bslib)
library(magrittr)

ui <- page_fillable(
  
  #Set theme
  theme = bs_theme(
    bg = "black", fg = "white", primary = "white",
    base_font = font_google("Space Mono"),
    code_font = font_google("Space Mono")
  ),
  
  titlePanel("Mammoths"),
  
  #make cards
  layout_columns(
    layout_columns(
      card(card_header("A View of Mammoth World"), plotOutput("spinny_globe")),
      card(plotOutput("temp_key")),
      col_widths=c(12,12),
      row_heights=c(4.5,1.5)
    ),
    navset_card_tab(
      title="Fossil Information",
      nav_panel("Mammoths", plotOutput("mammoth_info")),
      nav_panel("Fossil Map", plotOutput("mammoth_map")),
      nav_panel("Fossil Ages", plotOutput("mammoth_occurrences"))
    )
  )
)

server <- function(input, output, session){
  
  output$spinny_globe <- renderImage({
    filename <- normalizePath(file.path('~/Lyme_Regis_Final/',paste0('LGM.gif')))
    list(src = filename,
         contentType = 'image/gif',
         align="center",
         height="100%")
  }, deleteFile = FALSE)
  
  output$temp_key <- renderImage({
    filename <- normalizePath(file.path('~/Lyme_Regis_Final/',paste0('temperature-scale.png')))
    list(src = filename,
         contentType = 'image/png',
         align="center",
         width="90%",
         height="90%")
  }, deleteFile = FALSE)
  
  output$mammoth_info <- renderImage({
    filename <- normalizePath(file.path('~/Lyme_Regis_Final/',paste0('mammoth_pokedex.png')))
    list(src = filename,
         contentType = 'image/png',
         alt = "This is alternate text", height = "100%")
  }, deleteFile = FALSE)
  
  output$mammoth_map <- renderImage({
    filename <- normalizePath(file.path('~/Lyme_Regis_Final/',paste0('mammoth_pokedex_map.png')))
    list(src = filename,
         contentType = 'image/png',
         alt = "This is alternate text", height = "100%")
  }, deleteFile = FALSE)
  
  output$mammoth_occurrences <- renderImage({
    filename <- normalizePath(file.path('~/Lyme_Regis_Final/',paste0('mammoth_pokedex_ages.png')))
    list(src = filename,
         contentType = 'image/png',
         alt = "This is alternate text", height = "100%")
  }, deleteFile = FALSE)
  
}

shinyApp(ui, server)
