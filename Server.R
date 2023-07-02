#Mendefinisikan plot-plot
function(input, output, session) {
  #PLOT MUSIC EFFECTS
  output$ggmusic <- renderPlotly({
    # Data preparation
    Agg_music <- mxmh %>% 
      group_by(Music.effects) %>% 
      summarise(Frequency = n()) %>% 
      arrange(-Frequency)
    
    # Nambahin label
    Agg_music <- Agg_music %>% 
      mutate(label = glue("Effect: {Music.effects}
                      Amounts of Effects: {Frequency}"))
    
    
    # Plot statis
    ggmusic <- ggplot(data = Agg_music, aes(y = Frequency,  x= reorder(Music.effects, Frequency),
                                            text = label,
                                            fill= Music.effects)) +
      geom_bar(stat = "identity") +
      scale_fill_manual(values = c("tan2", "yellow3", "red"))+
      labs(title = "Music Effects on Mental Health 2022",
           x = "Music Effects",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    # Plot Interaktif
    ggplotly(ggmusic, tooltip = "text")
    
  })
  
  output$anxplot <- renderPlotly({
    #untuk plot lolipop
    anx <- mxmh_pivot %>% 
    filter(Level == input$select_input ,Mental_Health_types %in% input$select_types) %>% 
    group_by(Fav.genre, Level) %>% 
    summarise(Frequency=n()) %>% 
    arrange(-Frequency) %>% 
    head(10)
  
    # Nambahin label
    anx <- anx %>% 
    mutate(label = glue("Genre: {Fav.genre}
                      Frequency: {Frequency}"))
    
    # Plot Statis
    anxplot <- ggplot(anx, aes(x= Frequency,
                               y= reorder(Fav.genre, Frequency),
                               text=label,
                               color= Frequency)) +
      geom_point(size = 3)+
      geom_segment(aes(x=0,
                       y = reorder(Fav.genre, Frequency),
                       yend = reorder(Fav.genre, Frequency),
                       xend = Frequency), linewidth = 1.5)+
      scale_color_gradient(low = "tan1",
                           high = "tan4")+
      labs(title = glue(c("Top 10 Genres Listened to by People with {input$select_input} - {input$select_types}")),
           x = "Amounts",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    # Plot Interaktif
    ggplotly(anxplot,tooltip = "text")
    
  })
  
  #untuk plot line
  output$genreplot <- renderPlotly({
    # Data preparation
    Improve_musicgenre <- mxmh %>% 
      filter(Music.effects %in% input$select_affect) %>% 
      group_by(Fav.genre) %>% 
      summarise(Frequency = n()) %>% 
      arrange(-Frequency) %>% 
      head(10)
    # Nambahin label
    Improve_musicgenre <- Improve_musicgenre %>% 
      mutate(label = glue("Genre: {Fav.genre}
                      Amounts of Effects: {Frequency}"))
    
    
    # Plot Statis
    genreplot <- ggplot(data = Improve_musicgenre, aes(x = Frequency,
                                                       y = reorder(Fav.genre, Frequency),
                                                       text= label)) + # reorder(A, berdasarkan B)
      geom_col(aes(fill = Frequency)) +
      scale_fill_gradient(low = "tan1", high = "tan4") +
      labs(title = glue("Music Genres that have '{input$select_affect}' Mental Health"),
           x = "Amounts of Effects",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none",
            plot.title = element_text(hjust=0.5))
    
    
    # Plot Interaktif
    ggplotly(genreplot, tooltip = "text")
    
    
  })
  
  output$mxmh <- renderDataTable({datatable(mxmh,
                                                  options = list(scrollX = TRUE))
  })
  
  
  
}
