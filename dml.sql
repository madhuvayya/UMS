-- query to insert user data into user_info table
INSERT INTO `ums`.`user_info`(`first_name`,`last_name`,`dob`,`gender`,`email`,`country`,`phone_number`,`address`,`user_name`,`password`,`role`,`status`,`creator_user`)
VALUES('Madhu','V','1997-05-06','male','madhu.vayya@gmail.com','India',7684946313,'Hyderabad Telangana','admin','pwd123','admin','active','user');

-- query to insert pages data into pages table 

INSERT INTO `ums`.`pages` (`id`,`page_name`)
VALUES (1,'Dashboard'),
		(2,'Settings'),
        (3,'Users Information'),
        (4,'Web Page 1'),
        (5,'Web Page 2'),
        (6,'Web Page 3');
        
-- query to get the number of users based on countries

select count(*), country from ums.user_info
  group by country
  order by count(*) desc;
  
-- query to find the total number of users

SELECT count(*) FROM ums.user_info;  

-- query to create stored procedure to get page permissions

DELIMITER //

CREATE PROCEDURE GetPermissions(
	IN userId INT, IN pageId INT
)
BEGIN
	SELECT * 
    FROM `ums`.`permissions` 
    WHERE user_id = userId AND page_id = pageId;
END //

DELIMITER ;

CALL GetPermissions(83,2);

-- query to find the percentage of users according based on gender

 select 100 * count(*) / (select count(*) from ums.user_info) 
    from ums.user_info where gender = 'male';
    
-- query to find the percentage of users based on age group

Select count(*) * 100 / (select count(*) from ums.user_info)  
from ums.user_info where year(now())-year(dob) between 18 and 22;  

-- query to find every month number of registration 

SELECT count(*) as users , date_format(creator_stamp,"%b %Y") as monthYear 
FROM user_info 
GROUP BY date_format(creator_stamp,"%m %Y");  

-- queries to update user status when user failed to login for 3 times

UPDATE ums.user_info SET failed_login_attempts = failed_login_attempts + 1 WHERE user_name = ?;

UPDATE ums.user_info SET status = 'inactive' WHERE user_name = ? AND failed_login_attempts = 3;

-- query to update user status as active after successful login

UPDATE ums.user_info SET status = 'active',failed_login_attempts = 0 WHERE id = ?;

-- query to store user log-out time

UPDATE `ums`.`user_log_history`
SET `logout_timestamp` = now()
WHERE `user_id` = ? AND logout_timestamp is null; 

-- query to get the all time registrations according to months

SELECT count(*) as users , date_format(creator_stamp,"%b %Y") as month_year 
FROM user_info 
GROUP BY date_format(creator_stamp,"%m %Y");

-- query to get current year registrations

SELECT count(*) as users , date_format(creator_stamp,"%b") as month 
FROM user_info 
WHERE YEAR(creator_stamp) = YEAR(now())
GROUP BY date_format(creator_stamp,"%b");

-- query to get current month registration data

SELECT count(*) as users , date_format(creator_stamp,"%e") as day 
FROM user_info 
WHERE YEAR(creator_stamp) = YEAR(now())
AND MONTH(creator_stamp) = MONTH(now())
GROUP BY date_format(creator_stamp,"%e"); 
