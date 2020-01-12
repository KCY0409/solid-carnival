#트랜드 시각화
library(ggplot2)

#이동 평균
#Example1 : 50일/200일 단순 이동 평균 차트 작성
SS %>%
  ggplot(aes(x=date, y=close)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  geom_ma(ma_fun = SMA, n = 50, linetype = 5, size = 1.25) +
  geom_ma(ma_fun = SMA, n = 200, color = "red", size = 1.25) +
  labs(title = "SamSung Candlestick Chart",
       subtitle = "50 and 200-Day SMA",
       y = "Closing Price", x = "") +
       coord_x_date(xlim = c(end - weeks(24), end),
                    ylim = c(1500000, 1850000)) +
  theme_tq()

#Example2 : 지수 이동 평균 차트
SS %>%
  ggplot(aes(x = date, y = close)) + 
  geom_barchart(aes(open = open, high = high, low = low, close = close)) +
  geom_ma(ma_fun = EMA, n = 50, wilder = TRUE, linetype = 5, size = 1.25) +
  geom_ma(ma_fun = EMA, n = 200, wilder = TRUE, color = "red", size = 1.25) +
  labs(title = "SamSung Bar Chart",
       subtitle = "50 and 200-Day EMA",
       y = "Closing Price", x = "") +
       coord_x_date(xlim = c(end - weeks(24), end),
                    ylim = c(1500000, 1850000)) +
  theme_tq()
  
