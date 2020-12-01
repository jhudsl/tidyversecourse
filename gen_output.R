#!/Users/rdpeng/bin/Rscript

library(knitr)

inputs <- c("index.Rmd", 
            "01-intro.Rmd",
#            "02-get-data.Rmd",
#            "03-tidying.Rmd",
#	    "04-dataviz.Rmd",
#            "05-prediction.Rmd",
	    "about.Rmd")

lapply(inputs, function(input) {
        out <- knit(input)
        message(out)
        output <- file.path("manuscript", sub("^[^a-zA-Z]+", "", out))
        file.rename(out, output)
})

#system("rsync -av figure/ manuscript/figure/")
        

