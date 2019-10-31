##  --------------------- setting  -----------------------------
# install.packages(c("KoNLP", "tm", "tidyverse", "tidytext"))
library(KoNLP) ; library(tm) ; library(tidyverse) ; library(tidytext)
library(RSelenium)
useNIADic() # 감정어 분석을 위한 텍스트 사전 불러오기 

##  --------------------- tidying text data  -----------------------------

text$text %>%
  str_remove_all(., "[:punct:]") -> text$text # 특수문자 제거 

text$text %>% 
  MorphAnalyzer(.) %>%
  unlist() %>% 
  table() %>% 
  as.data.frame() %>% 
  filter(!str_detect(., "[0-9]")) %>% 
  filter(str_length(.) >= 2) # 형태소 파악을 통해서 


## -------------------- 감정분석 ---------------------------------------

krn = read.csv("/Users/kimjiseong/Downloads/text_word/SentiWord_Dict.txt")
positive = readLines(file("/Users/kimjiseong/Downloads/text_word/pos_pol_word.txt")) %>% 
  .[-c(1:19)]

negative = readLines(file("/Users/kimjiseong/Downloads/text_word/neg_pol_word.txt")) %>% 
  .[-c(1:19)]

pos = SimplePos22(text$text)

pos %>% 
  unlist(.) %>% 
  gsub("[[:alpha:]]", "", .) %>%  # 영어 삭제
  gsub("/", "", .) %>%  # /삭제
  gsub("[+ㄱㄴ]", "", .) -> pos.vec  # +,ㄱ,ㄴ삭제
  

pos.matches.num <- match(pos.vec, positive) # 긍정어 벡터 번호
neg.matches.num <- match(pos.vec, negative) # 부정어 벡터 번호 

pos.matches.num ; neg.matches.num

pos.matches <- !is.na(pos.matches.num)
neg.matches <- !is.na(neg.matches.num)

pos.sum = sum(pos.matches)
neg.sum = sum(neg.matches)
pos.sum ; neg.sum

result <- pos.sum - neg.sum

result_score = function(result) {
  case_when(result > 0 ~ "긍정",
            result == 0 ~ "중립",
            result < 0 ~ "부정")
}

result_score(result) 

