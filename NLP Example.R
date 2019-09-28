## Ignore this, its just a fancy txt reader
load_glove_embeddings = function(path = 'glove.42B.300d.txt', d = 50){
  col_names <- c("term", paste("d", 1:d, sep = ""))
  dat <- as.data.frame(read_delim(file = path,
                                  delim = " ",
                                  quote = "",
                                  col_names = col_names))
  rownames(dat) = dat$term
  dat = dat[,-1]
  return(dat)
}



### Load The Libraries, Data and Embeddings matrix
library(readr)
library(LilRhino)
data = read_csv('VDifferentData.csv')[,-1]
emb = load_glove_embeddings(d = 300)

# Embedding matrix is too large for github and can be found here: https://nlp.stanford.edu/projects/glove/


# Clean the Data 
cleaned_data = Pretreatment(data$title, stem = F) 
head(cleaned_data)

# Get a list of stopwords
stops = Stopword_Maker(cleaned_data)

# Convert the text into numeric vectors with a handy function I wrote
#Make sure that the embeddings matrix is a data frame
Sentence_Vector = function(Sentences, emb_matrix, dimension, stopwords){
  Vector_puller = function(words, emb_matrix, dimension){
    ret = colMeans(emb_matrix[words,], na.rm = TRUE)[1:dimension]
    if(all(is.na(ret)) == T){
      return(rep(0, dimension))
    }
    return(ret)
  }
  words_list = stringi::stri_extract_all_words(Sentences, simplify = T)
  words_list = words_list[-(words_list %in% stopwords)]
  vecs = Vector_puller(words_list, emb_matrix, dimension)
  return(t(vecs))
}

vec_data = data.frame()
for(i in 1:length(cleaned_data)){
  new_row = Sentence_Vector(cleaned_data[i], emb, 300, stops)
  colnames(new_row) = colnames(vec_data)
  vec_data = rbind(vec_data, new_row)
}

vec_data = cbind(vec_data, data$sub)

## Train a model to distinguish between the data
library(e1071)
fit = svm(`data$sub`~., data = vec_data, cross = 10, type= 'C-classification')
summary(fit)
