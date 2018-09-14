library(shiny)
library(mortalgerm)

# Define server logic
shinyServer(function(input, output, session) {
    
    # Change plot when alpha and beta slider values change
    myData <- eventReactive(input$go, {
        
        infile <- input$file1
        if (is.null(infile)) {
            # User has not uploaded a file yet
            return(NULL)
        }
        df <- read.csv(infile$datapath)
        
        # Convert to mrt table
        # TODO: Inlcude censoring data if present
        df_mrt <- make_mrt_table(df)
        
        # Do stats
        results <- perform_logranks(df_mrt, correct = TRUE)
        
        return(list(df_mrt, results))
        
    })
    
    # show table
    output$table_output <- renderTable({
        myData()[[2]]
    })
    
    # Render plot
    output$plot <- renderPlot({
        req(input$file1)
        x <- myData()[[1]]
        mrt_plot(x)
    })
    
    # Download results
    output$downloadData <- downloadHandler(
        filename = "results.csv",
        content = function(file) {
            write.csv(myData()[[2]], file, quote = FALSE)
        }
    )
})