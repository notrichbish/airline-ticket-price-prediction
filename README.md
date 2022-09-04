# Airline Ticket Price Prediction using Correlation and Regression analysis

This project was one of the requirements within my postgraduate module called Applied Statistics. The main aim of this project is to generate an accurate model in predicting airline ticket price based on the features. The machine learning models used in this project are Simple Linear Regression and Multiple Linear regression. Additionally, a timeseries using AUTO ARIMA is performed to forecast the price of a particular airline in the year of 2023. The main process flow of this project is performing Exploratory Data Analysis, Data Pre-processing, Correaltion Analysis, Model Training, Timeseries Analysis, and Hypothesis Testing using ADF. 

The project is coded in R Language using the R Studio IDE.

There are 2 dataset used in this project which are located in the "Dataset" folder.

The fuil code can be viewed in the "Code.R" file. 

If anyone wants to use a part of the code. Please reference it. Thanks. 

# Executive Summary

Current research within this domain imply that airline ticket prices can be predicted using a set of a certain features which can be useful companies and tourist to deduce the price and when is the best time to buy a flight ticket. As the price of a flight ticket fluctuates as there is a seasonal price is applied from time to time, it is difficult to get an accurate prediction. Thus, the main question now is it possible to predict the ticket price based on features related to the flight itself such as flight duration, number of stops, etc.

During correlation analysis, a strong positive correlation of 0.92 is identified between average price and remaining days left to buy the ticket. This was the strongest of all correlation founded. The linear regression analysis discovered that the feature “average price” and “days_left” could explain 62.53% of the variation of “average price”. Moreover, the timeseries analysis forecasted that in April 2023 the ticket price for Jet Airways is ₹12431.34.

Overall, the findings in this project conclude that the features can be used to predict the airline ticket price. Nevertheless, more features could be considered such as weather condition or expanding the dataset more with numerical variables to predict a more accurate result.

# Statistical Questions
1.	Does choosing different airlines affect the price of the ticket?
2.	Is there a difference in the price of an economy and business flight ticket?
3.	Does buying a ticket ahead of time affect the ticket price?
4.	Does the departure and arrival time affect the ticket price?
5.	Does the source and destination of the flight impact the ticket price? 
6.	Does the number of stops (transit) affect the ticket price?
7.	What is the forecasted ticket price of Jet Airways in the year of 2023?
8.	Is the timeseries produced for the forecasting stationary?

# Conclusion and Future Recommendation 

The project covers all the process from data pre-processing to developing a linear regression model. The results found in this project encompasses all the statistical questions mentioned previously.  Data pre-processing was performed to transform the data into suitable standard for the linear regression model. A correlation analysis is completed to identify which are the variables that are strongly dependent on each other which are beneficial for the linear regression analysis. Based on the correlation analysis, linear regression model was created to perform prediction on the airline flight price ticket. Additionally, a timeseries analysis is made to forecast the price of the ticket of Jet Airways airline in 2023 which is ₹12431.34. Finally, hypothesis testing using Augmented Dickey Fuller (ADF) or unit root test is carried out to identify whether the timeseries is stationary or not. 

Overall, the features provided can deduce the airline price ticket. However, not all features are used and strong enough to achieve this task. Thus, a future improvement can be done where more factors could be considered such as weather condition or expanding the dataset more with more numerical variables which can be used to predict a more accurate result.


