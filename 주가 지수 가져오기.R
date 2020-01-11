#tidyquant는 quantmod 등 주식분석을 주 목적으로 하는 중요 함수를 제공하는 중요한 퓨ㅐ키지
#tidy data 개념을 활용한 데이터 핸들링, ggplot과 연계된 강한 차트 그리기, 야후를 기본으로 구글 및 각자 독자적인 데이터 소스로 부터 필요한 데이터를 손쉽게 가져오는 기능, 성능 분석 함수들을 제공하고 있습니다.


#주가 지수 가져오기
#tidyquant는 야후 파이넨스에서 정보를 가져옴
#가져오는 데이터 소스를 바꾸고 싶으면 어떤 곳에서 가져올지 결정 가능
#tq_get_options()는 가능한 후보를 보여줌
if(!require(tidyquant)) install.packages("tidyquant", repos = "https://cloud.r-project,org/",verbose = F)
library(tidyquant)
tq_get_options()

#이때, 코스피 == ^511, 코스닥 == ^KOSDAQ
tq_get("^KS11")
tq_get("^KOSDAQ")

#각 기업의 주가를 가져오려면 종목 번호 숙지
#양식은 종목번호.KS , 종목번호는 DART전자공시시스템에서 사용하는 번호
#삼성전자 번호 005930
ss<-tq_get("005930.KS")
ss

#날짜 지정 가능
ssdate <- tq_get("005930.KS", from="2016-01-01", to="2016-05-05")
ssdate

#배당금 정보는 dividends에서 확인 가능
ssdiv <- tq_get("005930.KS", get="dividends")
ssdiv

#야후파이낸스가 데이터 소스보다 보니 모든 정보가 있다고 보기 어려움
#거기가 종목번호를 일일이 찾는 것도 어렵기에 이러한 문제 해결을 위해 tqk가 시작


