#### Connecting To A Database Using RJDBC and RSQLITE

# Change Working Directory Location And Installing or Loading Libraries
setwd('/Directory')
getwd()

#install.packages('DBI')
#install.packages('rJava')
#install.packages('RJDBC')
#install.packages('curl')
#install.packages('RSQLite')
library(DBI)
library(rJava)
library(RJDBC)
library(curl)
library('RSQLite')

# RJDBC
curl_download("https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DB0201EN-SkillsNetwork/labs/Labs_Coursera_V5/datasets/Instructors.db","Instructors.db")
curl_download("https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/jars/sqlite-jdbc-3.27.2.1.jar","sqlite-jdbc-3.27.2.1.jar")

## Example 1
dsn_driver = "org.sqlite.JDBC"
jcc = JDBC(dsn_driver, "sqlite-jdbc-3.27.2.1.jar");
jdbc_path = paste("jdbc:sqlite:Instructors.db");
conn =  dbConnect(jcc, jdbc_path)
query = "SELECT * FROM sqlite_master"
rs = dbSendQuery(conn, query);
df = fetch(rs, -1);
head(df)

## Disconnecting
dbDisconnect(conn)

## Example 2
dsn_driver = "org.sqlite.JDBC"
jcc = JDBC(dsn_driver, "sqlite-jdbc-3.27.2.1.jar");
jdbc_path = paste("jdbc:sqlite:Instructors.db");
conn = dbConnect(jcc, jdbc_path)
query = "SELECT * FROM Instructor"
rs = dbSendQuery(conn, query);
df = fetch(rs, 3);
head(df)

## Disconnecting
dbDisconnect(conn)

# SQLLite
## Example 1
(con <- dbConnect(SQLite(),"TestDB.sqlite"))
attributes(con)
(con.info <- dbGetInfo(con))
sapply(quakes, dbDataType, dbObj = SQLite())
dbWriteTable(con, "mtcars", mtcars)
dbListTables(con)

tables1 = dbListTables(con)
for (table in tables1){  
        cat ("\nColumn info for table", table, ":\n")
        col.detail <- dbColumnInfo(dbSendQuery(con,paste( "select * from",table)))
        print(col.detail)
}

## Disconnecting
dbDisconnect(con)

## Example 2
(con <- dbConnect(SQLite(),"MyDB.sqlite"))
attributes(con)
(con.info <- dbGetInfo(con))
sapply(quakes, dbDataType, dbObj = SQLite())

dbWriteTable(con, "MyData", iris)
dbListTables(con)

tables1 = dbListTables(con)
for (table in tables1){  
        cat ("\nColumn info for table", table, ":\n")
        col.detail <- dbColumnInfo(dbSendQuery(con,paste( "select * from",table)))
        print(col.detail)
}

## Disconnecting
dbDisconnect(con)
