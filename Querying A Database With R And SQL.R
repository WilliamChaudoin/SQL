#### Querying A Database With R and SQL

# Changing Working Directory And Installing Or Loading Libraries
setwd('/')
getwd()

#install.packages('RSQLite')
#install.packages('ggplot2')
library('RSQLite')
library(ggplot2)

# Establishing Connection
conn <- dbConnect(SQLite(),"Querying_DatabaseDB.sqlite")

# Creating Tables
df1 <- dbExecute(conn, "CREATE TABLE BOARD (
                            B_ID CHAR(6) NOT NULL, 
                            B_NAME VARCHAR(75) NOT NULL, 
                            TYPE VARCHAR(50) NOT NULL, 
                            LANGUAGE VARCHAR(50), 
                            PRIMARY KEY (B_ID))", 
                errors=FALSE)

df2 <- dbExecute(conn, "CREATE TABLE SCHOOL (
                  B_ID CHAR(6) NOT NULL, 
                  S_ID CHAR(6) NOT NULL, 
                  S_NAME VARCHAR(100), 
                  LEVEL VARCHAR(70), 
                  ENROLLMENT INTEGER WITH DEFAULT 10,
                  PRIMARY KEY (B_ID, S_ID))", errors=FALSE) 

# Loading Data Into Tables
school <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/data/school.csv')
board <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/data/board.csv')

dbWriteTable(conn, "SCHOOL", school, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "BOARD", board, overwrite=TRUE, header = TRUE)
dbListTables(conn)

tables1 = dbListTables(conn)
for (table in tables1){  
        cat ("\nColumn info for table", table, ":\n")
        col.detail <- dbColumnInfo(dbSendQuery(conn,paste( "select * from",table)))
        print(col.detail)
}

# Querying The Tables
dbGetQuery(conn, 'SELECT * FROM BOARD LIMIT 50')
dbGetQuery(conn, 'SELECT * FROM SCHOOL LIMIT 50')

QUERY1 <- paste("SELECT ENROLLMENT 
	FROM SCHOOL s, BOARD b WHERE b.B_NAME = 'Toronto DSB' and b.B_ID=s.B_ID 
	AND s.LEVEL = 'Elementary' ORDER BY ENROLLMENT DESC")
DF1 <- dbGetQuery(conn, QUERY1)
dim(DF1)

QUERY2 <- paste("SELECT s.ENROLLMENT FROM SCHOOL s, BOARD b 
	WHERE b.B_NAME = 'Toronto DSB' and b.B_ID=s.B_ID
	AND s.LEVEL = 'Secondary' ORDER BY ENROLLMENT DESC")
DF2 <- dbGetQuery(conn, QUERY2)

QUERY3 <- paste("SELECT b.B_NAME, s.S_NAME, LEVEL, ENROLLMENT 
	FROM BOARD b, SCHOOL s WHERE b.B_ID = s.B_ID AND b.B_NAME = 'Toronto DSB'")

DF3 <- dbGetQuery(conn, QUERY3)
DF3$LEVEL <- as.factor(DF3$LEVEL)

## Plots
###QUERY1
qplot(ENROLLMENT, data=DF1, geom="density",  main="TDSB School Size - Elementary")

###QUERY2
qplot(ENROLLMENT, data=DF2, geom="density", main="TDSB School Size - Secondary")

###QUERY3
boxplot(ENROLLMENT ~ LEVEL, DF3, names =c("Secondary","Elementary"), main="Toronto DSB")

# Establishing Connection
conn <- dbConnect(SQLite(),"FinalDB_lab4.sqlite")

# Creating Tables
T1 <- dbExecute(conn, 
                    "CREATE TABLE CROP_DATA (
                                      CD_ID INTEGER NOT NULL,
                                      YEAR DATE NOT NULL,
                                      CROP_TYPE VARCHAR(20) NOT NULL,
                                      GEO VARCHAR(20) NOT NULL, 
                                      SEEDED_AREA INTEGER NOT NULL,
                                      HARVESTED_AREA INTEGER NOT NULL,
                                      PRODUCTION INTEGER NOT NULL,
                                      AVG_YIELD INTEGER NOT NULL,
                                      PRIMARY KEY (CD_ID)
                                      )", 
                    errors=FALSE
                    )

    if (T1 == -1){
        cat ("An error has occurred.\n")
        msg <- odbcGetErrMsg(conn)
        print (msg)
    } else {
        cat ("Table was created successfully.\n")
    }

T2 <- dbExecute(conn, "CREATE TABLE DAILY_FX (
                                DFX_ID INTEGER NOT NULL,
                                DATE DATE NOT NULL, 
                                FXUSDCAD FLOAT(6),
                                PRIMARY KEY (DFX_ID)
                                )",
                    errors=FALSE
                    )

    if (T2 == -1){
        cat ("An error has occurred.\n")
        msg <- odbcGetErrMsg(conn)
        print (msg)
    } else {
        cat ("Table was created successfully.\n")
    }

# Loading Data Into Tables
crop <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-RP0203EN-SkillsNetwork/labs/Practice%20Assignment/Annual_Crop_Data.csv', colClasses=c(YEAR="character"))
daily <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-RP0203EN-SkillsNetwork/labs/Practice%20Assignment/Daily_FX.csv', colClasses=c(date="character"))

dbWriteTable(conn, "CROP_DATA", crop, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "DAILY_FX", daily, overwrite=TRUE, header = TRUE)
dbListTables(conn)

# Querying Tables
## Counting Rows
dbGetQuery(conn, 'SELECT COUNT(*) FROM CROP_DATA')
dbGetQuery(conn, 'SELECT COUNT(*) FROM DAILY_FX')

## Distinct Crops
dbGetQuery(conn, 'SELECT DISTINCT(CROP_TYPE) FROM CROP_DATA')

## Rye Crops
dbGetQuery(conn, "SELECT * FROM CROP_DATA WHERE CROP_TYPE='Rye' LIMIT 10")

## Distinct Crops With AVG Yield's Greater Than 3000
dbGetQuery(conn, 'SELECT DISTINCT(CROP_TYPE) FROM CROP_DATA 
	WHERE AVG_YIELD > 3000')

## Length Of The Data
dbGetQuery(conn, 'SELECT MIN(YEAR) FIRST_DATE, MAX(YEAR) LAST_DATE FROM CROP_DATA')
dbGetQuery(conn, 'SELECT MIN(DATE) FIRST_DATE, MAX(DATE) LAST_DATE FROM DAILY_FX')

## Top 10 Years Of Wheat Production In Saskatchewan
dbGetQuery(conn, "SELECT strftime('%Y',YEAR) AS TOP_10_YRS, GEO, HARVESTED_AREA 
    FROM CROP_DATA 
    WHERE CROP_TYPE='Wheat' AND 
          GEO='Saskatchewan'
    ORDER BY HARVESTED_AREA DESC
    LIMIT 10")

## Barley Yield In Canada
dbGetQuery(conn, "SELECT COUNT(DISTINCT(YEAR)) AS BLY_YRS_ABOVE_2MTPH
    FROM CROP_DATA 
    WHERE AVG_YIELD > 2000 AND 
          CROP_TYPE='Barley' AND 
          GEO='Canada' ")

## Barley in Alberta
dbGetQuery(conn, "SELECT strftime('%Y',YEAR) AS YEAR, GEO, CROP_TYPE,
            SEEDED_AREA, HARVESTED_AREA, 
            100*(SEEDED_AREA-HARVESTED_AREA)/SEEDED_AREA AS PCT_UNHARVESTED_AREA
            FROM CROP_DATA WHERE YEAR >= 2000 AND
            GEO = 'Alberta' AND CROP_TYPE = 'Barley'")

##  Average Of The Canadian Dollar Relative To USD
dbGetQuery(conn, "SELECT MIN(DATE) AS AS_OF_DATE, 
            AVG(FXUSDCAD) AS FX_DAILY_AVG_CAD 
    FROM  DAILY_FX
    WHERE DATE >= (SELECT MAX(DATE) - 3 YEARS FROM DAILY_FX)")

## Implicit Join
dbGetQuery(conn, "SELECT CD_ID,YEAR ,CROP_TYPE, GEO, SEEDED_AREA, HARVESTED_AREA, PRODUCTION, AVG_YIELD, FXUSDCAD  
    FROM CROP_DATA, DAILY_FX 
    WHERE strftime('%Y',CROP_DATA.YEAR) = strftime('%Y',DAILY_FX.DATE) and strftime('%m', CROP_DATA.YEAR) = strftime('%m', DAILY_FX.DATE) LIMIT 5")
