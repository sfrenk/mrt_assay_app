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
        
        # Run button
        actionButton("go", "Go!"),
        
        # Download button
        downloadButton("downloadData", "Download")
        
    ),
    
    # Show a table summarizing the values entered
    mainPanel(
        plotOutput("plot"),
        tableOutput("table_output")
    )
))