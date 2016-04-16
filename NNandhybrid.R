###
###     IRDM GROUP PROJECT
###

library("sqldf", lib.loc="~/R/win-library/3.2")
library(RH2)
library(rJava)
library(RJDBC)

#read all load data
load = read.csv("C:/Users/hp-pc/Documents/IRDM/Load_history.csv")

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 1")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

##
## read temperature data for 11 stations
## 

##cache temperature data for 11 stations
master_temp = NULL

#read all temperature data
temper = read.csv("C:/Users/hp-pc/Documents/IRDM/temperature_history.csv")

#get temperature for staton 1
temper_z1 = sqldf("select * from temper where station_id = 1")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station1

load_temp = sqldf("select l.*,t.temper from
                  load_z1_hourly l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper1'
master_temp$temper1 = load_temp$temper1

####################################################################
#### add temperature for station 2
#get temperature for staton 2
temper_z1 = sqldf("select * from temper where station_id = 2")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station2

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper2'
master_temp$temper2 = load_temp$temper2

####################################################################
#### add temperature for station 3
#get temperature for staton 3
temper_z1 = sqldf("select * from temper where station_id = 3")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station3

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper3'
master_temp$temper3 = load_temp$temper3

####################################################################
#### add temperature for station 4
#get temperature for staton 4
temper_z1 = sqldf("select * from temper where station_id = 4")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station4

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper4'
master_temp$temper4 = load_temp$temper4

####################################################################
#### add temperature for station 5
#get temperature for staton 5
temper_z1 = sqldf("select * from temper where station_id = 5")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station5

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper5'
master_temp$temper5 = load_temp$temper5

####################################################################
#### add temperature for station 6
#get temperature for staton 6
temper_z1 = sqldf("select * from temper where station_id = 6")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station6

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper6'
master_temp$temper6 = load_temp$temper6

####################################################################
#### add temperature for station 7
#get temperature for staton 7
temper_z1 = sqldf("select * from temper where station_id = 7")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station7

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper7'
master_temp$temper7 = load_temp$temper7

####################################################################
#### add temperature for station 8
#get temperature for staton 8
temper_z1 = sqldf("select * from temper where station_id = 8")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station8

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper8'
master_temp$temper8 = load_temp$temper8

####################################################################
#### add temperature for station 9
#get temperature for staton 9
temper_z1 = sqldf("select * from temper where station_id = 9")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station9

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper9'
master_temp$temper9 = load_temp$temper9

####################################################################
#### add temperature for station 10
#get temperature for staton 10
temper_z1 = sqldf("select * from temper where station_id = 10")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station10

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper10'
master_temp$temper10 = load_temp$temper10

####################################################################
#### add temperature for station 11
#get temperature for staton 11
temper_z1 = sqldf("select * from temper where station_id = 11")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

## join to get load for zone and temp for station11

load_temp = sqldf("select l.*,t.temper from
                  load_temp l 
                  left join temper_z1_hourly t on 
                  l.year = t.year and
                  l.month = t.month and
                  l.day = t.day and
                  l.hour = t.hour")

names(load_temp)[names(load_temp) == 'temper'] = 'temper11'
master_temp$temper11 = load_temp$temper11

all_temp = NULL
x=as.data.frame(master_temp[1])
all_temp = data.table(x)
names(all_temp) = c("temper1")
x=as.data.frame(master_temp[2])
all_temp$temper2 = data.table(x)
x=as.data.frame(master_temp[3])
all_temp$temper3 = data.table(x)
x=as.data.frame(master_temp[4])
all_temp$temper4 = data.table(x)
x=as.data.frame(master_temp[5])
all_temp$temper5 = data.table(x)
x=as.data.frame(master_temp[6])
all_temp$temper6 = data.table(x)
x=as.data.frame(master_temp[7])
all_temp$temper7 = data.table(x)
x=as.data.frame(master_temp[8])
all_temp$temper8 = data.table(x)
x=as.data.frame(master_temp[9])
all_temp$temper9 = data.table(x)
x=as.data.frame(master_temp[10])
all_temp$temper10 = data.table(x)
x=as.data.frame(master_temp[11])
all_temp$temper11= data.table(x)


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 1 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone


################################################################################
## get temperature for prediction across 11 station for missing week
#################################################################################

#get temperature for staton 1
temper_z1 = sqldf("select * from temper where station_id = 1")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp = NULL
x=as.data.frame(nn_temp1)
test_temp = data.table(x)
names(test_temp) = c("temper1")

#################################################################################

#get temperature for staton 2
temper_z1 = sqldf("select * from temper where station_id = 2")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper2 = as.data.frame(nn_temp1)

#################################################################################

#get temperature for staton 3
temper_z1 = sqldf("select * from temper where station_id = 3")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper3 = as.data.frame(nn_temp1)

#################################################################################

#get temperature for staton 4
temper_z1 = sqldf("select * from temper where station_id = 4")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper4 = as.data.frame(nn_temp1)

#################################################################################

#get temperature for staton 5
temper_z1 = sqldf("select * from temper where station_id = 5")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper5 = as.data.frame(nn_temp1)

#################################################################################

#get temperature for staton 6
temper_z1 = sqldf("select * from temper where station_id = 6")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper6 = as.data.frame(nn_temp1)

#################################################################################

#get temperature for staton 7
temper_z1 = sqldf("select * from temper where station_id = 7")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper7 = as.data.frame(nn_temp1)


#################################################################################

#get temperature for staton 8
temper_z1 = sqldf("select * from temper where station_id = 8")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper8 = as.data.frame(nn_temp1)


#################################################################################

#get temperature for staton 9
temper_z1 = sqldf("select * from temper where station_id = 9")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper9 = as.data.frame(nn_temp1)


#################################################################################

#get temperature for staton 10
temper_z1 = sqldf("select * from temper where station_id = 10")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper10 = as.data.frame(nn_temp1)

#################################################################################

#get temperature for staton 11
temper_z1 = sqldf("select * from temper where station_id = 11")

#define data frame for hourly load
temper_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(temper_z1))
{
  cursor = temper_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    temper_z1_hourly = rbind(temper_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
temper_z1_hourly = data.table(temper_z1_hourly)
col_headings <- c('station_id','year','month','day','hour','cum_hour','temper')
colnames(temper_z1_hourly) <- col_headings

nn_temp1 = sqldf("select temper from temper_z1_hourly where 
                 cum_hour > (select cum_hour from load_temp l
                 where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")


nn_temp1 = nn_temp1$temper[1:nrow(val_z1_hourly)]
test_temp$temper11 = as.data.frame(nn_temp1)


## temperatures for predicting have been cached in test_temp
##########################################################################################
##
##      VAR for zone 1
##
#######################################################3
library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
#round(log2(length(load_temp$load)))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_1 = NULL
final_1 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])

################################################
#neural netwrok prediction
################################################

library(caret)
fit  <- avNNet(load ~ temper1+temper2+temper3+temper4
               +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
               data=req_cum_hour, repeats=25, size=3, decay=0.1,
               linout=TRUE)

res = predict(fit, test_temp, type = "raw")

mape = data.table(res,val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_1$nn = res

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")


fit  <- avNNet(load ~ temper1+temper2+temper3+temper4
               +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
               data=test, repeats=25, size=3, decay=0.1,
               linout=TRUE)

res = predict(fit, test_temp, type = "raw")

mape = data.table(res,val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_1$hyb = res
col_headings <- c('actual','var','nn','hyb')
colnames(final_1) <- col_headings

final_mape = data.frame(res_var,res_nn,res_hyb)


##########################################################################################
##
##      ZONE 2 
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 2")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 2 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_2 = NULL                                                               ###
final_2 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_2  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
               +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
               data=req_cum_hour, repeats=25, size=3, decay=0.1,
               linout=TRUE)

res_2 = predict(fit_2, test_temp, type = "raw")                                  ###2

mape = data.table(res_2,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_2$nn = res_2                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

                                                                                                ###
fin_2  <- avNNet(load ~ temper1+temper2+temper3+temper4
               +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
               data=test, repeats=25, size=3, decay=0.1,
               linout=TRUE)

ren_2 = predict(fin_2, test_temp, type = "raw")                                                ###2

mape = data.table(ren_2,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_2$hyb = ren_2                                                                   ###
col_headings <- c('actual','var','nn','hyb')
colnames(final_2) <- col_headings

final_mape[2,] = data.frame(res_var,res_nn,res_hyb)



##########################################################################################
##
##      ZONE 3
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 3")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 3 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_3 = NULL                                                               ###
final_3 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_3  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_3 = predict(fit_3, test_temp, type = "raw")                                  ###2

mape = data.table(res_3,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_3$nn = res_3                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_3  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_3 = predict(fin_3, test_temp, type = "raw")                                                ###2

mape = data.table(ren_3,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_3$hyb = ren_3                                                                   ###
col_headings <- c('actual','var','nn','hyb')
colnames(final_3) <- col_headings                                                     ###

final_mape[3,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 4
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 4")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 4 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_4 = NULL                                                               ###
final_4 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_4  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_4 = predict(fit_4, test_temp, type = "raw")                                  ###2

mape = data.table(res_4,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_4$nn = res_4                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_4  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_4 = predict(fin_4, test_temp, type = "raw")                                                ###2

mape = data.table(ren_4,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_4$hyb = ren_4                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_4) <- col_headings                                                     ###

final_mape[4,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 5
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 5")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 5 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_5 = NULL                                                               ###
final_5 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_5  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_5 = predict(fit_5, test_temp, type = "raw")                                  ###2

mape = data.table(res_5,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_5$nn = res_5                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_5  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_5 = predict(fin_5, test_temp, type = "raw")                                                ###2

mape = data.table(ren_5,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_5$hyb = ren_5                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_5) <- col_headings                                                     ###

final_mape[5,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 6
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 6")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 6 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_6 = NULL                                                               ###
final_6 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_6  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_6 = predict(fit_6, test_temp, type = "raw")                                  ###2

mape = data.table(res_6,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_6$nn = res_6                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_6  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_6 = predict(fin_6, test_temp, type = "raw")                                                ###2

mape = data.table(ren_6,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_6$hyb = ren_6                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_6) <- col_headings                                                     ###

final_mape[6,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 7
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 7")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 7 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_7 = NULL                                                               ###
final_7 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_7  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_7 = predict(fit_7, test_temp, type = "raw")                                  ###2

mape = data.table(res_7,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_7$nn = res_7                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_7  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_7 = predict(fin_7, test_temp, type = "raw")                                                ###2

mape = data.table(ren_7,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_7$hyb = ren_7                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_7) <- col_headings                                                     ###

final_mape[7,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 8
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 8")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 8 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_8 = NULL                                                               ###
final_8 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_8  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_8 = predict(fit_8, test_temp, type = "raw")                                  ###2

mape = data.table(res_8,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_8$nn = res_8                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_8  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_8 = predict(fin_8, test_temp, type = "raw")                                                ###2

mape = data.table(ren_8,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_8$hyb = ren_8                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_8) <- col_headings                                                     ###

final_mape[8,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 9
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 9")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 9 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_9 = NULL                                                               ###
final_9 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_9  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_9 = predict(fit_9, test_temp, type = "raw")                                  ###2

mape = data.table(res_9,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_9$nn = res_9                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_9  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_9 = predict(fin_9, test_temp, type = "raw")                                                ###2

mape = data.table(ren_9,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_9$hyb = ren_9                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_9) <- col_headings                                                     ###

final_mape[9,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 10
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 10")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 10 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_10 = NULL                                                               ###
final_10 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_10  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=req_cum_hour, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

res_10 = predict(fit_10, test_temp, type = "raw")                                  ###2

mape = data.table(res_10,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_10$nn = res_10                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_10  <- avNNet(load ~ temper1+temper2+temper3+temper4
                 +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                 data=test, repeats=25, size=3, decay=0.1,
                 linout=TRUE)

ren_10 = predict(fin_10, test_temp, type = "raw")                                                ###2

mape = data.table(ren_10,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_10$hyb = ren_10                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_10) <- col_headings                                                     ###

final_mape[10,] = data.frame(res_var,res_nn,res_hyb)                                ###



##########################################################################################
##
##      ZONE 11
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 11")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 11 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_11 = NULL                                                               ###
final_11 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_11  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_11 = predict(fit_11, test_temp, type = "raw")                                  ###2

mape = data.table(res_11,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_11$nn = res_11                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_11  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_11 = predict(fin_11, test_temp, type = "raw")                                                ###2

mape = data.table(ren_11,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_11$hyb = ren_11                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_11) <- col_headings                                                     ###

final_mape[11,] = data.frame(res_var,res_nn,res_hyb)                                ###

##########################################################################################
##
##      ZONE 12
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 12")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 12 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_12 = NULL                                                               ###
final_12 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_12  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_12 = predict(fit_12, test_temp, type = "raw")                                  ###2

mape = data.table(res_12,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_12$nn = res_12                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_12  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_12 = predict(fin_12, test_temp, type = "raw")                                                ###2

mape = data.table(ren_12,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_12$hyb = ren_12                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_12) <- col_headings                                                     ###

final_mape[12,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 13
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 13")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 13 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_13 = NULL                                                               ###
final_13 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_13  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_13 = predict(fit_13, test_temp, type = "raw")                                  ###2

mape = data.table(res_13,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_13$nn = res_13                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_13  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_13 = predict(fin_13, test_temp, type = "raw")                                                ###2

mape = data.table(ren_13,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_13$hyb = ren_13                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_13) <- col_headings                                                     ###

final_mape[13,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 14
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 14")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 14 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_14 = NULL                                                               ###
final_14 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_14  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_14 = predict(fit_14, test_temp, type = "raw")                                  ###2

mape = data.table(res_14,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_14$nn = res_14                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_14  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_14 = predict(fin_14, test_temp, type = "raw")                                                ###2

mape = data.table(ren_14,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_14$hyb = ren_14                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_14) <- col_headings                                                     ###

final_mape[14,] = data.frame(res_var,res_nn,res_hyb)                                ###



##########################################################################################
##
##      ZONE 15
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 15")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 15 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_15 = NULL                                                               ###
final_15 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_15  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_15 = predict(fit_15, test_temp, type = "raw")                                  ###2

mape = data.table(res_15,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_15$nn = res_15                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_15  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_15 = predict(fin_15, test_temp, type = "raw")                                                ###2

mape = data.table(ren_15,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_15$hyb = ren_15                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_15) <- col_headings                                                     ###

final_mape[15,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 16
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 16")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 16 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_16 = NULL                                                               ###
final_16 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_16  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_16 = predict(fit_16, test_temp, type = "raw")                                  ###2

mape = data.table(res_16,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_16$nn = res_16                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_16  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_16 = predict(fin_16, test_temp, type = "raw")                                                ###2

mape = data.table(ren_16,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_16$hyb = ren_16                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_16) <- col_headings                                                     ###

final_mape[16,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 17
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 17")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 17 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_17 = NULL                                                               ###
final_17 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_17  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_17 = predict(fit_17, test_temp, type = "raw")                                  ###2

mape = data.table(res_17,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_17$nn = res_17                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_17  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_17 = predict(fin_17, test_temp, type = "raw")                                                ###2

mape = data.table(ren_17,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_17$hyb = ren_17                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_17) <- col_headings                                                     ###

final_mape[17,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 10
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 18")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 18 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_18 = NULL                                                               ###
final_18 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_18  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_18 = predict(fit_18, test_temp, type = "raw")                                  ###2

mape = data.table(res_18,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_18$nn = res_18                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_18  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_18 = predict(fin_18, test_temp, type = "raw")                                                ###2

mape = data.table(ren_18,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_18$hyb = ren_18                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_18) <- col_headings                                                     ###

final_mape[18,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 19
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 19")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 19 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_19 = NULL                                                               ###
final_19 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_19  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_19 = predict(fit_19, test_temp, type = "raw")                                  ###2

mape = data.table(res_19,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_19$nn = res_19                                                              ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_19  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_19 = predict(fin_19, test_temp, type = "raw")                                                ###2

mape = data.table(ren_19,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_19$hyb = ren_19                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_19) <- col_headings                                                     ###

final_mape[19,] = data.frame(res_var,res_nn,res_hyb)                                ###


##########################################################################################
##
##      ZONE 20
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 20")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 20 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_20 = NULL                                                               ###
final_20 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_20  <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_20 = predict(fit_20, test_temp, type = "raw")                                  ###2

mape = data.table(res_20,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_20$nn = res_20                                                             ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_20  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_20 = predict(fin_20, test_temp, type = "raw")                                                ###2

mape = data.table(ren_20,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_20$hyb = ren_20                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_20) <- col_headings                                                     ###

final_mape[20,] = data.frame(res_var,res_nn,res_hyb)                                ###



##########################################################################################
##
##      ZONE 21
##
#######################################################3

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 21")             ###change zone as per need


#load_z1 = load_z1[!is.na(load_z1$load)]



#define data frame for hourly load
load_z1_hourly = NULL

#cursor to arrange data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(load_z1))
{
  cursor = load_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+4])
    frame = c(cursor[,1],cursor[,2],cursor[,3],cursor[,4],k,cum_hour,temp)
    load_z1_hourly = rbind(load_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

library(data.table)

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

load_z1_hourly = load_z1_hourly[!is.na(load_z1_hourly$load)]

load_temp = load_z1_hourly
load_temp$temper1 = all_temp$temper1
load_temp$temper2 = all_temp$temper2
load_temp$temper3 = all_temp$temper3
load_temp$temper4 = all_temp$temper4
load_temp$temper5 = all_temp$temper5
load_temp$temper6 = all_temp$temper6
load_temp$temper7 = all_temp$temper7
load_temp$temper8 = all_temp$temper8
load_temp$temper9 = all_temp$temper9
load_temp$temper10 = all_temp$temper10
load_temp$temper11 = all_temp$temper11


#############################################################################################
### get validation data for 1st missing week
#read all validation data
val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

#filter for zone 1 and current week (march2015)
val_z1 = sqldf("select * from val where zone_id = 21 and year = 2005 and month = 3")       ############

#define data frame for hourly load
val_z1_hourly = NULL


#cursor to arrange validation data into a time series of hourly load
cum_hour = 1
for (i in 1:nrow(val_z1))
{
  cursor = val_z1[i,]
  for (k in 1:24)
  {
    temp = (cursor[,k+5])
    frame = c(cursor[,2],cursor[,3],cursor[,4],cursor[,5],k,cum_hour,temp)
    val_z1_hourly = rbind(val_z1_hourly,frame)
    cum_hour = cum_hour+1
  }
}

val_z1_hourly = data.table(val_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(val_z1_hourly) <- col_headings

#get hourly data before 6/3/2005 from load_temp i.e. load data joined with temperature
#data from load_temp table before week to predict for zone 1

req_cum_hour = sqldf("select * from load_temp 
                     where cum_hour <= (select cum_hour from load_temp l
                     where (l.year = 2005 and l.month = 3 and l.day = 5 and l.hour = 24))")      #######change at next week not zone

#### stationarity

library(tseries)
load_temp$load_diff = c(1,diff(load_temp$load))
adf.test(load_temp$load_diff)
kpss.test(load_temp$load_diff)

load_temp$temper1_diff = c(1,diff(load_temp$temper1))
adf.test(load_temp$temper1_diff)
kpss.test(load_temp$temper1_diff)

#load_temp = load_temp[!is.na(load_temp$load)]


## select temperature series based on MI

#bin calculation as per sturges rule  ##15
log2(length(load_temp$load))

library(entropy)
res = NULL
y2d = discretize2d(load_temp$load,load_temp$temper1, numBins1=15, numBins2=15)
res[1] = mi.empirical(y2d)

y2d = discretize2d(load_temp$load,load_temp$temper2, numBins1=15, numBins2=15)
res[2] = mi.empirical(y2d)


library(vars)
var_data = cbind(req_cum_hour$load,req_cum_hour$temper1,req_cum_hour$temper2
                 ,req_cum_hour$temper3
                 ,req_cum_hour$temper4
                 ,req_cum_hour$temper5
                 ,req_cum_hour$temper6
                 ,req_cum_hour$temper7
                 ,req_cum_hour$temper8
                 ,req_cum_hour$temper9
                 ,req_cum_hour$temper10
                 ,req_cum_hour$temper11)


#VARselect(var_data,lag.max = 100,type="both")

model = VAR(var_data, p = 99, type = "both")

#plot(model,include=200)

pred = predict(model, n.ahead = nrow(val_z1_hourly), ci = 0.95)

#dev.off()

#ts.plot(pred$fcst$y1[,1])

#acf(residuals(model)[,1])

mape = data.table(pred$fcst$y1[,1],val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)
res_var = sum(mape$err)/nrow(mape)

final_21 = NULL                                                               ###
final_21 = data.table(val_z1_hourly$load,pred$fcst$y1[,1])                     ###

################################################
#neural netwrok prediction
################################################

library(caret)                                                                 ####
fit_21 <- avNNet(load ~ temper1+temper2+temper3+temper4                            
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=req_cum_hour, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

res_21 = predict(fit_21, test_temp, type = "raw")                                  ###2

mape = data.table(res_21,val_z1_hourly$load)                                     ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_nn = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_21$nn = res_21                                                             ####2

#########################################
#### prediction by hybrid
#########################################

test = NULL
x = as.data.frame(req_cum_hour$load[100:nrow(req_cum_hour)])
test = data.table(x)
names(test) = c("load")
test$temper1 = rollmean(req_cum_hour$temper1[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper2 = rollmean(req_cum_hour$temper2[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper3 = rollmean(req_cum_hour$temper3[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper4 = rollmean(req_cum_hour$temper4[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper5 = rollmean(req_cum_hour$temper5[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper6 = rollmean(req_cum_hour$temper6[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper7 = rollmean(req_cum_hour$temper7[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper8 = rollmean(req_cum_hour$temper8[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper9 = rollmean(req_cum_hour$temper9[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper10 = rollmean(req_cum_hour$temper10[1:(nrow(req_cum_hour)-1)],99,align = "right")
test$temper11 = rollmean(req_cum_hour$temper11[1:(nrow(req_cum_hour)-1)],99,align = "right")

###
fin_21  <- avNNet(load ~ temper1+temper2+temper3+temper4
                  +temper5+temper6+temper7+temper8+temper9+temper10+temper11,
                  data=test, repeats=25, size=3, decay=0.1,
                  linout=TRUE)

ren_21 = predict(fin_21, test_temp, type = "raw")                                                ###2

mape = data.table(ren_21,val_z1_hourly$load)                                             ###
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

res_hyb = sum(mape$err)/nrow(mape)
sum(mape$err)/nrow(mape)

final_21$hyb = ren_21                                                                   ###2
col_headings <- c('actual','var','nn','hyb')
colnames(final_21) <- col_headings                                                     ###

final_mape[21,] = data.frame(res_var,res_nn,res_hyb)                                ###



###################################################################################################
##
##   WRITE ALL FINAL RESULTS TO CSV FILE
##
###################################################################################################


FF <- as.matrix((final_mape))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/allzonemape.csv", sep = ",", 
            col.names = FALSE, append=FALSE)



FF <- as.matrix((final_1))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone1.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_2))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone2.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_3))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone3.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_4))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone4.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_5))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone5.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_6))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone6.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_7))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone7.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_8))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone8.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_9))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone9.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_10))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone10.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_11))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone11.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_12))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone12.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_13))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone13.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_14))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone14.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_15))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone15.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_16))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone16.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_17))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone17.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_18))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone18.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_19))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone19.csv", sep = ",", 
            col.names = FALSE, append=FALSE)


FF <- as.matrix((final_20))
write.table(FF, file = "C:/Users/hp-pc/Documents/IRDM/results/zone20.csv", sep = ",", 
            col.names = FALSE, append=FALSE)



library(ggplot2)


df1 = data.frame(Hour=seq(1:length(final_2$actual)),Load=final_3$nn)

df2 = data.frame(Hour=seq(1:length(final_2$actual)),Load=final_3$var)

ggplot(df1,aes(Hour,Load))+geom_line(aes(color="Actual"))+
geom_line(data=df2,aes(color="Predicted by NN"))+
labs(color="Legend")


