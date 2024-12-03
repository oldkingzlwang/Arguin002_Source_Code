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
### 3. ```Fig3.m```
  * Purpose: Generates Fig. 3 in the manuscript.
  * Required Data Files:
    1. ```fig3_data.xlsx```:
       * Contains bulk trace element compositions of lunar meteorites.
       * Source: Supplementary Table 3a of Korotev & Irving (2021).
  * Output:
    * A PDF file named ```fig3.pdf```, corresponding to Fig. 3 in the manuscript.
### 4. ```Fig5.m```
  * Purpose: Generates Fig. 5 in the manuscript.
  * Required Data Files:
    1. ```fig5_data.xlsx```:
       * Contains parental magma REE compositions calculated from reported mineral trace-element compositions of KREEP-free Mg-suite clasts in lunar meteorites.
       * Sources: Cao et al. (2024), Gross et al. (2020), Hulsey & O'Sullivan (2024), Roberts et al. (2019).
    2. Intermediate ```.mat``` files:
       * ```fig5_mantle.mat```: Lunar mantle REE compositions (CI-chondrite unnormalized) generated from ```Make_primary.m```.
       * ```fig5_melt.mat```: Partial melt REE compositions (CI-chondrite normalized) generated from ```Make_primary.m```.
  * Additional Required Scripts:
    1. ```Make_primary.m```
       * Reconstructs trace element compositions of a cumulate lunar mantle region.
       * Uses the ```makemantle``` function and needs to specify:
          * Initial REE composition of the lunar magma ocean (LMO).
          * LMO crystallization mode (```E11TWM``` and ```E11LPUM``` functions).
          * Solidification degree of the LMO (PCS).
          * Content of trapped instantaneous residual liquid (TIRL).
       * Calls ```melt_calc.m``` for partial melting REE modeling.
    2. ```melt_calc.m```:
       * Models REE contents of partial melts from the lunar mantle region.
       * Requires inputs such as melting degree (F) and melting mode (batch or fractional).
  * Output:
    * A PDF file named ```fig5.pdf```, corresponding to Fig. 5 in the manuscript.

## Notes
  * Ensure all required ```.xlsx``` files and additional scripts (```Make_primary.m```, ```melt_calc.m```) are in the same directory as the main MATLAB scripts before execution.
  * MATLAB R2023b was used to execute these scripts in December 2024.

## References
* Cao, H. J., Chen, J., Yin, C. X., Fu, X. H., Ling, Z. C., Che, X. C. (2024). The lithologic diversity of the Moon recorded in lunar meteorites Northwest Africa 7611 and 10480. *Meteoritics & Planetary Science*, 59(3), 435–474. ```doi:10.1111/maps.14131```.
* Gross, J., Hilton, A., Prissel, T. C., Setera, J. B., Korotev, R. L., and Calzada-Diaz, A. (2020). Geochemistry and Petrogenesis of Northwest Africa 10401: A New Type of the Mg-Suite Rocks. *Journal of Geophysical Research: Planets*, 125, e2019JE006225. ```doi:10.1029/2019JE006225```.
* Elardo, S. M. and Astudillo Manosalva, D. F. (2023). Complexity and ambiguity in the relationships between major lunar crustal lithologies and meteoritic clasts inferred from major and trace element modeling. *Geochimica et Cosmochimica Acta*, 354, 13–26. ```doi:10.1016/j.gca.2023.05.020```.
* Hulsey, C. R., and O’Sullivan, K. M. (2024). Petrographic and geochemical analysis of lunar meteorite NWA 11788: Parallels with Luna 20 and the Apollo magnesian granulites. *Meteoritics & Planetary Science*, 1-26. ```doi: 10.1111/maps.14248```.
* Korotev, R. L., and Irving, A. J. (2021). Lunar meteorites from northern Africa. *Meteoritics & Planetary Science*, 56, 206–240. ```doi:10.1111/maps.13617```.
* Roberts, S. E., McCanta, M. C., Jean, M. M., and Taylor, L. A. (2019). New lunar meteorite NWA 10986: A mingled impact melt breccia from the highlands—A complete cross section of the lunar crust. *Meteoritics & Planetary Science*, 54, 3018–3035. ```doi:10.1111/maps.13406```.
* Shervais, J. W., and McGee, J. J. (1999). Petrology of the Western Highland Province: Ancient crust formation at the Apollo 14 site. *Journal of Geophysical Research*, 104, 5891–5920. ```doi:10.1029/1998JE900025```.
* Wieczorek, M. A., Jolliff, B. L., Khan, A., Pritchard, M. E., Weiss, B. P., Williams, J. G., Hood, L. L., Righter, K., Neal, C. R., Shearer, C. K., McCallum, I. S., Tompkins, S., Hawke, B. R., Peterson, C., and Gillis, J. J. (2006). The Constitution and Structure of the Lunar Interior. *Reviews in Mineralogy and Geochemistry*, 60, 221–364. ```doi:10.2138/rmg.2006.60.3```.

## Contact
If you encounter any issues, questions, or have suggestions, please contact the author via email: ```zilong.wang@pku.edu.cn```.
Good luck!
