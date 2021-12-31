# ui.R

shinyUI(fluidPage(
  title = "Eval Seqs",

  titlePanel("Evaluate sequence quality"),
  sidebarLayout(
      sidebarPanel(
                
          helpText("Select multifasta formatted files to analyze:"),
          fileInput("file1", label = h3("Forward multifasta")),
          fileInput("file2", label = h3("Reverse multifasta")),
          downloadButton('downloadF', 'Download example Forward multifasta'),
          downloadButton('downloadR', 'Download example Reverse multifasta'),
      h5("Discussion at ", a("stihie.bit", href="http://www.stihie.net/lnsDFoKytr/2014/10/11/sequence-evaluation/"))),
      
    mainPanel(

        h1("Ambiguity count vs. nucleotide index"),
        h4("Forward read in black"),
        h4("Reverse read in red", style= "color:red"),
        
      plotOutput( "plot1" )       
    )       
  )
))





