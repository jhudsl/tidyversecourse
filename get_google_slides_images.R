## Download Google Slides Images

library(tidyverse)

files <- dir(pattern = glob2rx("0*.Rmd"))
text <- lapply(files, read_lines) %>%
        unlist(use.names = FALSE)
links <- grep("docs.google.com/presentation", text, fixed = TRUE,
              value = TRUE)
urls <- str_match(links, "(http.*)\\)")
infiles <- urls[, 2]
outfiles <- file.path("gslides", 
                      paste(formatC(seq_along(infiles),
                                    flag = "0", width = 3),
                            "png", sep = "."))

for(i in seq_along(infiles)) {
        message(infiles[i])
        download.file(infiles[i], outfiles[i])
        Sys.sleep(1)
}
