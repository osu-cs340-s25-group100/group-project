# Forever Home

Before running the app:

1. `cd app`
2. `npm install`
3. Make a copy of `app/.env.sample`.
4. Rename the copy to `.env`.
5. Put your database credentials in the `.env` file.

To run in development mode: `npm run development`

To run in production mode: `npm run production`

# Citations
Citations are listed per file, and include file paths

App.js
* The code in this file is adapted from the Node.js example on Canvas.
* Router middleware was used to split the routes into multiple files.
* The port number was moved into an .env to make it configurable.
* Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948

views/ [adoptions.hbs, customers.hbs, pets.hbs, shelters.hbs, species.hbs, vaccinations.hbs, vaccines.hbs ]
* The code in this file is adapted from the Node.js example on Canvas.
* Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948

views/layout/main.hbs
* The code in this file is adapted from the Node.js example on Canvas.
* Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948

routes/ [adoptionRoutes.js, customerRoutes.js, shelterRoutes.js, vaccinationRoutes.js, vaccineRoutes.js]
* The code in this file is adapted from the Node.js example on Canvas.
  * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948
  * However, instead of putting the route handler in app.js, we used router middleware to split the routes into multiple files.
* Citation: Code for CREATE / UPDATE / DELETE route is adapted from Canvas, CS 340 Module 8
  * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

public/style.css
* The CSS in this file is adapted from the Node.js example on Canvas.
* Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948

database/db-connector.js
* The code in this file is adapted from the Node.js example on Canvas.
* The credentials were moved into an .env.
* Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948

Citations regarding SQL: DDL, DML, PL
* Note: Used forward engineering as starting point and modified as needed.
* Citation: CREATE / UPDATE / DELETE / code is adapted from Canvas, CS 340 Module 8
  * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968
* No AI was used.
* IF NULL in Pets Select on line 93 of the DML learned from https://stackoverflow.com/questions/3215454/mysql-ifnull-else/23395407#23395407