# R Shiny app for mrt assay analysis

<https://sfrenk.shinyapps.io/mrt_assay_app/>

## Usage

Gives logrank test p-values for mrt assay data. The input file should be a csv with generation in the first column and number of fertile plates for each sample in subsequent columns. You can make the table in Excel as shown below and save as a csv:

![excel snapshot](images/excel_screenshot.png?raw=true)

## Censored data

You can optionally provide a table containing censored data (eg. plates that became contaminated and had to be removed from the experiment). This should have the same columns as the fertility data, except that the sample values should show the number of censored individuals at each generation. 
