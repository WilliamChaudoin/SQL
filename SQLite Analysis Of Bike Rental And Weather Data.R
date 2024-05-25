#### SQLite Analysis Of Bike Rental And Weather Data

# Changing Working Directory And Installing Or Loading Libraries
setwd('/')
getwd()
#install.packages('RSQLite')
library('RSQLite')

# Establishing Connection
conn = dbConnect(SQLite(),"FinalRSQLite.sqlite")

# Creating Tables
T1 = dbExecute(conn, 
                    "CREATE TABLE WORLD (
                        CITY VARCHAR(50) NOT NULL,
                        CITY_ASCII VARCHAR(50) NOT NULL,
                        LAT DECIMAL(20,2) NOT NULL,
                        LNG DECIMAL(20,2) NOT NULL,
                        COUNTRY VARCHAR(50) NOT NULL,
                        ISO2 VARCHAR(5) NOT NULL,
                        ISO3 VARCHAR(5) NOT NULL,
                        ADMIN_NAME VARCHAR(100) NOT NULL,    
                        CAPITAL VARCHAR(50) NOT NULL,
                        POPULATION BIGINT NOT NULL,
                        ID INTEGER NOT NULL
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
T2 = dbExecute(conn, 
                    "CREATE TABLE BIKE (
                    COUNTRY VARCHAR(20) NOT NULL,
                    CITY VARCHAR(87) NOT NULL,
                    SYSTEM VARCHAR(40) NOT NULL,
                    BICYCLES NUMERIC NOT NULL
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
T3 = dbExecute(conn, "CREATE TABLE CITIES (
                        CITY VARCHAR(16) NOT NULL,
                        WEATHER VARCHAR(6) NOT NULL,
                        VISIBILITY SMALLINT NOT NULL,
                        TEMP DECIMAL(6,2) NOT NULL,
                        TEMP_MIN DECIMAL(6,2) NOT NULL,
                        TEMP_MAX DECIMAL(6,2) NOT NULL,
                        PRESSURE SMALLINT NOT NULL,
                        HUMIDITY SMALLINT NOT NULL,
                        WIND_SPEED DECIMAL(6,2) NOT NULL,
                        WIND_DEG SMALLINT NOT NULL,
                        SEASON VARCHAR(6) NOT NULL,
                        FORECAST_DATETIME TIMESTAMP
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
T4 = dbExecute(conn, "CREATE TABLE SEOUL (
                        DATE VARCHAR(30),
                        RENTED_BIKE_COUNT SMALLINT,
                        HOUR SMALLINT,
                        TEMPERATURE DECIMAL(4,1),
                        HUMIDITY SMALLINT,
                        WIND_SPEED DECIMAL(3,1),
                        VISIBILITY SMALLINT,
                        DEW_POINT_TEMPERATURE DECIMAL(4,1),
                        SOLAR_RADIATION DECIMAL(5,2),
                        RAINFALL DECIMAL(3,1),
                        SNOWFALL DECIMAL(3,1),
                        SEASONS VARCHAR(10),
                        HOLIDAY VARCHAR(20),
                        FUNCTIONING_DAY VARCHAR(5)
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
world = read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/world_cities.csv')
bike = read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/bike_sharing_systems.csv')
cities = read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/cities_weather_forecast.csv')
seoul = read.csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/seoul_bike_sharing.csv')

dbWriteTable(conn, "WORLD", world, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "BIKE", bike, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "CITIES", cities, overwrite=TRUE, header = TRUE)
dbWriteTable(conn, "SEOUL", seoul, overwrite=TRUE, header = TRUE)
dbListTables(conn)

# Total Records
dbGetQuery(conn, 'SELECT COUNT(*) FROM SEOUL')

# Number Of Rents Above Zero Hours
dbGetQuery(conn, 'SELECT COUNT(HOUR) AS TOTAL FROM SEOUL WHERE RENTED_BIKE_COUNT > 0')

# Seoul Forecast
dbGetQuery(conn, 'SELECT * FROM CITIES WHERE CITY = "Seoul" LIMIT 3')

# Seasons In Dataset
dbGetQuery(conn, 'SELECT DISTINCT(SEASONS) FROM SEOUL')

# Beginning And End Of Dataset
dbGetQuery(conn, 'SELECT min(DATE) FIRST_DATE, max(DATE) LAST_DATE FROM SEOUL')

# Time Of Most Bike Rentals
dbGetQuery(conn, 'SELECT DATE, HOUR, RENTED_BIKE_COUNT FROM SEOUL WHERE RENTED_BIKE_COUNT = 
    (SELECT MAX(RENTED_BIKE_COUNT) FROM SEOUL)')

# Average Temperature and Bike Rental By Season and Hour
dbGetQuery(conn, 'SELECT SEASONS, HOUR, AVG(RENTED_BIKE_COUNT), AVG(TEMPERATURE) FROM SEOUL GROUP BY SEASONS, HOUR ORDER BY AVG(RENTED_BIKE_COUNT) DESC LIMIT 10')

# Min, Max, and SD Hourly Bike Count
dbGetQuery(conn, 'SELECT SEASONS, AVG(RENTED_BIKE_COUNT) as AVG_COUNT, MIN(RENTED_BIKE_COUNT) as MIN_COUNT, MAX(RENTED_BIKE_COUNT) as MAX_COUNT 
    , SQRT(RENTED_BIKE_COUNT) FROM SEOUL GROUP BY SEASONS ORDER BY AVG_COUNT DESC')

# AVG By Season
dbGetQuery(conn, 'SELECT AVG(TEMPERATURE), AVG(HUMIDITY), AVG(WIND_SPEED), AVG(VISIBILITY), 
AVG(DEW_POINT_TEMPERATURE), AVG(SOLAR_RADIATION), AVG(RAINFALL), AVG(SNOWFALL), AVG(RENTED_BIKE_COUNT) AS AVG_BIKE
FROM SEOUL GROUP BY SEASONS ORDER BY AVG_BIKE DESC')

# Implicit Join
dbGetQuery(conn, "SELECT B.BICYCLES, B.CITY, B.COUNTRY, W.LAT, W.LNG, W.POPULATION  FROM BIKE B, WORLD W 
WHERE B.CITY = W.CITY_ASCII AND B.CITY = 'Seoul'")

# Between 15000 and 20000
dbGetQuery(conn, 'SELECT B.BICYCLES, B.CITY, B.COUNTRY, W.LAT, W.LNG, W.POPULATION FROM BIKE B, WORLD W 
WHERE B.CITY = W.CITY_ASCII AND B.BICYCLES BETWEEN 15000 AND 20000 ORDER BY B.BICYCLES DESC')


























