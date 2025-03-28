# An Analysis of Air Pollution Levels in Tuchów, Poland 2010-2020

## Introduction
In this project, I analysed air pollution data, focusing on annual PM10 concentrations (μg/m³) in my hometown of Tuchów and comparing it with other Polish cities. Using data from the World Health Organisation (WHO) Ambient Air Quality Database and tools like DeepSeek to generate the code, and R and Tableau to analyse and visualise, I explored whether Tuchów's reputation for bad air quality was justified and how it changed from 2010 to 2020.

A few years ago, I was surprised to learn that Tuchów, a town of less than 7,000 people, ranked among Europe's top 30 most polluted cities in Europe. Since the smog was always a local joke, I wanted to see if the data supported the claims, how pollution had evolved, and how Tuchów compared to larger and similarly sized cities. PM10, a key component of smog, served as my primary metric due to its direct link to respiratory health risks.

## Analysis
The first graph (Figure 1) tracks Tuchów's PM10 levels over the decade, revealing a clear downward trend, from around 56 μg/m³ in 2010 to 31 μg/m³ in 2020. While this improvement is significant, early concentrations were significantly high, nearly triple the WHO's recommended annual limit of 20 μg/m³.

<div align="center">
  
![image](https://github.com/user-attachments/assets/d0f13e95-9e9a-4629-bdb5-66a8e4604bb4)

Figure 1
</div>

Comparing Tuchów to towns of similar size (Figure 2) showed it consistently ranked among the worst, with PM10 levels often doubling those of others. Even more striking was its performance against Poland's largest cities (Figure 3). Despite its tiny population, Tuchów's pollution largely exceeded major urban cities like Warsaw and Wrocław, with only two southern cities Kraków and Katowice, matching Tuchów's poor air quality.

<div align="center">
  
![image](https://github.com/user-attachments/assets/776bab77-e62c-4ead-b198-f0f08a773046)

Figure 2
</div>


<div align="center">
  
![image](https://github.com/user-attachments/assets/74175ce0-b9ac-48a2-a69d-6d3706482553)

Figure 3
</div>


The likely reasons? Tuchów's reliance on coal heating and its valley typography, which traps pollution during winter temperature layers. While larger cities struggle with emissions from traffic and industry, Tuchów's smog appears driven by household fuel use and stagnant air. Figure 4 combines the previous two graphs, showing how Tuchów compares to cities with similar populations and the highest populations of Poland.

<div align="center">
  
![image](https://github.com/user-attachments/assets/bd33dc4d-720c-439e-87a4-8484a7d026f4)

Figure 4
</div>


The Tableau dashboard ([click here to access](https://public.tableau.com/app/profile/monika.pekosz3314/viz/PolandPollutionLevelsDashboard/AveragePM10)) visualises these trends on an interactive map, highlighting a clear north-south divide. Southern cities, often located in valleys (Figure 5), suffer the worst air quality, while northern regions benefit from open plains and coastal winds. However, I was very glad to find that overall, the PM10 levels in Polish cities have reduced over the decade and that Tuchów went from being the 13th most polluted city in Poland in 2010 to being the 19th in 2020! It might not be a big one but it is still an improvement :)

<div align="center">
  
![image](https://github.com/user-attachments/assets/260aa99b-71a7-4cf8-862f-2c99937907a7)

Figure 5
</div>

## Methods
To create these visualisations, I used R libraries like ggplot2 for plotting, dplyr for data wrangling, and ggthemes for styling. I also chose the FiveThirtyEight theme, which gave the graphs a polished, professional look without much need of manual customisation, while RColorBrewer ensured visually cohesive colour schemes, as well as made sure they were colour blindness friendly.

## Limitations
While the data reveals clear trends, there are many gaps in this analysis. First, the WHO dataset is incomplete with many NA values among Polish cities. Second, I couldn't account for hyperlocal factors like weather patterns or shifts in heating policies, which might explain yearly fluctuations. Finally, PM10 alone doesn't capture other harmful pollutants (e.g., PM2.5 or NO₂), so the full health impact might be underestimated.

## Conclusion
Tuchów's air has improved, but its geography and energy habits keep it a pollution hotspot. It serves as some proof that size and industry isn't everything when it comes to smog and the quality of air. The project also underscores how valley locations, like Tuchów and Kraków, face more air quality challenges due to their locations, compared to northern cities in Poland.

---

**Data sources**: who_ambient_air_quality_database (can be accessed through the repository below)  
**Tools used**: R, Tableau, DeepSeek    
**Code Repository**: https://github.com/monipek/Tuchow_Pollution_Analysis
