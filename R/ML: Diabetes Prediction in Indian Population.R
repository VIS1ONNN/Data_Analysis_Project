# Machine Learning for Diabetes Prediction in Indian Population
# Using Caret Library

# Logistic Regression Model ทำนายคำตอบแบบ Classification 

# แต่ก่อนจะสร้างโมเดลเราอยากทราบคร่าวๆว่าอายุมากและน้อยมีผลต่อการเป็นเบาหวานหรือป่าวโดยการทำ abtest เฉลี่ยค่าดูคร่าวๆ

# Step 0 abtest
library(caret)
data("PimaIndiansDiabetes")

PimaIndiansDiabetes %>%
  select(age, diabetes) %>%
  group_by(diabetes) %>%
  summarise(avg_age = mean(age, na.rm =T),
            med = median(age, na.rm = T))
            
# A tibble: 2 × 3
#  diabetes avg_age   med
#  <fct>      <dbl> <dbl>
# 1 neg         31.2    27
# 2 pos         37.1    36
# ผู้ป่วยโรคเบาหวานมีค่าเฉลี่ย, และค่ากลาง ของอายุมากกว่าคนปกติ

# Step 1. Inspect dataset
df <- PimaIndiansDiabetes
sum(complete.cases(df)) ## เช็คว่าทุกโรลถูกเติมข้อมูลจนเต็มมั้ย ถ้าไม่ต้องทำการ Clean Data by na.omit()
nrow(df)

# > sum(complete.cases(df))
# [1] 768
# > nrow(df)
# [1] 768
# ข้อมูลไม่มี Na

# Step 2. Split Data to Train, Test Using Created Function
## Create Function
split_data <- function(data){
  
set.seed(18)
n <- nrow(data)
id <- sample(1:n, size = 0.7*n)
train_data <- data[id,]
test_data <- data[-id,]
return(list(train = train_data,
            test = test_data))

}

## Step 3. Train Data Using Logistic Regression with sampling by cross validation k = 5
prep <- split_data(df)
set.seed(18)

ctrl = trainControl(method = "cv",
                    number = 5)
logit_model <- train(diabetes ~ glucose + pressure,
                     data = prep$train,
                     method = "glm",
                     trControl = ctrl)
#   Accuracy   Kappa    
#  0.7486154  0.3756401

# Step 4. Evaluate ทำการเซฟคำตอบลงไปในตัวแปร p และนำมาเทียบกับ preptest$diabetes ทำการหาค่า mean ของการเปรียบเทียบจากคำตอบ 231 เราตอบถูกไป 170 
p <- predict(logit_model, newdata = prep$test)
mean(p == prep$test$diabetes)

# mean(p == prep$test$diabetes)
# [1] 0.7359307

# คำตอบจากการ train, test ไม่ต่างกันมาก โดย model ข้างต้นนี้ใช้ defualt threshold = 0.5 ครั้งนี้เราจะมาปรับ tune threshold ใหม่

# Step 3 (tuned threshold)
# Train Data Using Logistic Regression with sampling by cross validation k = 5
# Change Answer type by (type = "prob")
logit_model <- train(diabetes ~ . - triceps,
                     data = prep$train,
                     method = "glm",
                     trControl = ctrl)
                     
p2 <- predict(logit_model, newdata = prep$test, type = "prob")
head(p)

# preview answer คำตอบที่ออกมาจะออกมาในรูปแบบของ prop ability แทน
# เราจะทำการแก้ไขคำตอบให้กลับไปเป็น true, false ดังเดิมด้วย function if else

#         neg        pos
# 5  0.1359319 0.86406812
# 6  0.8688967 0.13110326

# ผมจะ focus ที่การเกิด prop แบบ positive หากมากกว่า 0.7 เราจะ assume ว่า row นี้มีผลเป็น positive หรือ เป็นเบาหวานนั้นเอง
p2 <- ifelse(p2$pos > 0.7, "pos", "neg") 

# preview 
head(p2)
# [1] "pos" "neg" "neg" "neg" "neg" "neg"

## Step 4. Evaluate Model by caret: confustion matrix
confusionMatrix(p, prep$test$diabetes, 
                positive = "pos",
                mode = "prec_recall")

#           Reference
# Prediction neg pos
#        neg 125  45
#        pos  16  45

# Accuracy : 0.7359  
# Precision : 0.7377          
# Recall : 0.5000
# F1 : 0.5960 

# ความแม่นยำไม่ต่างกับการใช้ threshold 0.5 

# step 5. Final Model
logit_model$ finalModel

# step 6. Save Model
saveRDS(logit_model,"logistic_reg.RDS")

# bonus ถ้าเราไม่ทราบว่าควรใช้ตัวแปรต้นเป็น column ไหนบ้าง เราสามารถเริ่มจากการใช้ function varImp เพื่อดูค่า Correlation Coefficient ที่ส่งผลต่อตัวแปรตาม (y) ได้ 
logit_model <- train(diabetes ~ .,
                     data = prep$train,
                     method = "glm",
                     trControl = ctrl)
                     
> varImp(logit_model)

# glm variable importance

#         Overall
# glucose   100.00
# mass       77.21
# pregnant   37.29
# pedigree   27.19
# age        22.19
# insulin    17.90
# pressure   17.31
# triceps     0.00

# จากคำตอบตรงนี้เราจะเห็นว่า triceps ไม่ส่งผลกับ pos diabetes อย่างมีนัยยะสำคัญทำให้ตอน train model ผมเลือกที่จะตัดตัวแปรนี้ออกไปครับ



