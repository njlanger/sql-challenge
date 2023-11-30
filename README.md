The SQL code for this assignment was written from what I learned in class. ChatGPT was used for debugging. 

Data Cleaning:
Six csv files were given to complete the assignment. Duplicate ‘emp_no’ values were found in the dept_emp table. This makes sense as employees could have worked in multiple departments throughout their tenure. The duplicates needed to be removed for analysis as there was no way to determine the last department the employee worked. 63,159 duplicate values were removed, which accounted for approximately 20% of the overall data.
A column header in the ‘titles’ table was changed from “title_id” to “emp_title_id” to coincide with the column header in another table. No data was affected by this change. 

Enterprise Relationship Diagram:
The enterprise relationship diagram (EDR) was developed using the below website:
https://app.quickdatabasediagrams.com/
Once the ERD is constructed the tool allows one to export to the appropriate SQL application. This is how the tables were created in PostgreSQL.

SQL application:
PostreSQL was the application used. Once the table structure was defined in the PostreSQL database, the tool allows files to be imported for adding data to the tables. Once the tables had data loaded, I combined all six tables into one ‘combined_table’, this allowed for a faster analysis process.

The EDR and SQL code are provided. The raw files are in the ‘Resources’ folder for reference. 
  


