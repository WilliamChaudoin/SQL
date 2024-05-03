#### Canadian Agriculture SQL Analysis In R Using RSQLITE

# Changing Working Directory And Installing Or Loading Libraries
setwd('/')
getwd()
#install.packages('RSQLite')
library('RSQLite')

# Establishing Connection
conn <- dbConnect(SQLite(),"FinalDB.sqlite")

# Creating Tables
T1 <- dbExecute(conn, 
                    "CREATE TABLE CROP (
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

T2 <- dbExecute(conn, 
                    "CREATE TABLE FARM (
                                      CD_ID INTEGER NOT NULL,
                                      DATE DATE NOT NULL,
                                      CROP_TYPE VARCHAR(20) NOT NULL,
                                      GEO VARCHAR(20) NOT NULL, 
                                      PRICE_PERMIT INTEGER NOT NULL,
                                      PRIMARY KEY (CD_ID)
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
T3 <- dbExecute(conn, "CREATE TABLE DAILY (
                                DFX_ID INTEGER NOT NULL,
                                DATE DATE NOT NULL, 
                                FXUSDCAD FLOAT(6),
                                PRIMARY KEY (DFX_ID)
                                )",
                    errors=FALSE
                    )

    if (T3 == -1){
        cat ("An error has occurred.\n")
        msg <- odbcGetErrMsg(conn)
        print (msg)
    } else {
        cat ("Table was created successfully.\n")
    }
T4 <- dbExecute(conn, "CREATE TABLE MONTHLY (
                                DFX_ID INTEGER NOT NULL,
                                DATE DATE NOT NULL, 
                                FXUSDCAD FLOAT(6),
                                PRIMARY KEY (DFX_ID)
                                )",
                    errors=FALSE
                    )

    if (T4 == -1){
        cat ("An error has occurred.\n")
        msg <- odbcGetErrMsg(conn)
        print (msg)
    } else {
        cat ("Table was created successfully.\n")
    }

# Loading Data Into Tables
crop <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-RP0203EN-SkillsNetwork/labs/Final%20Project/Annual_Crop_Data.csv', colClasses=c(YEAR="character"))
farm <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-RP0203EN-SkillsNetwork/labs/Final%20Project/Monthly_Farm_Prices.csv', colClasses=c(date="character"))
daily <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-RP0203EN-SkillsNetwork/labs/Final%20Project/Daily_FX.csv', colClasses=c(YEAR="character"))
monthly <- read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-RP0203EN-SkillsNetwork/labs/Final%20Project/Monthly_FX.csv', colClasses=c(date="character"))

dbWriteTable(conn, "CROP", crop, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "FARM", farm, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "DAILY", daily, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "MONTHLY", monthly, overwrite=TRUE, header = TRUE)
dbListTables(conn)

# Querying Tables
## Counting Rows
dbGetQuery(conn, 'SELECT COUNT(*) AS TOTAL FROM FARM')

## Distinct Locations
dbGetQuery(conn, 'SELECT DISTINCT(GEO) FROM FARM')

## Number Of Hectares Of Rye Harvested In 1968 Canada
dbGetQuery(conn, 'SELECT SUM(HARVESTED_AREA) FROM CROP WHERE YEAR = "1968-12-31" AND GEO = "Canada" AND CROP_TYPE = "Rye"')

## First 6 Rows Of Rye In The Farm Table
dbGetQuery(conn, 'SELECT * FROM FARM WHERE CROP_TYPE = "Rye" LIMIT 6')

## Pronvinces That Grew Barley
dbGetQuery(conn, 'SELECT DISTINCT(GEO) FROM CROP WHERE CROP_TYPE = "Barley"')

## Length Of The Data In Farm Table
dbGetQuery(conn, 'SELECT min(DATE) FIRST_DATE, max(DATE) LAST_DATE FROM FARM')

## Crops That Reached A Price Greater Than Or Equal To $350
dbGetQuery(conn, 'SELECT DISTINCT(CROP_TYPE) FROM FARM WHERE PRICE_PRERMT >= 350')

## Average Crop Yield Harvested In Saskatchewan In 2000
dbGetQuery(conn, 'SELECT CROP_TYPE, AVG_YIELD FROM CROP WHERE YEAR = "2000-12-31" AND GEO = "Saskatchewan" ORDER BY AVG_YIELD DESC')

## Average Crop Yield By Province Since 2000
dbGetQuery(conn, 'SELECT CROP_TYPE, GEO, AVG_YIELD
                    FROM CROP 
                    WHERE YEAR > "2000-12-31" 
                    ORDER BY AVG_YIELD DESC')

## Subquery To Determine Most Recent Wheat Harvest In Canada
dbGetQuery(conn, 'SELECT * FROM CROP 
                WHERE GEO = "Canada" AND CROP_TYPE = "Wheat"
            AND YEAR = (SELECT MAX(YEAR) FROM CROP)')

## Implicit Join To Calculate Monthly Price Of Canola Grown In Saskatchewan In CAD and USD
dbGetQuery(conn, 'SELECT A.DATE, A.CROP_TYPE, A.GEO, A.PRICE_PRERMT AS CAD, 
(A.PRICE_PRERMT / B.FXUSDCAD) AS USD, B.FXUSDCAD FROM FARM A, MONTHLY B WHERE A.DATE = B.DATE 
AND GEO = "Saskatchewan" AND CROP_TYPE = "Canola" ORDER BY A.DATE DESC LIMIT 6')

