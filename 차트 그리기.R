#ggplot2와 연계된 차트 그리기
#ggplot2 차트를 그리는데 R에서 가장 유명한 패키지 입니다. gg는 Grammar of Graphics의 줄임말로 그림을 생성하는 것에 대한 규칙을 제안하고 있습니다. tidyquant는 ggplot2에 더해 아래와 같은 기능을 추가로 제공합니다.
#  - 차트 종류 : 두 개의 차트 타입 시각화는geom_barchart와geom_candlestick을 사용하여 가능합니다.
#  - 이동 평균 : ’geom_ma’를 사용하여 7 개의 이동 평균 시각화를 사용할 수 있습니다.
#  - Bollinger Bands : Bollinger 밴드는 ’geom_bbands’를 사용하여 시각화 할 수 있습니다. BBand 이동 평균은 이동 평균에서 사용할 수있는 7 가지 중 하나 일 수 있습니다.
#  - 날짜 범위 확대 : 차트의 특정 영역을 확대 할 때 데이터 손실을 방지하는 두 가지coord 함수 (coord_x_date 및coord_x_datetime)를 사용할 수 있습니다. 이것은 이동 평균 및 Bollinger 밴드 기하학을 사용할 때 중요합니다.
library(ggplot2)

#살펴보기
library(tqk)
data(SHANK)

SS <- tqk_get(code[grep("^삼성전자$", code$name),1], to = "2016-12-31")
NVR <- tqk_get(code[grep("NAVER",code$name),1], to = "2016-12-31")
#'end' 매개 변수는 예제 전체에서 날짜 제한을 설정할 때 사용
end <- as_date("2016-12-31")

#차트 종류
#  - Bar Chart : geom_barchart을 사용
#  - Candlestick Chart : geom_candlestick을 사용

# 라인 차트
SS %>%
  ggplot(aes(x = date, y = close)) +
  geom_line() +
  labs(title = "SamSung Line Chart", y = "Closing Price", x = "") +
  theme_tq()

# 바 차트
SS %>%
  ggplot(aes(x = date, y = close)) +
  geom_barchart(aes(open = open, high = high, low = low , close = close)) +
  labs(title = "SamSung Line Chart", y = "Closing Price", x = "") +
  theme_tq()

SS %>%
  ggplot(aes(x = date, y = close)) +
  geom_barchart(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "SamSung Bar Chart", 
       subtitle = "Zoomed in using coord_x_date",
       y = "Closing Price", x = "") + 
  coord_x_date(xlim = c(end - weeks(6), end),
               ylim = c(1600000, 1800000)) + 
  theme_tq()

SS %>%
  ggplot(aes(x = date, y = close)) +
  geom_barchart(aes(open = open, high = high, low = low, close = close),
                color_up = "darkgreen", color_down = "darkred", size = 1) +
  labs(title = "SamSung Bar Chart", 
       subtitle = "Zoomed in, Experimenting with Formatting",
       y = "Closing Price", x = "") + 
  coord_x_date(xlim = c(end - weeks(6), end),
               ylim = c(1600000, 1800000)) + 
  theme_tq()

# 캔들 차트
SS %>%
  ggplot(aes(x = date, y = close)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "SamSung Candlestick Chart", y = "Closing Price", x = "") +
  theme_tq()

SS %>%
  ggplot(aes(x = date, y = close)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close),
                   color_up = "darkgreen", color_down = "darkred", 
                   fill_up  = "darkgreen", fill_down  = "darkred") +
  labs(title = "SamSung Candlestick Chart", 
       subtitle = "Zoomed in, Experimenting with Formatting",
       y = "Closing Price", x = "") + 
  coord_x_date(xlim = c(end - weeks(6), end),
               ylim = c(1600000, 1800000)) + 
  theme_tq()

# 여러개의 차트 만들기
start <- end - weeks(6)
SHANK %>%
  filter(date >= start - days(2 * 15)) %>%
  ggplot(aes(x = date, y = close, group = symbol)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "SHANK Candlestick Chart", 
       subtitle = "Experimenting with Mulitple Stocks",
       y = "Closing Price", x = "") + 
  coord_x_date(xlim = c(start, end)) +
  facet_wrap(~ symbol, ncol = 2, scale = "free_y") + 
  theme_tq()