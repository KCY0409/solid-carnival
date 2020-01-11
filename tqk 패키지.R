#tqk소개 - 한국 주식 데이터 패키지

library(dplyr) # %>% 파이프 연산자 사용

#종목 코드 가져오기
#본래 tidyquant 패키지는 symbol를 인자로 주식 데이터를 가져옴
#한국 주식은 종목별 코드가 존재 그로 인해 코드와 종목명이 매치되어 있는 데이터를 확인할 수  있어야 한다.
#tqk 패키지는 code_get()함수를 통해 진행 가능
if (!require(remotes)) install.packages("remotes", verbose = F)
library(remotes)
if (!require(tqk)) install_github("mrchypark/tqk", verbose = F)
library(tqk)
code <- code_get()
code

#패키지 설치 안되서 찾아서 해본건데 되어버렸다.
#install.packages(c("curl", "httr"))
#config=httr::config(ssl_verifypeer = FALSE)
#install.packages("RCurl")
#options(RCurlOptions = c(getOption("RCurlOptions"),ssl.verifypeer = FALSE, ssl.verifyhost = FALSE))
#getOption("RCurlOptions")
#library(httr)
#set_config(config(ssl_verifypeer = 0L))
#install_github("mrchypark/tqk", auth_token = "")

#주식 데이터 가져오기
#tqk_get()은 종목 코드로 데이터를 가져옴
ss_prices <-
  code_get() %>%
  filter(name == "삼성전자") %>%
  select(code) %>%
  tqk_get(from = "2018-05-01")

ss_prices

#Quandl
#방대한 양의 경제, 주식에 대한 정보를 가지고 서비스하는 데이터 판매 기업
#Quandl이라는 자체 패키지만 사용해도 되고, tidyquant가 내장하고 있어서 같이 사용해도 가능

#tidyverse와 함께 사용하는 시계열 데이터
#그동안의 주식관련 패키지들은 파이프 연산자와 함께 사용하지 못했다.
#tidyquant는 그런 문제를 해결, 아래 2가지 중요한 함수를 추가함으로써 dplyr과 tidyr의 함수와 함께 사용 가능
#    1.tq_transmute() : 계산된 내용의 컬럼만으로 데이터를 구성
#    2.tq_mutate() : 데이터에 계산된 내용의 컬럼을 추가
library(tidyquant)

#tq_에서 계산 가능한 함수들
#tq_tranmute_fun_options() 함수는 각 참고 패키지에서 활용할 ㅅ수 있는 함수의 리스트를 보여줌
#모두 zoo,xts,quantmod,TTR,PerformanceAnalytics 의 5개 패키지내의 함수를 지원
tq_transmute_fun_options() %>% str

#zoo 함수
tq_transmute_fun_options()$zoo
# 롤링관련 함수 : 
#    - 롤링 마진에 기능을 적용하는 일반적인 기능
#    - form :rollapply(data, width, FUN, ..., by = 1, by.column = TRUE, fill = if (na.pad) NA, na.pad = FALSE, partial = FALSE, align = c("center", "left", "right"), coredata = TRUE).
#    - 옵션에는 rollmax,rollmean,rollmedian,rollsum 등이 있습니다.

#xts 함수
tq_transmute_fun_options()$xts
# 기간 적용 기능 :
#    - 기능을 시간 세그먼트 (예 : max, min, mean 등)에 적용합니다.
#    - 양식 :apply.daily (x, FUN, ...).
#    - 옵션은apply.daily,weekly,monthly,quarterly,yearly를 포함합니다.
# 기간 기능 :
#    - 시계열을 낮은 주기성의 시계열로 변환합니다 (예 : 매일 매일의 주기성으로 변환).
#    - 형식 :to.period (x, period = 'months', k = 1, indexAt, name = NULL, OHLC = TRUE, ...).
#    - 옵션에는to.minutes,hourly,daily,weekly,monthly,quarterly,yearly가 포함됩니다.
#    - 참고 :to.period와to.monthly (to.weekly,to.quarterly 등) 양식의 리턴 구조는 다릅니다. to.period는 날짜를 반환하고, to.months는 MON YYYY 문자를 반환합니다. lubridate를 통해 시계열로 작업하고 싶다면to.period를 사용하는 것이 가장 좋습니다

#quantmod 함수
tq_transmute_fun_options()$quantmod
# 비율 변경 (Delt) 및 Lag 기능
#    - Delt :Delt (x1, x2 = NULL, k = 0, type = c ( "arithmetic", "log"))
#        * Delt의 변형 : ClCl, HiCl, LoCl, LoHi, OpCl, OpHi, OpLo, OpOp
#        * 양식 :Opcl (OHLC)
#    - Lag :Lag(x, k = 1)/ Next :Next(x, k = 1)(dplyr :: lag과dplyr :: lead도 사용할 수 있습니다)
# 기간 반환 함수 :
#    - 매일, 매주, 매월, 분기 별 및 연간을 포함하는 다양한주기에 대한 산술 또는 로그 반환을 가져옵니다.
#    - 형식 :periodReturn (x, period = 'monthly', 부분 집합 = NULL, type = 'arithmetic', leading = TRUE, ...)
# 시리즈 기능 :
#    - 계열을 설명하는 반환 값. 옵션에는 증감, 가감 및 고저 설명이 포함됩니다.
#    - 양식 :seriesHi (x),seriesIncr (x, thresh = 0, diff. = 1L),seriesAccel (x)

#TTR 함수
tq_transmute_fun_options()$TTR
#사이트 참고
#https://mrchypark.github.io/tqk/articles/tqk-introduce.html

#PerformanceAnalytics 함수
tq_transmute_fun_options()$PerformanceAnalytics
#Return.annualized 및Return.annualized.excess : 기간 반환을 취하여 연간 수익으로 통합합니다. 
#Return.clean : 반환 값에서 특이 값을 제거합니다. 
#Return.excess : 무위험 이자율을 초과하는 수익률로 수익률에서 무위험 이자율을 제거합니다. zerofill : ’NA’값을 0으로 대체하는 데 사용됩니다.


