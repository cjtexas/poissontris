fluidPage(
    
    includeCSS(file.path("css", "styles.css")),
    
    tags$head(tags$title("Poissontris")), # window header
    
    h1(class = "hidden-xs hidden-s", "poissontris - a shiny app", span("(poisson-sampled block sizes)"),
        img(src = "logo_text.png", style = "float:right; width:240px;")        
    ),
    
    
    # keyboard inputs
    tags$script('
            var leftCounter = 0;
            var downCounter = 0;
            var rightCounter = 0;
            var clockCounter = 0;
            var counterCounter = 0;
            $(document).on("keydown", function (e) {
            switch (e.which) {
            case 40:
            Shiny.onInputChange("down", 50);
            Shiny.onInputChange("downCounter", ++downCounter);
            break;
            case 39:
            Shiny.onInputChange("right", 50);
            Shiny.onInputChange("rightCounter", ++rightCounter);
            break;
            case 37:
            Shiny.onInputChange("left", 50);
            Shiny.onInputChange("leftCounter", ++leftCounter);
            break;
            case 83:
            Shiny.onInputChange("counter", ++counterCounter);
            break;
            case 68:
            Shiny.onInputChange("clock", ++clockCounter);
            break;
            case 38:
            Shiny.onInputChange("clock", ++clockCounter);
            break;
            case 70:
            Shiny.onInputChange("swap", Math.random(1));
            break;
            case 13:
            Shiny.onInputChange("startGame", Math.random(1));
            break;
            }});
            '), 
    tags$script('
            $(document).on("keyup", function (e) {
            switch (e.which) {
            case 40:
            Shiny.onInputChange("down", 30);
            break;
            case 39:
            Shiny.onInputChange("right", 30);
            break;
            case 37:
            Shiny.onInputChange("left", 30);
            break;
            }});
            '), 
    
    # TODO column around this
    fluidRow(
        style="max-height:95vh;",
        column(4, offset=1,
               class = "hidden-xs",
               htmlOutput(outputId = "pdfTitle", container = h4),
               uiOutput("pdf", style="height: auto; width: 33vh;"), 
               div(class = "hidden-xs hidden-s", 
                                
                                h3(icon("arrow-alt-circle-left", class = "fa-2x"), icon("arrow-alt-circle-down", class = "fa-2x"),
                                   icon("arrow-alt-circle-right", class = "fa-2x"),
                                   ": move left, down, right"),
                                h3(icon("arrow-alt-circle-up", class = "fa-2x"), ": rotate clockwise"),
                                h3("s : rotate counterclockwise"),
                                h3("f : swap pieces")
                                
               )
               
        ),
        column(4,
            id = "game-container",
            fluidRow(
              div(
                id = "xs-next-piece",
                style = "float: right; width:25%; padding-top: 10%;",
                class = "visible-xs",
                h6(HTML("&lambda;:"), textOutput(outputId = "lambdaXS", inline = TRUE)),
                h6("Score: ", textOutput(outputId = "scoreXS", inline = TRUE)),
                h6(icon("trophy", class = "fa-2x"), textOutput("highScoreXS", inline = TRUE)),
                h6("Next piece"),
                uiOutput("nextPieceXS", style="width: 100%;"),
                htmlOutput(outputId = "pdfTitleXS", container = h6),
                uiOutput("pdfXS", style="height: auto; width: 100%;")
              ),
              div(
                style = "width: 75%; padding-top:165%; position:relative",
                column(12, 
                       uiOutput("s1", style="height:100%;"), style="top: 0; left: 0; right: 0; bottom: 0; position:absolute; height:80%; width:100%;"),
                column(12, 
                      uiOutput("s2", style="height:100%;"), style="top: 0; left: 0; right: 0; bottom: 0; position:absolute; height:80%; width:100%;"),
                column(12, 
                      uiOutput("s3", style="height:100%;"), style="top: 0; left: 0; right: 0; bottom: 0; position:absolute; height:80%; width:100%;"), 
                column(12, 
                      uiOutput("s4", style="height:100%;"), style="top: 0; left: 0; right: 0; bottom: 0; position:absolute; height:80%; width:100%;"),
                column(12,
                       style = "position: absolute; top: 80%; height:20%;",
                       fluidRow(
                           column(3,
                                  class = "col-xs-3",
                                  actionButton(inputId = "left", label = "", style = "display: none;"),
                                  actionButton(inputId = "leftCounter", icon("arrow-alt-circle-left", class = "fa-2x"))
                           ),
                           column(3,
                                  class = "col-xs-3",
                                  actionButton(inputId = "clock", icon("redo", class = "fa-2x"))
                           ),
                           column(3,
                                  class = "col-xs-3",
                                  actionButton(inputId = "counter", icon("undo", class = "fa-2x")) 
                           ),
                           column(3,
                                  class = "col-xs-3",
                                  actionButton(inputId = "right", label = "", style = "display: none;"), 
                                  actionButton(inputId = "rightCounter", icon("arrow-alt-circle-right", class = "fa-2x"))
                           ),
                           column(3,
                                  class = "col-xs-3",
                                  actionButton(inputId = "startGame", icon("play-circle", class = "fa-2x"))
                           ),
                           column(3,
                                  class = "col-xs-3",
                                  actionButton(inputId = "down", label = "", style = "display: none;"),
                                  actionButton(inputId = "downCounter", icon("arrow-alt-circle-down", class = "fa-2x")),
                                  actionButton(inputId = "clicks", label = "", style = "display: none;")
                           ),
                           column(3,
                                  class = "col-xs-3",
                                  div(
                                    onclick = "Shiny.onInputChange(\"down\", 50); Shiny.onInputChange(\"downCounter\", ++downCounter);",
                                    class = "btn btn-default action-button",
                                    icon("arrow-alt-circle-down", class = "fa-2x")
                                  )
                           ),
                           column(3,
                                  class = "col-xs-3",
                                  actionButton(inputId = "swap", icon("sync", class = "fa-2x")) 
                           )
                       )
                ))
            )), 
        
        column(2,
            
            h3(HTML("&lambda;:"), textOutput(outputId = "lambda", inline = TRUE), class = "hidden-xs"),
            # h3(textOutput(outputId = "leftCounter")),
            h3("Score: ", textOutput(outputId = "score", inline = TRUE), class = "hidden-xs"),
            h3(icon("trophy", class = "fa-2x"), textOutput("highScore", inline = TRUE), class = "hidden-xs"),
            h4("Next Piece: ", style = "margin-top: 50px;", class = "hidden-xs"), 
            uiOutput("nextPiece", style="width: 170px; height: 170px;", class = "hidden-xs")
            # button(onclick = "Shiny.onInputChange(\"left\", 50); Shiny.onInputChange(\"leftCounter\", ++leftCounter);", "Left"),
        )
    
    )



)

