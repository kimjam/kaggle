library(dplyr)
library(ggplot2)
library(lubridate)
library(caret)
library(MASS)

# minimize this
multilogloss <- function(act, pred)
{
  eps = 1e-15;
  nr <- nrow(pred)
  pred = matrix(sapply( pred, function(x) max(eps,x)), nrow = nr)      
  pred = matrix(sapply( pred, function(x) min(1-eps,x)), nrow = nr)
  ll = sum(act*log(pred) + (1-act)*log(1-pred))
  ll = ll * -1/(nrow(act))      
  return(ll);
}

df <- read.csv('~/kaggle/kobe/data.csv')

df$shot_made_flag <- factor(df$shot_made_flag, levels = c('1', '0'))

# minutes played
minutes_played <- (
  ifelse(
    df$period > 4, 
    df$period*5*60, 
    df$period*12*60)- df$minutes_remaining*60 - df$seconds_remaining) / 60

df$minutes_played <- minutes_played
# assume each game starts at midnight to add time
# can only use data that happened before shot to predict shot
df$game_date <- as.POSIXct(
  df$game_dat,
  format = '%Y-%m-%d'
) + 
  lubridate::minutes(floor(minutes_played)) + 
  lubridate::seconds((minutes_played %% 1)*60)
  
set.seed(24) #kobe
train <- df[!is.na(df$shot_made_flag), ]
test <- train[sample(1:nrow(train), 4000), ]
train <- train[!(train$shot_id %in% test$shot_id), ]
validate <- df[is.na(df$shot_made_flag), ]

train_act <- cbind(ifelse(train$shot_made_flag == 1, 1, 0), 
                   ifelse(train$shot_made_flag == 0, 1, 0))

test_act <- cbind(ifelse(test$shot_made_flag == 1, 1, 0), 
                  ifelse(test$shot_made_flag == 0, 1, 0))

# create another test set from training set
# for each shot in new test set, create data set to train model
# data set can only contain data before the shot you are trying to predict
# logistic, random forest, svm, ensemble?
formula <- shot_made_flag ~ combined_shot_type + shot_zone_area + shot_distance + minutes_played
predictions <- data.frame(log = numeric(nrow(test)), 
                          svm = numeric(nrow(test)), 
                          rf = numeric(nrow(test)))

logreg_build <- function(train, test, formula) {
  logreg <- vector('numeric', nrow(test))
  for (i in 1:nrow(test)) {
    pre_df <- train %>%
      dplyr::filter(
        game_date <= test$game_date[i]
      )
    
    logreg_model <- stepAIC(
      glm(formula = formula, 
          data = pre_df, 
          family = binomial(link='logit')), 
      direction = 'backward', 
      trace = FALSE)
    
    logreg[i] <- predict(logreg_model, newdata = test[i, ], type = 'response')
  }
  
  return(logreg)
}

predictions$log <- logreg_build(train = train, test = test, formula = formula)

