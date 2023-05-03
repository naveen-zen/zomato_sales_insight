#what is the total amount each customer spent

select a.user_id,sum(b.price) from sales a inner join product b on a.product_id = b.product_id
group by user_id;


#how many days each customer visite zomato

select user_id,count(created_date) from sales group by user_id;

#what was the first product purchased by each customer


select * from 
(select *,rank() over(partition by user_id order by created_date) as rnk from sales) a where rnk = 1;

# what is the most purchased item in menu and how many time it was purchased by each customer

select * from sales;

select  product_id, count(product_id) from sales group by product_id
order by count(product_id) desc limit 1;

select user_id,count(product_id) from sales where product_id = 
(select product_id from sales group by product_id order by count(product_id) desc limit 1)
 group by user_id;

# which item is the most popular for each customer

select * from 
(select *, rank() over(partition by user_id order by cnt desc) rnk from
(select user_id, product_id, count(product_id) cnt from sales group by user_id,product_id)a)b
where rnk = 1

#which item was prachased first by customer after become member

select * from sales

select * from goldeuser_signup


select * from
(select c.*,rank() over(partition by user_id order by created_date) rnk from
(select a.user_id,a.created_date,a.product_id,b.gold_signup_date from sales a inner join 
goldeuser_signup b on a.user_id = b.userid and gold_signup_date >= created_date) c)d where rnk = 1;

#which item was prachased first by customer before thy  become member

select * from 
(select c.*, rank() over(partition by user_id order by created_date desc) as rnk from 
(select a.user_id,a.created_date,a.product_id,b.gold_signup_date from sales a 
inner join goldeuser_signup b on a.user_id = b.userid and created_date <= gold_signup_date) as c) as d
where rnk = 1;


#what is the total orders and anount spent by each customer before they become member


select user_id, count(created_date) as order_purchased, sum(price) as total_amt_spent from 
(select c.*, d.price from
(select a.user_id,a.created_date,a.product_id,b.gold_signup_date from sales a inner join
goldeuser_signup b on a.user_id = b.userid and created_date <= gold_signup_date) c
inner join product as d on c.product_id = d.product_id) e
group by user_id;


#9


select user_id , sum(total_points) * 2.5 as total_cashback from
(select e.* ,amt/points total_points from
(select d.* , case when product_id = 1 then 5 when product_id = 2 then 2 when product_id = 3 then 5
 else 0 end as points from
(select c.user_id,c.product_id,sum(price) as amt from
 (select a.*,b.price from sales a inner join product b on a.product_id = b.product_id) c
 group by user_id,product_id)d)e)f group by user_id;
 
 
select * from
( select * , rank() over(order by total_cashback desc) rnk from
( select product_id , sum(total_points) as total_cashback from
(select e.* ,amt/points total_points from
(select d.* , case when product_id = 1 then 5 when product_id = 2 then 2 when product_id = 3 then 5
 else 0 end as points from
(select c.user_id,c.product_id,sum(price) as amt from
 (select a.*,b.price from sales a inner join product b on a.product_id = b.product_id) c
 group by user_id,product_id)d)e)f group by product_id)g)f where rnk = 1;
 
 
#10

select a.user_id,a.created_date,a.product_id,b.gold_signup_date  from 
sales a inner join goldeuser_signup b on a.user_id = b.userid and created_date >= gold_signup_date;

 select c.*,d.price*0.5 as total_points from
(select a.user_id,a.created_date,a.product_id,b.gold_signup_date  from 
sales a inner join goldeuser_signup b on a.user_id = b.userid and created_date >= gold_signup_date
and created_date <= date_add(b.gold_signup_date,interval 1 year))c inner join product d on d.product_id
= c.product_id;

#11 rnk all transation of the customers

select *,rank() over(partition by user_id order by created_date) rnk from sales


























