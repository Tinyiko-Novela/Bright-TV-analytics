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
MAX(date_format(RecordDate2, 'yyyy/MM/dd')) AS end_date,
FROM projects.default.bright_tv_viewership;

-------------------------------
--Range of viewing duration
--shortest time-00:00:00
--Longest time-11:29:28
------------------------------
SELECT MIN(date_format(`Duration 2`, 'HH:mm:ss')) AS shortest_time,
MAX(date_format(`Duration 2`, 'HH:mm:ss') AS longest_time,
FROM projects.default.bright_tv_viewership;


-----------------------------------
--Changing the time from UTC to SAST
-------------------------------------
SELECT RecordDate2,
from_utc_timestamp(RecordDate2, 'Africa/Johannesburg') AS SAST
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

-------------------------------
--Checking for null values
----------------------------
SELECT Province
FROM projects.default.bright_tv_user_profiles
WHERE
--Gender IS NULL
--Race IS NULL
--Age IS NULL
Province IS NULL

-------------------------------------
--Main code
-----------------------------------
--Changing date format
SELECT date_format((from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')), 'yyyy/MM/dd') AS watch_date,
Dayname(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')) AS day_name,
    Monthname(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')) AS Month_name,
    Dayofmonth(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')) AS day_of_month,
    date_format(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg'), 'HH:mm') AS viewing_time,
    date_format(`Duration 2`, 'HH:mm:ss') AS viewing_duration,

--Number of users
    COUNT(DISTINCT(UserID)) AS number_of_viewers,
--Age groups
CASE
    WHEN Age =0 THEN 'null'
    WHEN Age BETWEEN 1 AND 17 THEN 'child'
    WHEN Age BETWEEN 18 AND 29 THEN 'young adult'
    WHEN Age BETWEEN 30 AND 64 THEN 'adult'
    WHEN AGE>= 65 THEN 'senior'
END AS age_groups,
--Viewing buckets
CASE
    WHEN date_format(`Duration 2`, 'HH:mm:ss')< '00:10:00' THEN 'Short_viewing_time'
    WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '00:10:00'  AND '00:59:59' THEN 'decent_viewing_time'
    WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '01:00:00'  AND '03:59:59' THEN 'long_viewing_time'
    WHEN date_format(`Duration 2`, 'HH:mm:ss') BETWEEN '04:00:00'  AND '12:00:00' THEN 'long_viewing_time'
    ELSE 'null'
END AS viewing_buckets,
--Time buckets
CASE
    WHEN  date_format((from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')), 'HH:mm') BETWEEN '06:00' AND '11:59' THEN 'morning'
    WHEN date_format((from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')), 'HH:mm') BETWEEN '12:00' AND '17:59' THEN 'afternoon'
    WHEN date_format((from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')), 'HH:mm') BETWEEN '18:00' AND '23:59' THEN 'night'
    WHEN date_format((from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')), 'HH:mm') BETWEEN '00:00' AND '05:59' THEN 'early morning'
END AS time_buckets,
--Left joining the viewershhip table to users table
B.UserID, B.Gender, B.Race, B.Age, B.Province,B.Name,B.Surname,B.Email,B.`Social Media Handle`,
A.UserID0,A.RecordDate2,A.Channel2,A.`Duration 2`, A.userid4
FROM projects.default. bright_tv_viewership AS A
LEFT JOIN projects.default. bright_tv_user_profiles AS B
ON B.UserID=A.UserID0
GROUP BY UserID, Gender,Race, Age,Province,Name,Surname,Email,`Social Media Handle`,
UserID0,RecordDate2,Channel2,`Duration 2`, userid4,
Dayname(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')),
    Monthname(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')),
    Dayofmonth(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg')),
    date_format(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg'), 'HH:mm'),
    date_format(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg'), 'HH:mm:ss'),
    date_format(from_utc_timestamp(RecordDate2, 'Africa/Johannesburg'), 'yyyy/MM/dd') 
    Dayofmonth(RecordDate2),
    date_format(RecordDate2, 'HH:mm'),
    date_format(`Duration 2`, 'HH:mm:ss'),
    date_format(RecordDate2, 'yyyy/MM/dd') 
