CREATE TABLE dim_cities(
	City_id varchar(20) PRIMARY KEY,
	City varchar(50),
	Tier varchar(20)
)

CREATE TABLE dim_repondents(
	Respondent_ID int PRIMARY KEY,
	name varchar(50),
	Age varchar(20),
	Gender varchar(20),
	City_Id varchar(20)
)

CREATE TABLE fact_survey_responses(
	Response_ID int,
	Respondent_ID int,
	Consume_frequency varchar(50),
	Consume_time varchar(50),
	Consume_reason varchar(50),
	Heard_before varchar(50),
	Brand_perception varchar(50),
	General_perception varchar(50),
	Tried_before varchar(50),
	Taste_experience int,
	Reasons_preventing_trying varchar(50),
	Current_brands varchar(50),
	Reasons_for_choosing_brands varchar(50),
	Improvements_desired varchar(50),
	Ingredients_expected varchar(50),
	Health_concerns varchar(50),
	Interest_in_natural_or_organic varchar(50),
	Marketing_channels varchar(50),
	Packaging_preference varchar(50),
	Limited_edition_packaging varchar(50),
	Price_range varchar(50),
	Purchase_location varchar(50),
	Typical_consumption_situations varchar(50)
)

--------------------------------------------------------------
--------------------------------------------------------------

select * from fact_survey_responses

select * from dim_cities

select * from dim_repondents


-- Q Who prefers energy drink more? (male/female/non-binary)
select gender, count(gender) from dim_repondents group by gender order by count(gender) desc


-- Q Which age group prefer energy drinks more?
select age, count(age) from dim_repondents group by age order by count(age) desc


-- Q Which type of marketing reaches the most Youth (15-30)?
select fs.marketing_channels, dr.age, COUNT(age) as reachcnt from fact_survey_responses fs
inner join dim_repondents dr 
on fs.respondent_id = dr.respondent_id
where dr.age = '19-30'
group by fs.marketing_channels, dr.age
order by count(age) desc


-- Q What are the preferred ingredients of energy drinks among respondents?
select fs.ingredients_expected, count(*) from fact_survey_responses fs
group by ingredients_expected
order by count(*) desc


-- Q What packaging preferences do respondents have for energy drinks?
select packaging_preference, count(*) from fact_survey_responses 
group by packaging_preference
order by count(*) desc

-- Q Who are the current market leaders?
select current_brands, count(*) from fact_survey_responses
group by current_brands
order by count(*) desc
limit 5

-- Q What are the primary reasons consumers prefer those brands over ours?
select reasons_for_choosing_brands, count(*) from fact_survey_responses
group by reasons_for_choosing_brands
order by count(*) desc

-- Q  Which marketing channel can be used to reach more customers?
select marketing_channels, count(*) from fact_survey_responses
group by marketing_channels
order by count(*) desc


--- Q How effective are different marketing strategies and channels in reaching our customers?
select marketing_channels, count(*) from fact_survey_responses
group by marketing_channels
order by count(*) desc

-- Q What do people think about our brand? (overall rating)
select current_brands, general_perception, count(*) from fact_survey_responses
group by general_perception, current_brands
order by count(*) desc

-----------------------------------------------
select current_brands, general_perception,
COUNT(*) OVER(PARTITION BY current_brands) as cnt
from fact_survey_responses
group by current_brands, general_perception
order by cnt desc
------------------------------------------------


-- Q Which cities do we need to focus more on?
SELECT d.City, COUNT(*) AS ResponseCount, d.Tier
FROM dim_cities d
JOIN dim_repondents r ON d.City_ID = r.City_ID
GROUP BY d.City, Tier
ORDER BY ResponseCount desc;


-- Q Where do respondents prefer to purchase energy drinks?
select Purchase_location, count(*) as purch_cnt from fact_survey_responses
group by Purchase_location
order by purch_cnt desc


-- Q What are the typical consumption situations for energy drinks among respondents?
select Typical_consumption_situations, count(*) as cnt from fact_survey_responses
group by Typical_consumption_situations
order by cnt desc

-----------------------------------------------------------------
select Consume_time, count(*) as cnt from fact_survey_responses
group by Consume_time
order by cnt desc
------------------------------------------------------------------


-- Q What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
select Limited_edition_packaging, count(*) as Survey_answer
from fact_survey_responses
group by Limited_edition_packaging
order by Survey_answer desc;

select Price_range, count(*) as desired_price
from fact_survey_responses
group by Price_range
order by desired_price desc;


-- Q Which area of business should we focus more on our product development? (Branding/taste/availability)
select Reasons_for_choosing_brands, count(*) from fact_survey_responses
group by Reasons_for_choosing_brands
order by count(*) desc




