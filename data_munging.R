###
###     IRDM GROUP PROJECT
###

library("sqldf", lib.loc="~/R/win-library/3.2")

#read all load data
#load = read.csv("C:/Users/hp-pc/Documents/IRDM/Load_history.csv")

#filter for zone 1
load_z1 = sqldf("select * from load where zone_id = 1")

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

#load_z1_hourly is hourly load timeseries with cum_hour as hour
load_z1_hourly = data.table(load_z1_hourly)
col_headings <- c('zone_id','year','month','day','hour','cum_hour','load')
colnames(load_z1_hourly) <- col_headings

#load_z1_hourly$cum_hour = as.integer(load_z1_hourly$cum_hour)
#load_z1_hourly$int_load = (as.character(load_z1_hourly$load))



#read all validation data
#val = read.csv("C:/Users/hp-pc/Documents/IRDM/Benchmark.csv")

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


#prediction for missing week 1 (6/3/2005 to 12/3/2005)
#
#

#get hourly data before 6/3/2005
req_cum_hour = sqldf("select * from load_z1_hourly 
                     where cum_hour < (select cum_hour from load_z1_hourly l
                     where (l.year = 2005 and l.month = 3 and l.day = 6 and l.hour = 1))")      #######change at next week not zone

ts_load = ts(req_cum_hour$load)

model  = arima(ts_load, order = c(60,1,3))
model = auto.arima(ts_load,
                   ic=c("aicc", "aic", "bic"))

model

fcast = forecast(model)
plot.forecast(fcast,include=10)

fcast = forecast(model,h=nrow(val_z1_hourly))
plot.forecast(fcast,include=100)

fcast$mean



fcast[1,4]

fcast$model

t=data.table(fcast)


mape = data.table(fcast$mean,val_z1_hourly$load)
col_headings <- c('fcast','act')
colnames(mape) <- col_headings

mape$err = (mape$act-mape$fcast)/mape$act
mape$err = abs(mape$err)

sum(mape$err)/nrow(mape)

df1 = data.frame(Hour=seq(1:length(fcast$mean)),Load=val_z1_hourly$load)

df2 = data.frame(Hour=seq(1:length(fcast$mean)),Load=fcast$mean)

ggplot(df1,aes(Hour,Load))+geom_line(aes(color="Actual"))+
geom_line(data=df2,aes(color="Predicted by ARIMA"))+
labs(color="Legend")

