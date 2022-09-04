library(ggplot2)
library(dplyr)
library(psych)
library(caret)
library(tseries)
library(forecast)

#Import Dataset
df_flight = read.csv("Clean_Dataset.csv", stringsAsFactors = TRUE)

#Remove redunadant columns
df_flight$X <- NULL

#identify missing values
colSums(is.na(df_flight))

#Identify blank values
colSums(df_flight == " ")

#identify duplicate
table(duplicated(df_flight))

#Exploratory Data Analysis
summary(df_flight)
str(df_flight)

#Plot Price variable
boxplot(df_flight$price, xlab = "Price", main = "Analysis on the Price Variable", horizontal = TRUE)

#Plot Price on histogram
ggplot(df_flight, aes(x=price)) + geom_histogram(aes(y=..density..), colour="black", fill="white", bins = 50) + 
  geom_density(alpha = 0.2, fill = "#FF6666") + ggtitle("Airline Price Distribution") + theme(plot.title = element_text(hjust = 0.5))

#Plot the price based on airline 
ggplot(data=df_flight, aes(x=airline, y=price, fill=class)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Class ticket prices based on Airlines") + theme(plot.title = element_text(hjust = 0.5))

#Seperating Economy and Business class data 
Economy = df_flight[df_flight$class == "Economy",]
Business = df_flight[df_flight$class == "Business",]

#Plot Economy ticket prices per Airlines
ggplot(Economy, aes(x = airline, y = price, fill = airline)) + geom_violin() + geom_boxplot(width = 0.1) + 
  ggtitle("Economy Ticket Prices based on Airline") + theme(plot.title = element_text(hjust = 0.5))

#Plot Business Ticket prices per Airlines
ggplot(Business, aes(x = airline, y = price, fill = airline)) + geom_violin() + geom_boxplot(width = 0.1) +
  ggtitle("Business Ticket Prices based on Airline") + theme(plot.title = element_text(hjust = 0.5))

#Get the average price based on the Days Left to buy the ticket
avg_price <- df_flight %>% group_by(days_left) %>%
  summarise(mean = mean(price, na.rm = TRUE))

ggplot(avg_price, aes(x = days_left, y = mean, color = days_left)) + geom_point() + 
  geom_smooth(method = lm) + ggtitle("Average Price based on the days left") + ylab("Average Price") + 
  theme(plot.title = element_text(hjust = 0.5))

boxplot(avg_price$mean, horizontal = TRUE, main = "Average Price on Days Left", xlab = "Average Price")

#Correlation between Average Price and Days Left
pairs.panels(avg_price[c("mean", "days_left")])
pairs.panels(avg_price[c("mean", "days_left")], method = "spearman")

#Get the average price based on duration of the flight
avg_price_duration <- df_flight %>% group_by(duration) %>%
  summarise(mean = mean(price, na.rm = TRUE))

#Correlation between Average Price and Duration of the flight
pairs.panels(avg_price_duration[c("duration", "mean")])
pairs.panels(avg_price_duration[c("duration", "mean")], method = "spearman")

#Plot average price based on duration of the flight
ggplot(avg_price_duration, aes(x = duration, y = mean, color = duration)) + geom_point() + 
  geom_smooth(method = "lm") + ggtitle("Average Price based on the duration of flight") + ylab("Average Price") + 
  theme(plot.title = element_text(hjust = 0.5))

#plot the average price based on duration
boxplot(avg_price_duration$mean, horizontal = TRUE, main = "Average Price on Duration", xlab = "Average Price")

#Plot the price based on Departure Time
ggplot(df_flight, aes(x = departure_time, y = price, fill = departure_time)) + geom_boxplot() + 
  ggtitle("Price based on Departure Time") + theme(plot.title = element_text(hjust = 0.5))

#plot the price based on Arrival Time
ggplot(df_flight, aes(x = arrival_time, y = price, fill = arrival_time)) + geom_boxplot() + 
  ggtitle("Price based on Arrival Time") + theme(plot.title = element_text(hjust = 0.5))

#Get the maximum price of a flight based on the source and destination of the city
price_comp_economy <- Economy %>% group_by(source_city,destination_city) %>% 
  summarise(mean_price = mean(price, na.rm = TRUE))

price_comp_business <- Business %>% group_by(source_city,destination_city) %>% 
  summarise(mean_price = mean(price, na.rm = TRUE))

#Correlation between destination city, average price and source city
pairs.panels(price_comp_economy[c("destination_city", "mean_price", "source_city")])
pairs.panels(price_comp_economy[c("destination_city", "mean_price", "source_city")], method = 'spearman')
pairs.panels(price_comp_business[c("destination_city", "mean_price", "source_city")])
pairs.panels(price_comp_business[c("destination_city", "mean_price", "source_city")], method = 'spearman')

#plot the average price based on source and destination city
ggplot(price_comp_economy, aes(x = destination_city, y = mean_price)) + geom_point() + 
  facet_wrap(.~ source_city) + ggtitle("Economy Class Ticket Price based on the Source and Destination City") + 
  theme(plot.title = element_text(hjust = 0.5))

ggplot(price_comp_business, aes(x = destination_city, y = mean_price)) + geom_point() + 
  facet_wrap(.~ source_city) + ggtitle("Business Class Ticket Price based on the Source and Destination City") + 
  theme(plot.title = element_text(hjust = 0.5))

Economy_stops <- Economy %>% group_by(airline, stops) %>% 
  summarise(mean_price = mean(price, na.rm = TRUE))

Business_stops <- Business %>% group_by(airline, stops) %>%
  summarise(mean_price = mean(price, na.rm=TRUE))

#plot the prices of economy ticket based on stops
ggplot(data=Economy_stops, aes(x=airline, y=mean_price, fill=stops)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Economy Prices based on number of stops") + 
  theme(plot.title = element_text(hjust = 0.5))

#plot the prices of business ticket based on stops
ggplot(data=Business_stops, aes(x=airline, y=mean_price, fill=stops)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Business Prices based on number of stops") + 
  theme(plot.title = element_text(hjust = 0.5))

#Correlation between Stops, Mean Price, Airline on Economy and Business ticket class
pairs.panels(Economy_stops[c("stops", "mean_price", "airline")])
pairs.panels(Economy_stops[c("stops", "mean_price", "airline")], method = 'spearman')
pairs.panels(Business_stops[c("stops", "mean_price", "airline")])
pairs.panels(Business_stops[c("stops", "mean_price", "airline")], method = 'spearman')

#Correlation between Price, Duration, and Days Left
pairs.panels(df_flight[c("duration", "price", "days_left")])
pairs.panels(df_flight[c("duration", "price", "days_left")], method = 'spearman')

#Linear Regression
lm_duration_model <- lm(mean ~ duration, data = avg_price_duration)
summary(lm_duration_model)
lm_duration_res = summary(lm_duration_model)$residuals
plot(lm_duration_res)

lm_avgPrice <- lm(mean ~ days_left, data = avg_price)
summary(lm_avgPrice)
lm_avgPrice_res = summary(lm_avgPrice)$residuals
plot(lm_avgPrice_res)

avg_price$days_left2 = avg_price$days_left^2
lm_avgPrice2 <- lm(mean ~ days_left + days_left2, data = avg_price)
summary(lm_avgPrice2)
lm_avgPrice_res2 = summary(lm_avgPrice2)$residuals
plot(lm_avgPrice_res2)

lm_price <- lm(price ~ duration + days_left, data = df_flight)
summary(lm_price)
lm_price_res = summary(lm_price)$residuals
plot(lm_price_res)

lm_businesstops <- lm(mean_price ~ stops + airline, data = Business_stops)
summary(lm_businesstops)
lm_business_res = summary(lm_businesstops)$residuals
plot(lm_business_res)

lm_all <- lm(price ~., data = df_flight)

#Time Series Analysis
#Import the 2nd dataset
df_time_train = read.csv("train.csv", stringsAsFactors = TRUE)

#Convert date into appropriate format
df_time_train$Date_of_Journey = as.Date(df_time_train$Date_of_Journey, "%d/%m/%y")

#Identify Missing Data
colSums(is.na(df_time_train))

#Remove Redundant columns
df_time_train$Route <- NULL

table(df_time_train$Airline)

#Remove redudant data
df_time_train = subset(df_time_train, Airline != "Trujet" & Airline != "Vistara Premium economy" & Airline != "Jet Airways Business" & Airline != "Multiple carriers Premium economy")

#Plot airline based on the price
ggplot(data=df_time_train, aes(x=Airline, y=Price, fill=Airline)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Prices based on Airline") + theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle=90, vjust=.5, hjust=1))

#Extract data of the Jet Airways airline
timeseries = df_time_train[(df_time_train$Airline == "Jet Airways"),]

#Examine the average price based on the date of journey
avgPrice_JetAir <- timeseries %>% group_by(Date_of_Journey) %>%
  summarise(mean = mean(Price, na.rm = TRUE))

#Time series Analysis
ts.flightprice = ts(avgPrice_JetAir$mean, start = c(2019,1), frequency = 12)

#Train the ARIMA time series model
ts.model = auto.arima(ts.flightprice, trace = TRUE)

#Forecast the time series model
ts.forecast = forecast(ts.model, h = 12)

#Plot the forecast timeseries graph
plot(ts.forecast, xlab = "Year", ylab = "Price")

summary(ts.model)
accuracy(ts.model)

summary(ts.forecast)
accuracy(ts.forecast)

#Hypothesis Testing using ADF
adf.test(ts.forecast$fitted, alternative = "stationary")
plot(ts.model$residuals, main = "Timeseries Residual")
