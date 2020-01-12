#ggplot2 함수

# Example 1 : scale_y_log10을 사용한 로그 스케일
# ggplot2는 y축을 로그 스케일로 스케일 하기 위한 scale_y_log10() 함수를 가짐.
# 이는 분석 할 수 있는 선형 추세를 조정하는 경향이 있으므로 매우 유용

#Continuous Scale : 
NVR %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line(color = palette_light()[[1]]) + 
  scale_y_continuous() +
  labs(title = " Naver Line Chart",
       subtitle = "Continuous Scale",
       y= "Closing Price", x = "") +
  theme_tq()

#Log Scale:
NVR %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line(color = palette_light()[[1]]) +
  scale_y_log10() + 
  labs(title = "Naver Line Chart",
       subtitle = "Log Scale",
       y = "Closing Price", x = "") +
  theme_tq()

# Example 2 : geom_smooth로 회귀 추세선

#linear
NVR %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line(color = palette_light()[[1]]) +
  scale_y_log10() +
  geom_smooth(method = "lm") + #geom_smooth(method = "loess")
  labs(title = "Naver Line Chart",
       subtitle = "Log Scale, Applying Linear Trendline",
       y = "Adjusted Closing Price", x = "") +
  theme_tq()

# Example 3 : geom_segment로 차트 볼륨

NVR %>%
  ggplot(aes(x = date, y = volume)) +
  geom_segment(aes(xend = date, yend = 0, color = volume)) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(title = "Naver Volume Chart",
       subtitle = "Charting Daily Volume",
       y = "Volume", x = "") +
  theme_tq() +
  theme(legend.position = "none")

# 특정지역 확대
# scale_color_gradient를 이용해 고점 및 저점을 빠르게 시각화 가능
# geom_smooth를 사용해 추세 확인 가능
start <- end - weeks(24)
NVR %>%
  filter(date >= start - days(50)) %>%
  ggplot(aes(x = date, y = volume)) +
  geom_segment(aes(xend = date, yend = 0, color = volume)) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(title = "Naver Bar Chart",
       subtitle = "Charting Daily Volume, Zooming In",
       y = "Volume", x = "") +
  coord_x_date(xlim = c(start, end)) +
  scale_color_gradient(low = "red", high = "darkblue") +
  theme_tq() +
  theme(legend.position = "none")

# 테마
# tidyquant 패키지는 3가지 테마로 구성
# 1. Light : theme_tq() + scale_color_tq() + scale_fill_tq()
# 2. Dark  : theme_tq_dark() + scale_color_tq(theme = "dark") + scale_fill_tq(theme = "dark)
# 3. Green : theme_tq_green() + scale_color_tq(theme = "green") + scale_fill_tq(theme = "green")

# Dark
n_mavg <- 50 # Number of periods (days) for moving average
SHANK %>%
  filter(date >= start - days(2 * n_mavg)) %>%
  ggplot(aes(x = date, y = close, color = symbol)) +
  geom_line(size = 1) +
  geom_ma(n = 15, color = "darkblue", size = 1) + 
  geom_ma(n = n_mavg, color = "red", size = 1) +
  labs(title = "Dark Theme",
       x = "", y = "Closing Price") +
  coord_x_date(xlim = c(start, end)) +
  facet_wrap(~ symbol, scales = "free_y") +
  theme_tq_dark() +
  scale_color_tq(theme = "dark")
