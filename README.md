
# MyGit
A version Control System similar to Git which uses PostgreSQL as the database for storing all the user's data and uses python to access the DB and provide a user interface using the Terminal. <br />
<img src = "/Version_Control_Options.png" height="300" width="350" />
## Contributors:
[Vishwas R](https://github.com/vishwas04)
[Uthpal P](https://github.com/Uthpal-p)
[Sudarshan TR](https://github.com/sudh001)

## Description:
### Files:
[Documentation.pdf](/Documentation.pdf) has the basic documentation to get started with the application and it's various functionalities. Also describes ways in which this application can be migrated to other Databases according to needs.<br />
[Phase1.pdf](/phase1.pdf) describes the evolution of the design of the ER diagram for this appication. <br />
[Phase2.pdf](/phase2.pdf) describes the reasons for choosing RDBMS and sql code for creation and initialization of the database and it's tables according to the Relational Table Diagram. <br />
[Phase3.pdf](/phase3.pdf) describes the complete logic behind how branching, merging, commit, pull, push and all other version control functions work in the application and it's respective code. It also has a list of simple and complex queries with their code which can be implemented along with the current application to enhance it's features.
<br />

### Relational Table implemented in PostgreSQL:
<img src = "/RELATIONAL_TABLE.png" height="300" width="500" />

### Initialization:
1. Install Postgres and run github_init_for_python.sql.


2. Edit mygit.py and change the DB name and password set in Postgres.


3. Run mygit.py in the terminal/CMD.
