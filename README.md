## What The Truck?!

[Visit What The Truck?!](http://what-the-truck.herokuapp.com/)

Made by [Brian Cox](https://github.com/briancox730), [Nicholas Lee](https://github.com/Maimer) and [Chris Saltys](https://github.com/saltys)

## Introduction

What The Truck?! is a food truck review site for trucks in Boston. It is intended to be a user-driven community with food truck ratings and detailed reviews.

Users may view a list of food trucks and information for each truck. Food trucks are presented on the main page in order of their average rating. Users can also visit each food truck page to see a truck’s description, website and any reviews left by other users. Every review can be voted up or down based on how helpful and relevant it is. The site also provides the daily location of each truck on an interactive map, provided the company chooses to disclose this information. Users can optionally register for the site in order to leave and vote on reviews.

What The Truck?! includes a separate namespace for admins to manage content on the site. An admin may delete a truck or review if they wish.

## Tools Used

_Nokogiri_

To pull in the location data for each truck, we used [Nokogiri](https://github.com/sparklemotion/nokogiri) to scrape truck information from the City of Boston website. We then referenced the food truck details against the current database of trucks. Finally, we plotted the location of the truck using the latitude/longitude and Google Maps API.  This data is updated daily through a scheduled rake task.

_CarrierWave/MiniMagick_

To import user and food truck photos we used the [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) gem. [MiniMagick](https://github.com/minimagick/minimagick) was used to process all photos used on the site.

_Devise_

We used the [Devise](https://github.com/plataformatec/devise) gem for user authentication and storing login credentials.

_Premailer_

[Premailer](https://github.com/fphilipe/premailer-rails) allows us to use our application CSS files in the emails sent from our application.

_Simple Form_

We used [Simple Form](https://github.com/plataformatec/simple_form) for all forms on the site.

## Front Page

![Front Page](https://raw.githubusercontent.com/Maimer/what_the_truck/master/readme_images/front.png)

## Sample Truck Page

![Truck Page](https://raw.githubusercontent.com/Maimer/what_the_truck/master/readme_images/truck.png)
