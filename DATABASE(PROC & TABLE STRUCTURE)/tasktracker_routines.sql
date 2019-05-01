-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tasktracker
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'tasktracker'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteSpecificTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`skip-grants user`@`skip-grants host` PROCEDURE `deleteSpecificTask`(IN task_id_i int)
BEGIN

DECLARE i_parent_id int;


DECLARE EXIT HANDLER FOR 1051 
SELECT 'Please create table abc first' AS test;
if(select 1 from tasktracker.task where task_id=task_id_i) then

set i_parent_id=(select parent_id
from tasktracker.parent_task pt
where parent_task_id=task_id_i);

if(select 1 from tasktracker.task where parent_id=i_parent_id) then

select "this task cant be deleted";



else
delete from tasktracker.task
where task_id=task_id_i;
SELECT t.task_id,t.parent_id,t.task,t.start_date,t.end_date,t.priority,t.finished,pt.parent_task FROM task t 
left join parent_task pt on pt.parent_id=t.parent_id
left join tasktracker.task t1
on t1.task_id=pt.parent_task_id limit 1;
end if;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `finishTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`skip-grants user`@`skip-grants host` PROCEDURE `finishTask`(In task_id_i varchar(10))
BEGIN
update tasktracker.task
set finished='Y'
where task_id=task_id_i;
SELECT t.task_id,t.parent_id,t.task,t.start_date,t.end_date,t.priority,t.finished,pt.parent_task FROM task t 
left join parent_task pt on pt.parent_id=t.parent_id
left join tasktracker.task t1
on t1.task_id=pt.parent_task_id LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertSpecificTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`skip-grants user`@`skip-grants host` PROCEDURE `insertSpecificTask`(IN task_i varchar(100),IN start_date_i date,
IN end_date_i date,IN priority_i int,IN parent_task_i varchar(100))
BEGIN
  
  DECLARE i_parent_id INT default NULL;
  DECLARE i_parent_task_id INT default 0;
  
if(parent_task_i = "") then
insert into tasktracker.task(task,start_date,end_date,priority)
values(task_i,start_date_i,end_date_i,priority_i);
else
set i_parent_task_id=(select task_id 
from tasktracker.task
where upper(task)=upper(parent_task_i));


if (i_parent_task_id is NOT NULL) then
set i_parent_id=(select parent_id
from tasktracker.parent_task
where parent_task_id=i_parent_task_id);

if (i_parent_id is NULL) then
insert tasktracker.parent_task(parent_task,parent_task_id)
values(parent_task_i,i_parent_task_id);
set i_parent_id=LAST_INSERT_ID();

insert tasktracker.task(task,parent_id,start_date,end_date,priority)
values(task_i,i_parent_id,start_date_i,end_date_i,priority_i);else
insert tasktracker.task(task,parent_id,start_date,end_date,priority)
values(task_i,i_parent_id,start_date_i,end_date_i,priority_i);

end if;
end if;

end if;
SELECT t.task_id,t.parent_id,t.task,t.start_date,t.end_date,t.priority,t.finished,pt.parent_task FROM task t 
left join parent_task pt on t.parent_id=pt.parent_id LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `taskDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`skip-grants user`@`skip-grants host` PROCEDURE `taskDetails`()
BEGIN
SELECT t.task_id,t.parent_id,t.task,t.start_date,t.end_date,t.priority,t.finished,pt.parent_task FROM task t 
left join parent_task pt on pt.parent_id=t.parent_id
left join tasktracker.task t1
on t1.task_id=pt.parent_task_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `taskSpecificDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`skip-grants user`@`skip-grants host` PROCEDURE `taskSpecificDetails`(IN task_id_i int)
BEGIN

SELECT t.task_id,t.parent_id,t.task,t.start_date,t.end_date,t.priority,t.finished,pt.parent_task FROM task t 
left join parent_task pt 
on pt.parent_id=t.parent_id
 where t.task_id=task_id_i;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateSpecificTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`skip-grants user`@`skip-grants host` PROCEDURE `updateSpecificTask`(IN  task_id_i int, IN task_i varchar(100),IN start_date_i varchar(100),
IN end_date_i varchar(100),IN priority_i int,IN parent_task_i varchar(100))
BEGIN
  
  DECLARE i_parent_id INT default NULL;
  DECLARE i_parent_task_id INT default 0;
  
if(parent_task_i is null) then
update tasktracker.task
set task=task_i,
start_date=start_date_i,
end_date=end_date_i,
priority=priority_i
where task_id=task_id_i;

else
set i_parent_task_id=(select task_id 
from tasktracker.task
where upper(task)=upper(parent_task_i));


if (i_parent_task_id is NOT NULL) then
set i_parent_id=(select parent_id
from tasktracker.parent_task
where parent_task_id=i_parent_task_id);

if (i_parent_id is NULL) then
insert tasktracker.parent_task(parent_task,parent_task_id)
values(parent_task_i,i_parent_task_id);
set i_parent_id=LAST_INSERT_ID();

update tasktracker.task
set task=task_i,
parent_id=i_parent_id,
start_date=start_date_i,
end_date=end_date_i,
priority=priority_i  
where task_id=task_id_i;

else

update tasktracker.task
set task=task_i,
parent_id=i_parent_id,
start_date=start_date_i,
end_date=end_date_i,
priority=priority_i  
where task_id=task_id_i;

end if;
end if;

end if;
SELECT t.task_id,t.parent_id,t.task,t.start_date,t.end_date,t.priority,t.finished,pt.parent_task FROM task t 
left join parent_task pt on t.parent_id=pt.parent_id LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-30 20:24:16
