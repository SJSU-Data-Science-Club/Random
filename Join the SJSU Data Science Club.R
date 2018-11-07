library(readr)


Join_The_SJSU_Data_Science_Club = paste("V", seq(1, 256), sep = "")
Join_The_SJSU_Data_Science_Club <- c(Join_The_SJSU_Data_Science_Club, "label")

train_0 <- read_csv("~/Downloads/digits/train.0.txt", 
                    col_names = FALSE)
train_1 <- read_csv("~/Downloads/digits/train.1.txt", 
                    col_names = FALSE)
train_2 <- read_csv("~/Downloads/digits/train.2.txt", 
                    col_names = FALSE)
train_3 <- read_csv("~/Downloads/digits/train.3.txt", 
                    col_names = FALSE)
train_4 <- read_csv("~/Downloads/digits/train.4.txt", 
                    col_names = FALSE)
train_5 <- read_csv("~/Downloads/digits/train.5.txt", 
                    col_names = FALSE)
train_6 <- read_csv("~/Downloads/digits/train.6.txt", 
                    col_names = FALSE)
train_7 <- read_csv("~/Downloads/digits/train.7.txt", 
                    col_names = FALSE)
train_8 <- read_csv("~/Downloads/digits/train.8.txt", 
                    col_names = FALSE)
train_9 <- read_csv("~/Downloads/digits/train.9.txt", 
                    col_names = FALSE)

train_0 <- cbind(train_0, 0)
colnames(train_0) <- Join_The_SJSU_Data_Science_Club

train_1 <- cbind(train_1, 1)
colnames(train_1) <- Join_The_SJSU_Data_Science_Club

train_2 <- cbind(train_2, 2)
colnames(train_2) <- Join_The_SJSU_Data_Science_Club

train_3 <- cbind(train_3, 3)
colnames(train_3) <- Join_The_SJSU_Data_Science_Club

train_4 <- cbind(train_4, 4)
colnames(train_4) <- Join_The_SJSU_Data_Science_Club

train_5 <- cbind(train_5, 5)
colnames(train_5) <- Join_The_SJSU_Data_Science_Club

train_6 <- cbind(train_6, 6)
colnames(train_6) <- Join_The_SJSU_Data_Science_Club

train_7 <- cbind(train_7, 7)
colnames(train_7) <- Join_The_SJSU_Data_Science_Club

train_8 <- cbind(train_8, 8)
colnames(train_8) <- Join_The_SJSU_Data_Science_Club

train_9 <- cbind(train_9, 9)
colnames(train_9) <- Join_The_SJSU_Data_Science_Club

train <- rbind(train_0, train_1, train_2, train_3, train_4, train_5, train_6, train_7, train_8, train_9)

which(apply(train, c(1, 2), is.na) == T, arr.ind = T)
#Looks like row 1114 is bad

train <- train[,-c(1, 32)]

colnames(train) <- c(paste("V", seq(1, 254), sep = ""), "Label")

write_csv(train, "Join_The_SJSU_Data_Science_Club.csv")



