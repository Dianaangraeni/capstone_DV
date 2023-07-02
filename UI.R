#keseluruhan dari tampilan dashboard
dashboardPage(skin = "yellow",
              #menampilkan header / judul dashboard
              dashboardHeader(title = "Music X Mental Health"),
              #menampilkan informasi yang ada disidebar
              dashboardSidebar(collapsed = F,
                sidebarMenu(
                  menuItem("Overview", tabName = "page1", icon = icon("hand-holding-heart")),
                  menuItem("Music Genres on Mental Health", tabName = "page2", icon = icon("music")),
                  menuItem("Dataset", tabName = "page3", icon = icon("table"))
                ),
                #id tabName harus sama antara sidebar menu dan dashboardBody agar saling connect
                menuItem("Source Code", icon = icon("file-code"), 
                         href = "https://github.com/Dianaangraeni/capstone_DV")
              ),
              dashboardBody(
                tabItems(
                  tabItem(tabName="page1",
                          fluidPage(h2(tags$b("Music Effects on Mental Health")),
                          br(),
                          div(style = "text-align:justify", 
                              p("Music is one of the easily accessible means of entertainment 
                                          that can be enjoyed anywhere and anytime without disturbing people around 
                                          and without requiring any additional effort when someone needs entertainment 
                                          or a tool to relax their mind.", 
                                "Music has been shown to have a number of positive effects on mental health.",
                                "Some of the most well-studied effects of music on mental health include reduced stress and anxiety,
                    improved mood,and promoted relaxation and sleep"),
                    br()
                          ),
                    box(width = 8,
                        plotlyOutput(outputId = "ggmusic")),
                    
                    valueBox(width = 4,
                                             color = "maroon",
                                             icon = icon("users"),
                                             nrow(mxmh),
                                             "Number of Respondents"
                          ), 
                          valueBox(width = 4,
                                   color = "green",
                                   icon = icon("play"),
                                   length(unique(mxmh$Fav.genre)),
                                   "Total Unique Genres"),
                          valueBox(width = 4,
                                   color = "maroon",
                                   icon = icon("hand-holding-heart"),
                                   length(unique(mxmh_pivot$Mental_Health_types)),
                                   "Total Unique Mental Health Problems")
                          ),
                    
                    
                    
                    ),
                  tabItem(tabName = "page2",
                          fluidPage(
                            box(width=3,
                                height = 420,
                                background = "yellow",
                                selectizeInput(inputId="select_types",
                                               label = h4(tags$b("Select Type:")),
                                               choices= unique(mxmh_pivot$Mental_Health_types),
                                               multiple= F
                                            ),
                                selectizeInput(inputId="select_input",
                                               label = h4(tags$b("Select Level:")),
                                               choices= unique(mxmh_pivot$Level),
                                               multiple= F)),
                                
                            box(width=9,
                                solidHeader = T,
                                plotlyOutput(outputId = "anxplot")
                                ),
                            box(width=3,
                                background = "yellow",
                                radioButtons(inputId= "select_affect",
                                             label = "Choose Music Effects",
                                             choices =unique(mxmh$Music.effects))
                                ),
                            box(width=9,
                                plotlyOutput(outputId = "genreplot"))
                )),
                            
                  #Halaman ketiga
                  tabItem(tabName = "page3",
                          fluidPage(
                            box(width = 12,
                                title = "Dataset Music Effects on Mental Health on 2022",
                                dataTableOutput(outputId= "mxmh"))
                          )
                  ))
              ))

