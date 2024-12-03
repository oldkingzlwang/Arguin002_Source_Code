# Supplementary Codes for the Manuscript:
**“Genesis and timing of KREEP-poor lunar Mg-suite magmatism indicated by the first norite meteorite Arguin 002”**
*Authors: Wang Z. L., Tian W., Wang W.-R., Prissel T. C., Di Y. K., Qian Y. Q., Liu P. P., Fa W. Z., Su A.*
*Submitted to Communications Earth & Environment, December 2024.*

## Overview
This repository contains supplementary MATLAB codes and associated data files for generating the figures presented in the manuscript. Each main function directly generating a figure is named after the format ```Figx.m```, where ```x``` corresponds to the figure number in the manuscript. Below, you will find detailed descriptions of each code and the associated data files required to execute them.

## Code and Data Descriptions
### 1. ```Fig2ab.m```
  * Purpose: Generates Fig. 2a-b in the manuscript.
  * Required Data Files:
    1. ```fig2_data1.xlsx```:
       * Contains:
         * Mg# of orthopyroxene and An# of plagioclase in Apollo and meteoritic Mg-suite rocks (worksheet: PlPx).
         * Bulk major and rare-earth element (REE) compositions of Mg-suite rocks (worksheet: Bulk).
       * Sources: Cao et al. (2024), Gross et al. (2020), Hulsey & O'Sullivan (2024), Roberts et al. (2019), Wieczorek et al. (2006).
    2. ```Elardo2023PMELTS.xlsx```:
       * Derived from the supplementary file of Elardo & Astudillo Manosalva (2023).
       * Contains the evolution trends of orthopyroxene Mg# and plagioclase An# for Mg-suite parental magmas with varying KREEP components.
  * Output:
    * A PDF file named ```fig2ab.pdf```, corresponding to Fig. 2a-b in the manuscript.
### 2. ```Fig2cde.m```
  * Purpose: Generates Fig. 2c-e in the manuscript.
  * Required Data Files:
    1. ```fig2_data2.xlsx```:
       * Summarizes REE contents in silicate minerals (orthopyroxene, clinopyroxene, and plagioclase) from Apollo and meteoritic Mg-suite rocks/clasts.
       * Sources: Cao et al. (2024), Gross et al. (2020), Hulsey & O'Sullivan (2024), Roberts et al. (2019), Shervais & McGee (1998).
  * Output:
    * A PDF file named ```fig2cde.pdf```, corresponding to Fig. 2c-e in the manuscript.

