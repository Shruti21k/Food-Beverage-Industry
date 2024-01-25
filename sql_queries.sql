create database food_bev;
use food_bev;

show databases;
show tables;

select * from dim_cities;
select * from dim_repondents;
select * from fact_survey_responses;

##################################### 1. Demographic Insights ################################
# a. Who prefers energy drink more? (male/female/non-binary)
SELECT Gender, COUNT(respondent_ID) as Numer_of_respondents
FROM dim_repondents
GROUP BY Gender
ORDER BY Numer_of_respondents desc;
-- The largest consumer segment is comprised of males.


# b. Which age group prefers energy drinks more?
SELECT 
    Age, COUNT(*) AS Age_grp_Preference
FROM
    dim_repondents
GROUP BY Age
ORDER BY Age_grp_Preference DESC;
-- The primary target demographic is individuals within the age group of 19-30 years old.


# c. Which type of marketing reaches the most Youth (15-30)?
SELECT 
    Marketing_channels,
    COUNT(Marketing_channels) AS Marketing_count
FROM
    fact_survey_responses
WHERE
    Respondent_ID IN (SELECT 
            Respondent_ID
        FROM
            dim_repondents
        WHERE
            Age = '15-18' OR Age = '19-30')
GROUP BY Marketing_channels
ORDER BY Marketing_count DESC;

-- alternate way
SELECT
    fsr.Marketing_channels,
    COUNT(fsr.Marketing_channels) AS Marketing_count
FROM
    fact_survey_responses fsr
JOIN
    dim_repondents dr ON fsr.Respondent_ID = dr.Respondent_ID
WHERE
    dr.Age IN ('15-18', '19-30')
GROUP BY
    fsr.Marketing_channels
ORDER BY
    Marketing_count DESC;
-- Online advertising is the most effective channel for reaching the youth demographic.


##################################### 2. Consumer Preferences ################################
# a. What are the preferred ingredients of energy drinks among respondents?
SELECT 
    Ingredients_expected AS Ingredients,
    COUNT(*) AS preferred_ingredient
FROM
    fact_survey_responses
GROUP BY Ingredients_expected
ORDER BY preferred_ingredient DESC;
-- Caffeine stands out as the most sought-after and widely favored ingredient among the customers


# b. What packaging preferences do respondents have for energy drinks?
SELECT 
    Packaging_preference AS Packagings,
    COUNT(*) AS Total_preferred_package
FROM
    fact_survey_responses
GROUP BY Packaging_preference
ORDER BY Total_preferred_package DESC;
-- Compact and portable cans are identified as the most convenient and sought-after packaging style.


##################################### 3. Competition Analysis ################################
# a. Who are the current market leaders?
SELECT 
    Current_brands AS Brands, COUNT(*) AS Market_leaders
FROM
    fact_survey_responses
GROUP BY Brands
ORDER BY market_leaders DESC;
-- Cola Coka holds a leading position in the market. Despite being in its initial stages, CodeX has quickly emerged as one of the top-selling products.


# b. What are the primary reasons consumers prefer those brands over ours?
SELECT 
    Reasons_for_choosing_brands AS Reason,
    COUNT(*) AS Preference_count
FROM
    fact_survey_responses
GROUP BY Reasons_for_choosing_brands
ORDER BY Preference_count DESC;
-- Cola Coka boasts a substantial brand reputation, a key factor contributing to their customer retention success.


##################################### 4. Marketing Channels and Brand Awareness ################################
# a. Which marketing channel can be used to reach more customers?
SELECT 
    Marketing_channels, COUNT(*) AS Response_count
FROM
    fact_survey_responses
GROUP BY Marketing_channels
ORDER BY Response_count DESC;


# b. How effective are different marketing strategies and channels in reaching our customers?
SELECT 
    Marketing_channels, COUNT(*) AS Total_Responses
FROM
    fact_survey_responses
WHERE
    Current_brands = 'CodeX'
GROUP BY Marketing_channels
ORDER BY Total_Responses DESC;
-- Online ads lead with 411 responses, followed by TV commercials, outdoor billboards, other channels, and print media, indicating their respective effectiveness in reaching 'CodeX' customers.


##################################### 5. Brand Penetration ################################
# a. What do people think about our brand? (overall rating)
SELECT 
    Brand_perception, COUNT(*) AS Brand_rating
FROM
    fact_survey_responses
WHERE
    Heard_before = 'Yes'
GROUP BY Brand_perception
ORDER BY Brand_rating DESC; 
-- Customers with prior experience tend to hold a predominantly neutral or positive perception of the drink.

SELECT 
    Taste_experience, COUNT(*) AS Taste_rating
FROM
    fact_survey_responses
GROUP BY Taste_experience
ORDER BY Taste_rating DESC;

# b. Which cities do we need to focus more on?
SELECT
    dc.City,
    dc.Tier,
    COUNT(dr.Respondent_ID) AS Response_Count,
    ROUND(((COUNT(dr.Respondent_ID) / (SELECT COUNT(*) FROM fact_survey_responses)) * 100),1) AS Response_Percentage
FROM
    dim_cities dc
JOIN
    dim_repondents dr ON dc.City_ID = dr.City_ID
GROUP BY
    dc.City, dc.Tier
ORDER BY
    Response_Count;  
-- Tier 2 cities, especially Lucknow and Jaipur, require focused attention based on the survey responses.


##################################### 6. Purchase Behavior ################################
# a. Where do respondents prefer to purchase energy drinks?
SELECT 
    Purchase_location, COUNT(*) AS prefer_purchase_location
FROM
    fact_survey_responses
GROUP BY Purchase_location
ORDER BY prefer_purchase_location DESC;
-- Customers predominantly prefer purchasing the product at supermarkets.


# b. What are the typical consumption situations for energy drinks among respondents?
SELECT 
    Typical_consumption_situations, COUNT(*) AS frequency
FROM
    fact_survey_responses
GROUP BY Typical_consumption_situations
ORDER BY frequency DESC;

# c. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
SELECT 
    Limited_edition_packaging, COUNT(*) AS Survey_answer
FROM
    fact_survey_responses
GROUP BY Limited_edition_packaging
ORDER BY Survey_answer DESC;

SELECT 
    Price_range, COUNT(*) AS desired_price
FROM
    fact_survey_responses
GROUP BY Price_range
ORDER BY desired_price DESC;
-- Customers express a preference for the drink within the price range of 50-100, irrespective of packaging being limited edition or not.


##################################### 7. Product Development ################################
# a. Which area of business should we focus more on our product development? (Branding/taste/availability)
SELECT 
    Reasons_for_choosing_brands, COUNT(*) AS counts
FROM
    fact_survey_responses
GROUP BY Reasons_for_choosing_brands
ORDER BY counts DESC;
-- Prioritizing brand reputation is essential, followed by taste and availability considerations.











#Query 16 (Secondary Questions)
# best consuption time?
select Consume_time as reasons, count(*) as total
from fact_survey_responses
group by consume_time
order by total desc;

#Query 17
#Major cosume reason?
select Consume_reason as benefits, count(*) as total
from fact_survey_responses
group by Consume_reason
order by total desc;

#Query 18
#Reason from preventing our brand
select Reasons_preventing_trying, count(*) as total
from fact_survey_responses
group by Reasons_preventing_trying
order by total desc;


#Query 19
# Improvment desired in our brand
select Improvements_desired, count(*) as total
from fact_survey_responses
group by Improvements_desired
order by total desc;


#Query 20
# people intrest in organic?
select Interest_in_natural_or_organic, count(*) as total
from fact_survey_responses
group by Interest_in_natural_or_organic
order by total desc;


#Query 21
# people heard before
select Heard_before, count(*) as total
from fact_survey_responses
group by Heard_before
order by total desc;


#Query 22
# Tried_before
select Tried_before, count(*) as total
from fact_survey_responses
group by Tried_before
order by total desc;
