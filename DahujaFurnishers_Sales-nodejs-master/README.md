![App picture](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/main_picture.jpg)

# Description :point_left:
It's a web application for managing hospitals customItems and determining the order's priority for isolation. The app provides a centralised hub for managing the orders and planning their distribution across order’s customItems. 

It allows nurses to keep track of the orders and their items in real time and to have an overview over the orders and customItems, and better manage the customItems assignment across orders.

# Live demo :rocket:
https://nhs-app.herokuapp.com/
* username: admin
* password: admin

# Youtube video
<a href="http://www.youtube.com/watch?feature=player_embedded&v=Q9wTakyRWi4
" target="_blank"><img src="http://img.youtube.com/vi/Q9wTakyRWi4/0.jpg" 
alt="Youtube video" width="240" height="180" border="10" /></a>

# Prerequisites
- [x] Node.js 6.9.1 or later - install from https://nodejs.org/

# Installing - easy :electric_plug:
1.	Download the repository
```
git clone https://github.com/margiki/NHS-nodejs-webapp
```
2.	Open the Terminal (Linux & MacOS) or PowerShell (Windows) and change directory to the project folder.
3.	Type ‘npm install’ in the Terminal (PowerShell) and press Enter. All the dependencies would be installed.
4.	Go back to the Terminal (PowerShell) and be sure that you are pointing inside the project folder. To open the application, type ‘node app.js’ and press Enter.
5.	The application should be live on the local port 3000.  
6.	Type http://localhost:3000/ into a browser.
7.	To login use the username: admin  and the password: admin
8.	Now you should be inside the application

# How to use it :book:
### Dashboard

Data about orders and customItems is available here. The page is split into three tables. 

![Dashboard](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/dashboard.jpg)

![Dashboard](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/dasboard_2.jpg)

To clear the red warning sign you need to go on the order’s personal page. To do that, you have to double click on his name. By clicking on the ‘Update button’ on the bottom of the page, the order’s diagnosis in updated for the next 24 hours (consequently, the red warning sign disappears).

### Add order page

You can add a new order in the system with his personal details and his items. The application automatically computes the items of the order based on the entered items

![Add order page](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/add_new_order.jpg)

### Order page

Double click on a order name on the dashboard to get here.
![Order page](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/order_page.jpg)

### System settings

The control center of the application. It allows users to manage the items & customItems of the Order and create new accounts

![System Settings](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/system_settings.jpg)

# App Modules and Code organisation
### Modules

Module|Core	|orders|items|customItems 
------|-----|--------|--------|----
Functionality	|- login system | - add / delete orders | - add / delete items | 	- assign customItems to orders
.|- add users | - update order's diagnosis | - assign item to orders | - add / remove customItems
.|- view dashboard	| - view order’s page | 
.|.| - retrieve order's information	

### Code organisation :open_file_folder:

Folder | Content | Responsability
------|-----|--------
/public	| |	Contains the public files, such as CSS, fonts and scripts.
/routes	| |	Manage the HTTP requests. Is divided into smaller modules responsible for disjoint tasks.
.	|/app.js| 	Renders dashboard page
.	|/item.js| 	Responsible for items
.	|/login.js|	Responsible for logging in
.	|/orders.js|	Responsible for orders
.	|/customItems.js|	Responsible for customItems
.	|/settings.js|	Renders settings page
.	|/users.js|	Add new users and logout
/server	| |	Defines the database and Schemas
.	|/db/mongoose.js| 	Database settings
.	|/models| 	Defines Schemas
/views		| |Render pages
.	|/layouts|	The core layout; each page is rendered inside the layout
.	|/(other files)|	Contains specific visual changes for every page

# Technologies

### Backend
![Nodejs - ExpressJS](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/backend.jpg)

### Frontend
![jQuery](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/frontend.jpg)

### Database
![MongoDB - Mongoose](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/database.jpg)

### Databse Schema
![Database schema](https://github.com/margiki/NHS-nodejs-webapp/blob/master/github_readme_photos/database_design.jpg)

**The available application is connected to a MongoDB database online.** If you want to change the database to another one, you need to go: NHS app folder -> server -> db -> mongoose.js

Inside the file, you need to change the database link from
mongoose.connect("mongodb://admin:admin123@ds145220.mlab.com:45220/nhs-app"); to mongoose.connect("your-database-link");

# REST Apis
The backend and frontend communicate through REST Apis. On the frontend, we make Ajax requests using jQuery to the following routes: 

URI |	Returns
----|----
/app/getitems |	returns information about all items in the system
/app/getorders |       	returns information about all orders in the system
/app/getorder/:orderId |	returns information about a specific order
/app/getcustomItems	| returns information about the customItems in the system

# Known bugs :bug:
1. On some mobiles devices (iPhone, iPad) assigning customItems to orders is not working because mobile browsers doesn’t interpret the double-click. Also, the user can’t enter the order's page because of the same reason. However, on LG mobile devices this feature works. 

# License 
Free to use, copy and distribute. :money_with_wings:






