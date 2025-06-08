#!/usr/local/bin/Rscript

options()$repos 
options()$BioC_mirror
options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
options("repos" = c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options()$repos 
options()$BioC_mirror

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("servr", ask = F, update = T, force = TRUE)
BiocManager::install("bookdown", ask = F, update = T, force = TRUE)
BiocManager::install("tinytex", ask = F, update = T, force = TRUE)

# tinytex::tlmgr_repo('http://mirrors.tuna.tsinghua.edu.cn/CTAN/')
tinytex::install_tinytex()
