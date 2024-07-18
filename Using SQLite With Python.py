# Using SQLite With Python

# Importing Libraries
import sqlite3 as sq3
import pandas.io.sql as pds
import pandas as pd

# Initialize Path To SQLite Database
path = 'classic_rock.db'
con = sq3.Connection(path)

# Checking Connection
con

# Setting Up Query
query = ''' SELECT * FROM rock_songs; '''

# Executing Query
data = pds.read_sql(query, con)
print(data.head())

# Alternative Queries
query2 = ''' SELECT Artist, Release_Year, COUNT(*) AS num_songs, AVG(PlayCount) AS avg_plays  
    FROM rock_songs
    GROUP BY Artist, Release_Year
    ORDER BY num_songs DESC; '''

# Execute the query
data2 = pds.read_sql(query2, con)
print(data2.head())

# Initialize Path To New SQLite Database
path2 = 'baseball.db'
con2 = sq3.Connection(path2)

# Checking Connection
con2

# Setting Up Query
query3 = ''' SELECT * FROM allstarfull; '''

# Executing Query
data3 = pds.read_sql(query3, con2)
print(data3.head())

# Alternative Query 1
alt1 = pd.read_sql('SELECT * FROM sqlite_master', con2)
print(alt1)

# Alternative Query 2
query4 = """ SELECT playerID, sum(GP) AS num_games_played, AVG(startingPos) AS avg_starting_position
    FROM allstarfull
    GROUP BY playerID
    ORDER BY num_games_played DESC, avg_starting_position ASC
    LIMIT 3 """
alt2 = pd.read_sql(query4, con2)
print(alt2.head())


