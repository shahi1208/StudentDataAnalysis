-- no of students per degree
select degree,count(student_branch) as no_of_students
from cleandata 
group by 1
order by 2 desc;

-- students in each department
select degree, student_branch, count(student_branch) ppl_per_dept
from cleandata
group by 1,2 order by 3 desc;

-- count of students in religion
select religion,count(*) as religion_count
from cleandata
where religion is not null and religion !~* 'chennai'
group by 1

-- count of students in each department seperated by religion
select student_branch,religion,count(religion) as student_religion_count
from cleandata
where religion is not null and religion !~* 'chennai'
group by 1,2 
order by 1,3 desc;

-- ranking based on no of students in each religion partition by dept
select student_branch,religion,count(religion) as cn_rlgn, rank() over (partition by student_branch order by count(religion) desc) as rank
from cleandata
--where religion is not null and  student_branch = 'COMPUTER SCIENCE'
group by 1,2
order by 1,4;

-- no of students in each community
select community,count(*) as community_count
from cleandata 
where community is not null
group by 1
order by 2 desc;

-- no of students in each community ordered by department
select student_branch,community, count(community) as student_community_count
from cleandata 
where community is not null
group by 1,2
order by 1,3 desc;

-- no of students that belong to same religion and community
select religion,community,count(community)as religion_community_count --, dense_rank() over (partition by religion order by count(community) desc)
from cleandata
where religion is not null and community is not null and religion !~* 'chennai'
group by 1,2
order by 1,3 desc;


-- no of students in each department that belong to the same religion and community
select student_branch,religion,community,count(community) as student_religion_community_count
from cleandata
where religion is not null and community is not null 
group by 1,2,3
order by 1,4 desc; 



-- no of first generation students based on each department
select student_branch,first_gen_learner,count(first_gen_learner)
from cleandata
where first_gen_learner is not null
group by 1,2
order by 1,2 desc;

-- no of first generation students based on religion
select religion,first_gen_learner,count(first_gen_learner)
from cleandata
where first_gen_learner is not null and religion !~* 'chennai'
group by 1,2
order by 2 desc;

-- average father annual income per department
select student_branch,avg(father_income) as avg_income,rank() over (order by avg(father_income) desc) as rank
from cleandata 
group by 1 

-- no of students that took the same course in 12th grade
select course,count(*)
from cleandata
where course is not NULL
group by 1 order by 2 desc;

-- no of students that took specific course in each dept
select degree,student_branch,course,count(course) as course_count
from cleandata
where course is not NULL
group by 1,2,3 order by 1,3,4 desc;

-- no of students in each dept per board
select board,student_branch,count(board) as students_per_board
from cleandata
where board is not null and board not like '0'
group by 1,2 
order by 3 desc;