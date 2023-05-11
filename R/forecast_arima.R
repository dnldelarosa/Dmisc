forecast_arima <- function(model, .extend = NULL, ...){
  if(!is.null(.extend)){
    xreg <- model$xreg %>%
      ts_extend(.extend)

    if(get_arima_comp(model, 'drift')){
      xreg <- xreg %>%
        ts_select(.exclude = 'drift')
    }
  }

  forecast::forecast(
    model,
    xreg = xreg,
    ...
  )
}
