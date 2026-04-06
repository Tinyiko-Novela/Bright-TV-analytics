--viewing the first table
SELECT *
FROM projects.default.bright_tv_viewership;

--viewing the second table
SELECT *
FROM projects.default.bright_tv_user_profiles;

-------------------------
--Number of users
--5375 users
-------------------------
SELECT DISTINCT(UserID)
FROM projects.default.bright_tv_user_profiles;

----------------------
--Viwership by gender
--Males-3918
--Females-537
--None-702
--bank-213
----------------------
SELECT Gender,
Count(Gender)
FROM projects.default.bright_tv_user_profiles
GROUP BY Gender;

------------------------
--Number of provinces
--9 provinces, some users didn't enter their data and some entries are blank
-----------------------
SELECT DISTINCT(Province)
FROM projects.default.bright_tv_user_profiles;

------------------------
--Age range
--Min Age-cannot get an accurate answer as there are blanks
--Max Age-114
-----------------------
SELECT MIN(Age) AS youngest,
      MAX(Age) AS oldest
FROM projects.default.bright_tv_user_profiles;

-------------------------
--Number of channels
-- 21 channels
-------------------------
SELECT DISTINCT(Channel2)
FROM projects.default.bright_tv_viewership;

-------------------------------
--Range of the data
--start date-2016/01/01
--end date-2016/01/01
--3 months worth of data
------------------------------
SELECT MIN(date_format(RecordDate2, 'yyyy/MM/dd')) AS start_date,
MAX(date_format(RecordDate2, 'yyyy/MM/dd')) AS end_date
FROM projects.default.bright_tv_viewership;

-------------------------------
--Race
--white	760
--black	1811
--coloured	679
--other	48
--None	1078
--indian_asian	768
-- blank 231
------------------------------
SELECT Race,
COUNT(Race)
FROM projects.default.bright_tv_user_profiles
GROUP BY Race;

-------------------------------------
--Main code
-----------------------------------
SELECT date_format(RecordDate2, 'yyyy/MM/dd') AS watch_date,
Dayname(RecordDate2) AS day_name,
    Monthname(RecordDate2) AS Month_name,
    Dayofmonth(RecordDate2) AS day_of_month,
    date_format(RecordDate2, 'HH:mm') AS viewing_time,
    date_format(`Duration 2`, 'HH:mm:ss') AS viewing_duration,
    COUNT(DISTINCT(UserID)) AS number_of_viewers,
CASE
    WHEN Age =0 THEN 'null'
    WHEN Age BETWEEN 1 AND 17 THEN 'child'
    WHEN Age BETWEEN 18 AND 29 THEN 'young adult'
    WHEN Age BETWEEN 30 AND 64 THEN 'adult'
    WHEN AGE>= 65 THEN 'senior'
END AS age_groups,
CASE
    WHEN date_format(`Duration 2`, 'HH:mm:ss')< '00:10:00' THEN 'Short_viewing_time'
    WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:10:00'  AND '01:00:00' THEN 'decent_viewing_time'
    WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '01:01:01'  AND '04:00:00' THEN 'long_viewing_time'
    ELSE 'Very_long_viewing_time'
END AS viewing_buckets,
CASE
    WHEN  date_format(RecordDate2, 'HH:mm') BETWEEN '06:00' AND '11:59' THEN 'morning'
    WHEN date_format(RecordDate2, 'HH:mm') BETWEEN '12:00' AND '17:59' THEN 'afternoon'
    WHEN date_format(RecordDate2, 'HH:mm') BETWEEN '18:00' AND '23:59' THEN 'night'
    WHEN date_format(RecordDate2, 'HH:mm') BETWEEN '00:00' AND '05:59' THEN 'early morning'
END AS time_buckets,
A.UserID, A.Name,A.Surname,A.Email,A.Gender, A.Race, A.Age, A.Province,A.`Social Media Handle`,
B.UserID0,B.RecordDate2,B.Channel2,B.`Duration 2`, B.userid4
FROM projects.default.bright_tv_user_profiles AS A
LEFT JOIN projects.default.bright_tv_viewership AS B
ON A.UserID=B.UserID0
GROUP BY UserID,`Name`,`Surname`,Email, Gender,Race, Age,Province, `Social Media Handle`,
UserID0,RecordDate2,Channel2,`Duration 2`, userid4,
Dayname(RecordDate2),
    Monthname(RecordDate2),
    Dayofmonth(RecordDate2),
    date_format(RecordDate2, 'HH:mm'),
    date_format(`Duration 2`, 'HH:mm:ss'),
    date_format(RecordDate2, 'yyyy/MM/dd') 
