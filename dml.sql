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
