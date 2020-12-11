## Download Google Slides Images

library(tidyverse)
library(stringr)

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


## Edit URLs in Rmd files
files <- dir(pattern = glob2rx("0*.Rmd"))
dict <- cbind(url = infiles, newurl = outfiles)

for(i in seq_along(files)) {
        message(files[i])
        text <- read_lines(files[i])
        for(j in seq_len(nrow(dict))) {
                idx <- grep(dict[j, 1], text, fixed = TRUE)
                text[idx] <- sub(dict[j, 1], dict[j, 2], text[idx], fixed = TRUE)
        }
        write_lines(text, files[i])
}

















