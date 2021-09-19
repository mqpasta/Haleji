#!/bin/bash

#sleep 20s

 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "King.1234" -d master -i DBCreation.sql
 sleep 1s
 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "King.1234" -d Haleji -i InsertTransType.sql
 sleep 1s
 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "King.1234" -d Haleji -i combine_sps.sql
