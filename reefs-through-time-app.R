library(shiny)
library(rgl)
library(bslib)
library(magrittr)

ui <- page_fillable(
  
    theme = bs_theme(
      bg = "black", fg = "white", primary = "white",
      base_font = font_google("Space Mono"),
      code_font = font_google("Space Mono")
    ),
  
  layout_columns(
    layout_columns(
      card(card_header("REEFS THROUGH TIME"),
           card_body(
             plotOutput("plot1")
           )),
      card(card_header("SLIDE THROUGH TIME:"),
           card_body(
             sliderInput("age", "age in millions of years",
                         min = -540, max = 0, value = 0,
                         width="100%")
           )),
      col_widths=c(15,15)
      ),
    card(
      card_header("REEF BUILDERS"),
         card_body(
           fill=TRUE, gap=0,
           plotOutput("plot2")
        )
      ),
    col_widths=c(6,6)
    )
)


server <- function(input, output, session) {

  output$plot1 <- renderImage({

    age <- abs(input$age)
    
    files <- list.files(path = "~/Lyme_Regis_Final/Reef_maps_no_key/", pattern = "\\.png$", ignore.case = TRUE)
    
    # horrible way of doing this but i'm tired...
    files2 <- sub("\\_MaBP.*", "", files)
    files3 <- sub("Reef_maps_key_", "", files2)
    files4 <- sub("Reef_maps_no_key_", "", files3)
    files5 <- sub("\\_.*", "", files4)
    
    ages <- as.numeric(files5)
    
    file.no <- which.min(abs(age - ages))
    filename.short <- files[file.no]
    # filename <- normalizePath(file.path('~/phanerozoic.cGENIExl/reef_maps/Reef_maps_no_key_019_5_MaBP_Lower_Miocene_reefs_HADCM3L_Lunt_Scotese_20240604b.png'))
    filename <- normalizePath(file.path(paste0('~/Lyme_Regis_Final/Reef_maps_no_key/', filename.short)))
    
    # filename <- normalizePath(file.path('~/shiny_exps/Lyme_Regis/',paste0('Jurassic.gif')))

    list(src = filename,
         contentType = 'image/png',
         alt = "This is alternate text", height="100%", width = "100%")
  }, deleteFile = FALSE)
  
  output$plot2 <- renderImage({
    
    
    filename <- normalizePath(file.path('~/Lyme_Regis_Final/',paste0('reefs_key.png')))
    
    list(src = filename,
         contentType = 'image/png',
         alt = "This is alternate text", width = "100%")
  }, deleteFile = FALSE)
  
  
}

shinyApp(ui, server)
