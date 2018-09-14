library(shiny)
library(mortalgerm)

# Define server logic
shinyServer(function(input, output, session) {
    
    # Change plot when alpha and beta slider values change
    myData <- eventReactive(input$go, {
        
        infile <- input$file1
        censored <- input$file2
        
        if (is.null(infile)) {
            # User has not uploaded a file yet
            return(NULL)
        }
        df <- read.csv(infile$datapath, stringsAsFactors = FALSE)
        
        # Convert to mrt table
        # Inlcude censoring data if present
        if (is.null(censored)) {
            df_mrt <- make_mrt_table(df)
        } else {
            censored_df <- read.csv(censored$datapath, stringsAsFactors = FALSE)
            df_mrt <- make_mrt_table(df, censored = censored_df)
        }
        
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
    
    # Help link
    output$tab <- renderUI({
        url <- a("Help", href="https://github.com/sfrenk/mrt_assay_app/blob/master/README.md")
    })   
})