# Data Animation Tutorial
Thanks for your interest in data animations. I'm no expert in this area, but I've put together these short tutorials to show you how far you can get with just a little bit of knowledge. 
## What's in these tutorials?
These tutorials contain 3 data animations. In some ways they are not that good and demonstrate the fact that data animations are not always a good way to communicate information. However, they show you some of the options available for animations and include reading in files and other basic parts of R that you'll need.

These animation use gganimate which in turn uses ggplot, a popular R package for graphs. The actual animations part is quite straight-forward and more time is spent working with ggplot. This is not an introduction to ggplot: you should be able to follow along even if you have not used ggplot before, but you could really benefit from finding out more about how to use ggplot. The first (free) chapter of [this Datacamp course](https://www.datacamp.com/courses/data-visualization-with-ggplot2-1) would be a useful introduction.
## What do I need to follow them?
R, R Studio and a few packages. More specifically, you'll need R version 3.1 or greater (tested on 3.4.3, documentation indicates should work on 3.1). The packages you'll need are *gapminder, gifski, png, tidyverse* and *RColorBrewer*. ggplot, which gganimate depends on, will need to be version 3.0 or greater, so if you have an older version you might need to update that.

Instructions on how to install packages are included in the lab01 document. All of the instructions are available in the Wiki section

## So what do these animations look like?

Note that these animations have been set not to keep repeating (except the last one). It's useful to be able to decide whether or not it should repeat, which is why it is part of the tutorial, although maybe not so great for showcaing the animation.

The first one is a bubble chart changing over time. This is a legitimate use of data visualisation, as it conveys an extra dimension of data, as it shows how relationships change over time. This is not a great example, as the tutorial is designed to show how parameters can be fiddled with, and it was designed to make the end result different from the started point, not better.

![alt_text](https://github.com/deangordon/dataAnimationTutorial/blob/master/gapMinder.gif "Gapminder")

The second gif is a line graph that builds up cumulatively. There are quite a few steps in lab02 to take you from a static graph to this animation, and a few improvements that would need to be made before this was published. What do you think the main message of the data is, and how could you make that more clear in the animation? 

![alt_text](https://github.com/deangordon/dataAnimationTutorial/blob/master/popProjections.gif "Population hose")

Thirdly is the racing bar chart, showing GVA in Northern Ireland across different industries over time. There is a lot of data moving quickly in this, so I think it is important to make it clear what you want to highlight. The image below it shows the same information, but highlighting changes to the importance of construction and Wholesale & Retail trade over time. 

![alt text](https://github.com/deangordon/dataAnimationTutorial/blob/master/gva.gif "Gross Value Added")
![alt text](https://github.com/deangordon/dataAnimationTutorial/blob/master/betterTrendComparison.jpg "Static GVA")
