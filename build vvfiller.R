################################################################################
### build_vusa.R
################################################################################
### R code voor Student Analytics Vrije Universiteit Amsterdam
### Copyright 2018 VU
### Web Page: http://www.vu.nl
### Contact: Theo Bakker (t.c.bakker@vu.nl)
###
### Bestandsnaam: build_vusa.R
### Doel: Dit script wordt gebruikt om het vusa pacakge te bouwen en te releasen
###
### Afhankelijkheden: Main script.R
###
### Gebruikte datasets: Datasets
###
### Opmerkingen:
### 1) Geen
###
################################################################################
### TODO:
### 1) Geen
###
################################################################################
### Geschiedenis:
### 28-09-2018: JvZ: Aanmaak bestand
################################################################################
## Set project name
package_name <- basename(rstudioapi::getActiveProject())
## =============================================================================
## Installeer en laad de packages in
build_packages <- c("devtools",
                    "usethis",
                    "renv")

## installeer de packages die nog niet geinstalleerd zijn
lapply(build_packages[which(!build_packages %in% installed.packages())],
       install.packages)

renv::load("../sa-scripts/")

## laad de packages in
invisible(lapply(build_packages,
                 library,
                 character.only = TRUE))

## =============================================================================
## Bouw het nieuwe vusa package

## Pull nu eerst de laatste versie (bvb via Smartgit)

## Create Manual
devtools::document()
devtools::check(manual = T)
devtools::test()
devtools::build_manual(path = paste0("G:/DSZ/SA2016/Datasets/Packages/package_man/", package_name, "/"))


## Commit je veranderingen in Smartgit (of handmatig in de terminal, naast console)
# Als je dit niet doet krijg je bij onderstaande (use_version) command de vraag:
#There are uncommitted changes and you're about to bump version
#Do you want to proceed anyway?
# Voordat je op deze vraag antwoord kun je ook nog committen, maar als je dit niet
# doet wordt er niks veranderd


## Hoog het versienummer op en check die wijziging in in Git
usethis::use_version()

## Bouw het package, en release het naar de juiste folder
devtools::build(path = paste0("G:/DSZ/SA2016/Datasets/Packages/", package_name, "/"))

## Maak weer gebruik van de development versie
usethis::use_dev_version()

## push changes
system("git push")
