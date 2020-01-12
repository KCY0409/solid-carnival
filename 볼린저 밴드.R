#볼린저 밴드

# Example 1 : SMA를 사용하여 BBands 적용
SS %>%
  ggplot(aes(x = date, y = close, open = open,
             high = high, low = low, close = close)) +
  geom_candlestick() +
  geom_bbands(ma_fun = SMA, sd = 2, n = 20) +
  labs(title = "SamSung Candlestick Chart",
       subtitle = "BBands with SMA Applied",
       y = "Closing Price", x = "") +
       coord_x_date(xlim = c(end - weeks(24), end),
                    ylim = c(1500000, 1850000)) +
  theme_tq()

# Example 2 : Bollinger Bands의 모양 바꾸기
SS %>%
  ggplot(aes(x = date, y = close, open = open,
             high = high, low = low, close = close)) +
  geom_candlestick() +
  geom_bbands(ma_fun = SMA, sd = 2, n = 20, 
              linetype = 4, size = 1, alpha = 0.2,
              fill        = palette_light()[[1]],
              color_bands = palette_light()[[1]],
              color_ma    = palette_light()[[2]]) +
  labs(title = "SamSung Candlestick Chart", 
       subtitle = "BBands with SMA Applied, Experimenting with Formatting", 
       y = "Closing Price", x = "") + 
  coord_x_date(xlim = c(end - weeks(24), end),
               ylim = c(1500000, 1850000)) + 
  theme_tq()

# Example 3 : 여러 주식에 BBands 추가
start <- end - weeks(12)
SHANK %>%
  filter(date >= start - days(2*20)) %>%
  ggplot(aes(x = date, y = close,
             open = open, high = high, low = low, close = close,
             group = symbol)) +
  geom_barchart() +
  geom_bbands(ma_fun = SMA , sd = 2, n =20, linetype = 5) +
  labs(title = "SHANK Bar Chart",
       subtitle = "BBands with SMA Applied, Experimenting with Multiple Stocks",
       y = "Closing Price", x = "") +
  coord_x_date(xlim = c(start, end)) +
  facet_wrap(~ symbol, ncol = 2 , scales = "free_y") +
  theme_tq()
