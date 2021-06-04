# California Traffic Collision Data from SWITRS

<p align="center"> 
    <img src="https://i.ibb.co/wQQf9rG/tram-auto-crash-in-1957-frederiksplein-amsterdam.jpg" alt="SWITRS">
 </p>


This data comes from the California Highway Patrol and covers collisions from January 1st, 2001 until mid-October, 2020. [Alex Gude](https://alexgude.com/) has requested full database dumps from the CHP four times, once in 2016, 2017, 2018, and 2020. He has combined these datasets into the one presented here. For additional details, see Alex Gude's post: [Introducing the SWITRS SQLite Hosted Dataset](https://alexgude.com/blog/switrs-sqlite-hosted-dataset/)


There are three main tables:

* `collisions`: Contains information about the collision, where it happened, what vehicles were involved.
* `parties`: Contains information about the groups people involved in the collision including age, sex, and sobriety.
* `victims`: Contains information about the injuries of specific people involved in the collision.
There is also a table called case_ids which I used to build the other tables. It tells you which of the four original datasets each row came from.

There is a data dictionary [here](https://tims.berkeley.edu/help/SWITRS.php): He has in some cases remapped values so that they are human readable (making a left turn instead of D for example); you can find those mappings [here](https://github.com/agude/SWITRS-to-SQLite/blob/master/switrs_to_sqlite/value_maps.py).

<br>
<br>



### Creators:
* Mehrzad Jafari Ranjbar
* Giovanni Giunta


## Goal of the project: 
    > 1. Convert the `.sqlite` file to MySQL and perform the normal queries, along with the optimized ones.
    > 2. Export the `.json` file from MySQL Workbench and load it MongoDB and perform queries on them.


## Main Steps:
    > 1. Data conversion to MySQL
    > 2. Writing MySQL queries
    > 3. Data conversion to MongoDB
    > 4. Preprocessing using Python
    > 5. Writing MongoDB queries


## The repository consists of the following files:

### `MySQL`: 
    > 1. `Read This Before.pdf` file in which you will find all the preprocessing steps required for performing the MySQL queries.
    > 2. `MySQL Common Queries` folder containing 9 `.sql` query files with commonly used queries and their respected questions.
    > 3. `MySQL Optimized Queries` folder containing 7 `.sql` query files with commonly used queries and their respected questions.

### `MongoDB`: 
    > 1.`Read This Before.pdf` file in which you will find all the preprocessing steps required for performing the MongoDB queries.
    > 2. `MySQL Exporting.sql` file in which you will find the way to combine the data and extract it.
    > 3. `Python Preprocessing.ipynb` file in which you will find the final preprocessing phase in Python in order to create the last `.json` file.
    > 4. `MonoDB Scripts.mongodb` file containing 10 queries and their respected explanations.
