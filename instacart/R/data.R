#' Aisle information
#' 
#' A dataset containing the id and name of aisles
#' 
#' @format A data frame with 134 rows and 2 variables
#' \describe{
#'   \item{aisle_id}{aisle id}
#'   \item{aisle}{name of aisle}
#' }
#' @source Instacart's kaggle competition
'aisle'

#' Department information
#' 
#' A dataset containing the id and name of departments
#' 
#' @format A data frame with 21 rows and 2 variables
#' \describe{
#'   \item{department_id}{department id}
#'   \item{department}{name of department}
#' }
#' @source Instacart's kaggle competition
'department'

#' Product information
#' 
#' A dataset containing product information
#' 
#' @format A data frame with 49,688 rows and 4 variables
#' \describe{
#'   \item{product_id}{product id}
#'   \item{product_name}{name of product}
#'   \item{aisle_id}{product's aisle id}
#'   \item{deparment_id}{product's department id}
#' }
#' @source Instacart's kaggle competition
'products'

#' Previous order contents for all customers
#' 
#' A dataset containing the previous orders for all customers
#' 
#' @format A data frame with 32,414,489 rows and 4 variables
#' \describe{
#'   \item{order_id}{order id}
#'   \item{product_id}{product id}
#'   \item{add_to_cart_order}{order product was added to cart}
#'   \item{reordered}{indicates that customers previously ordered this product}
#' }
#' @source Instacart's kaggle competition
'order_products_prior'

#' Previous order contents for all customers
#' 
#' A training dataset containing the previous orders for all customers
#' 
#' @format A data frame with 1,384,617 rows and 4 variables
#' \describe{
#'   \item{order_id}{order id}
#'   \item{product_id}{product id}
#'   \item{add_to_cart_order}{order product was added to cart}
#'   \item{reordered}{indicates that customers previously ordered this product}
#' }
#' @source Instacart's kaggle competition
'order_products_train'

#' A dataset that tells which set (prior, train, test) an order belongs.
#' 
#' A dataset containing which set the order belongs to.
#' 
#' @format A data frame with 3,421,083 rows and 7 variables
#' \describe{
#'   \item{order_id}{order id}
#'   \item{user_id}{user id}
#'   \item{eval_set}{which set the order belongs to}
#'   \item{order_number}{order number}
#'   \item{order_dow}{day of week order was placed}
#'   \item{order_hour_of_day}{hour order was placed}
#'   \item{days_since_prior_order}{days since user placed previous order}
#' }
#' @source Instacart's kaggle competition
'orders'

#' Sample submissions
#' 
#' A dataset showing submission format
#' 
#' @format A data frame with 75,000 observations and 2 variables
#' \describe{
#'   \item{order_id}{order id}
#'   \item{products}{space delimited string of predicted products}
#' }
#' @source Instacart's kaggle competition
'sample_submission'
