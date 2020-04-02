## List all functions used in Rmd files

library(NCmisc)
library(knitr)

Rmd_files <- dir(pattern = glob2rx("*.Rmd"))
tmpdir <- tempdir()
output <- file.path(tmpdir, sub("Rmd$", "R", Rmd_files))

for(i in seq_along(Rmd_files)) {
        knit(Rmd_files[i], output[i], tangle = TRUE)
}

funs <- vector("list", length(output))
for(i in seq_along(output)) {
        funs[[i]] <- try({
                list.functions.in.file(output[i]) %>%
                        unlist(use.names = FALSE) %>%
                        unique()
        })
}
