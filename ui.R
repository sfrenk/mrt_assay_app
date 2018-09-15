library(shiny)

# Define User Interface
shinyUI(pageWithSidebar(
    
    # Title
    headerPanel(h1("Run stats on mrt assay")),
    
    # Set up sidebar panel
    sidebarPanel(

        # Mrt assay data
        fileInput("file1", "Upload CSV containing mrt assay data",
                  multiple = FALSE,
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv")),
        
        # Optional censoring data
        fileInput("file2", "Upload CSV containing censoring data (optional)",
                  multiple = FALSE,
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv")),
        
        fluidRow(
            # Run button
            column(3, actionButton("go", "Go!")),
        
            # Download button
            column(6, downloadButton("downloadData", "Download")),
        
            # Help
            column(3, uiOutput("help"))
        ),
        # Test info
        textOutput("test_info")
        
    ),
    
    # Show a table summarizing the values entered
    mainPanel(
        plotOutput("plot"),
        tableOutput("table_output")
    )
))
