/*
SQLyog Community v13.1.1 (64 bit)
MySQL - 5.6.24 : Database - db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db`;

/*Table structure for table `admins` */

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `AdminID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(32) NOT NULL,
  `Password` char(40) NOT NULL,
  `Role` int(11) NOT NULL,
  PRIMARY KEY (`AdminID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `admins` */

insert  into `admins`(`AdminID`,`Username`,`Password`,`Role`) values 
(1,'root','f8e966d1e207d02c44511a58dccff2f5429e9a3b',1),
(2,'support','f8e966d1e207d02c44511a58dccff2f5429e9a3b',2);

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `MessageID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `AdminID` int(11) DEFAULT NULL,
  `Message` varchar(512) NOT NULL,
  `Response` varchar(512) DEFAULT NULL,
  `Flagged_important` int(11) DEFAULT '0',
  PRIMARY KEY (`MessageID`),
  KEY `UserID` (`UserID`),
  KEY `AdminID` (`AdminID`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`AdminID`) REFERENCES `admins` (`AdminID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `messages` */

insert  into `messages`(`MessageID`,`UserID`,`AdminID`,`Message`,`Response`,`Flagged_important`) values 
(1,1,2,'What is Truth or dare?','Truth or Dare is a perfectly suitable game to play with your family, and unlike a single board game, it will bring many, many hours of laughter and enjoyment! ',1),
(2,1,2,'Can I submit my own questions?','Yes, you can submit your own questions. First you must create an account and log in. Once you are logged in you will be able to see a form on the homepage. Fill in your answers and hit send, then an admin will review your submission. If the submission doesn\'t include any inappropriate content, then it will most likely get approved and added to the question pool of the game.',1),
(3,1,2,'Do you offer any tech support?','Yes, you can contact our tech support via the contact page, however you must be logged in in order to send messages. Our tech support team will reviews all messages and when your message gets answered you will receive an e-mail from us.',1),
(5,1,2,'Can I play the game without using my browser?','No it is impossible. This game was built using react as frontend and node and  backend. So it was made into a website.',1),
(6,3,2,'Is it free to play this game?','yes right',0);

/*Table structure for table `question_pool` */

DROP TABLE IF EXISTS `question_pool`;

CREATE TABLE `question_pool` (
  `QuestionID` int(11) NOT NULL AUTO_INCREMENT,
  `Answer1` varchar(128) NOT NULL,
  `Answer2` varchar(128) NOT NULL,
  PRIMARY KEY (`QuestionID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `question_pool` */

insert  into `question_pool`(`QuestionID`,`Answer1`,`Answer2`) values 
(2,'What actor/actress do you prefer?','I dare you to crack an egg over your head.'),
(3,'Who is your secret crush?','I dare you to attempt to do 10 pushups.'),
(4,'What is the most disgusting thing you\'ve ever done?','I dare you to eat a plate of dessert with no hands.'),
(5,'What is your biggest fear in a relationship?','I dare you to crabwalk across the room.'),
(6,'What was your funniest first date ever?','I dare you to army crawl across the room.'),
(7,'What is your biggest turn off in a partner?','I dare you to make up a poem aloud.');

/*Table structure for table `user_submitted_questions` */

DROP TABLE IF EXISTS `user_submitted_questions`;

CREATE TABLE `user_submitted_questions` (
  `QuestionID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `Answer1` varchar(128) NOT NULL,
  `Answer2` varchar(128) NOT NULL,
  PRIMARY KEY (`QuestionID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `user_submitted_questions_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `user_submitted_questions` */

insert  into `user_submitted_questions`(`QuestionID`,`UserID`,`Answer1`,`Answer2`) values 
(1,3,'can i get the result?','undefined'),
(2,3,'yes or no?','undefined');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(64) NOT NULL,
  `Username` varchar(32) NOT NULL,
  `Password` char(40) NOT NULL,
  `FirstName` varchar(32) DEFAULT NULL,
  `LastName` varchar(32) DEFAULT NULL,
  `Strikes` int(11) DEFAULT '0',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`UserID`,`Email`,`Username`,`Password`,`FirstName`,`LastName`,`Strikes`) values 
(1,'aaaa@aaaa.a','curiosity','f90bc924da413d16138116548868dbf1050cbff7',NULL,NULL,0),
(3,'romancoder204@gmail.com','appleLover','11c01ef933fcb1307ce3299bdd1f52ec951c4071','robbie','stewart',0);

/*Table structure for table `viewed_questions` */

DROP TABLE IF EXISTS `viewed_questions`;

CREATE TABLE `viewed_questions` (
  `UserID` int(11) NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `Selected_answer` int(11) DEFAULT '0',
  `Score` int(11) DEFAULT '0',
  `Reported` int(11) DEFAULT '0',
  KEY `UserID` (`UserID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `viewed_questions_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `viewed_questions_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `question_pool` (`QuestionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `viewed_questions` */

insert  into `viewed_questions`(`UserID`,`QuestionID`,`Selected_answer`,`Score`,`Reported`) values 
(3,2,2,-1,0),
(3,5,2,0,0),
(3,6,2,1,0),
(3,3,2,0,0),
(3,7,2,-1,0),
(3,4,0,0,0);

/* Procedure structure for procedure `add_message` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_message` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_message`(IN user_id integer, IN message varchar(512))
BEGIN
INSERT INTO MESSAGES(UserID, Message)
    VALUES(user_id, message);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `add_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_question`(IN ans1 varchar(128), IN ans2 varchar(128))
BEGIN
    INSERT INTO QUESTION_POOL(Answer1, Answer2)
    VALUES (ans1, ans2);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `add_user_submitted_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_user_submitted_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user_submitted_question`(IN user_id integer, IN ans1 varchar(128), IN ans2 varchar(128))
BEGIN
    INSERT INTO USER_SUBMITTED_QUESTIONS(UserID, Answer1, Answer2)
    VALUES (user_id, ans1, ans2);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `approve_question_report` */

/*!50003 DROP PROCEDURE IF EXISTS  `approve_question_report` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `approve_question_report`(IN question_id integer)
BEGIN
    CALL delete_question(question_id);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `approve_user_submitted_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `approve_user_submitted_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `approve_user_submitted_question`(IN id integer)
BEGIN
 DECLARE ans1 varchar(128);
    DECLARE ans2 varchar(128);
    SELECT Answer1, Answer2
    INTO ans1, ans2
    FROM USER_SUBMITTED_QUESTIONS
    WHERE QuestionID = id;
    DELETE FROM USER_SUBMITTED_QUESTIONS
    WHERE QuestionID = id;
    CALL add_question(ans1, ans2);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_message` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_message` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_message`(IN message_id integer)
BEGIN
    DELETE FROM MESSAGES
    WHERE MessageID = message_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_question`(IN id integer)
BEGIN
    DELETE FROM QUESTION_POOL
    WHERE QuestionID = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_question_report` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_question_report` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_question_report`(IN question_id integer, IN user_id integer)
BEGIN
    UPDATE VIEWED_QUESTIONS
    SET Reported = 0
    WHERE QuestionID = question_id AND UserID = user_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_user_submitted_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_user_submitted_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_submitted_question`(IN id integer)
BEGIN
    DELETE FROM USER_SUBMITTED_QUESTIONS
    WHERE QuestionID = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `email_taken` */

/*!50003 DROP PROCEDURE IF EXISTS  `email_taken` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `email_taken`(IN mail varchar(64))
BEGIN
    SELECT true
    FROM USERS u, ADMINS a
    WHERE u.Email = mail;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `flag_message_important` */

/*!50003 DROP PROCEDURE IF EXISTS  `flag_message_important` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `flag_message_important`(IN message_id integer, IN flag_value integer)
BEGIN
    UPDATE MESSAGES
    SET Flagged_important = flag_value
    WHERE MessageID = message_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_flagged_important_messages` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_flagged_important_messages` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_flagged_important_messages`()
BEGIN
  SELECT m.Message, m.Response
    FROM MESSAGES m
    WHERE m.Response IS NOT NULL AND m.Flagged_important = 1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_message` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_message` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_message`(IN message_id integer)
BEGIN
SELECT u.Email, m.Message
    FROM MESSAGES m, USERS u
    WHERE m.MessageID = message_id AND u.UserID = m.UserID;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_messages` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_messages` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_messages`()
BEGIN
 SELECT m.MessageID, u.Username, m.Message, m.Response, m.Flagged_important
    FROM MESSAGES m, USERS u
    WHERE m.UserID = u.UserID;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_questions_reported_by_users` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_questions_reported_by_users` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_questions_reported_by_users`()
BEGIN
 SELECT v.QuestionID, v.UserID, u.Username, p.Answer1, p.Answer2
    FROM QUESTION_POOL p, VIEWED_QUESTIONS v, USERS u
    WHERE p.QuestionID = v.QuestionID AND v.Reported = 1 AND u.UserID = v.UserID;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_question_stats` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_question_stats` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_question_stats`(IN question_id integer)
BEGIN
 SELECT (
        SELECT COUNT(*)
        FROM VIEWED_QUESTIONS
        WHERE Selected_answer = 1 AND QuestionID = question_id
    ) AS Ans1Count, (
        SELECT COUNT(*)
        FROM VIEWED_QUESTIONS
        WHERE Selected_answer = 2  AND QuestionID = question_id
    ) AS Ans2Count;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_random_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_random_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_random_question`()
BEGIN
    SELECT QuestionID, Answer1, Answer2
    FROM QUESTION_POOL
    ORDER BY RAND()
    LIMIT 1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_random_question_for_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_random_question_for_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_random_question_for_user`(IN user_id integer)
BEGIN
 SELECT QuestionID, Answer1, Answer2
    FROM QUESTION_POOL
    WHERE QuestionID NOT IN (
            SELECT QuestionID
            FROM VIEWED_QUESTIONS
            WHERE UserID = user_id
        )
    ORDER BY RAND()
    LIMIT 1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_unanswered_messages` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_unanswered_messages` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_unanswered_messages`()
BEGIN
SELECT m.MessageID, u.Username, m.Message
    FROM MESSAGES m, USERS u
    WHERE Response IS NULL AND m.UserID = u.UserID;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user_messages_no_response` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user_messages_no_response` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_messages_no_response`(IN id integer)
BEGIN
SELECT m.Message
    FROM MESSAGES m
    WHERE m.UserID = id AND m.Response IS NULL;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user_messages_with_response` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user_messages_with_response` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_messages_with_response`(IN id integer)
BEGIN
    SELECT m.Message, a.Username, m.Response
    FROM MESSAGES m, ADMINS a
    WHERE m.AdminID = a.AdminID AND m.UserID = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user_submitted_questions` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user_submitted_questions` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_submitted_questions`()
BEGIN
  SELECT q.QuestionID, u.Username, q.Answer1, q.Answer2
    FROM USER_SUBMITTED_QUESTIONS q, USERS u
    WHERE q.UserID = u.UserID;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `login_admin` */

/*!50003 DROP PROCEDURE IF EXISTS  `login_admin` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `login_admin`(IN uname varchar(64), IN pword char(40))
BEGIN
    SELECT AdminID, Username, Password, Role
    FROM ADMINS
    WHERE Username = uname AND Password = pword;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `login_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `login_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `login_user`(IN uname varchar(64), IN pword char(40))
BEGIN
    SELECT UserID, Username, Password, Email
    FROM USERS
    WHERE (Username = uname OR Email = uname) AND Password = pword;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `register_admin` */

/*!50003 DROP PROCEDURE IF EXISTS  `register_admin` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `register_admin`(IN uname varchar(32), IN pword char(40), IN role integer)
BEGIN
    INSERT INTO ADMINS(Username, Password, Role)
    VALUES (uname, pword, role);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `register_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `register_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user`(IN uname varchar(32), IN pword char(40), IN email varchar(64),
    IN first_name varchar(32), IN last_name varchar(32))
BEGIN
   INSERT INTO USERS(Username, Password, Email, FirstName, LastName)
    VALUES (uname, pword, email, first_name, last_name);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `report_message_author` */

/*!50003 DROP PROCEDURE IF EXISTS  `report_message_author` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `report_message_author`(IN message_id integer)
BEGIN
 DECLARE user_id integer;
    SELECT UserID INTO user_id
    FROM MESSAGES
    WHERE MessageID = message_id;
    DELETE FROM MESSAGES
    WHERE MessageID = message_id;
    CALL strike_user(user_id);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `report_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `report_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `report_question`(IN user_id integer, IN question_id integer, IN report_value integer)
BEGIN
UPDATE VIEWED_QUESTIONS
    SET Reported = report_value
    WHERE UserID = user_id AND QuestionID = question_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `report_user_submitted_question_author` */

/*!50003 DROP PROCEDURE IF EXISTS  `report_user_submitted_question_author` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `report_user_submitted_question_author`(IN question_id integer)
BEGIN
    DECLARE user_id integer;
    SELECT UserID INTO user_id
    FROM USER_SUBMITTED_QUESTIONS
    WHERE QuestionID = question_id;
    DELETE FROM USER_SUBMITTED_QUESTIONS
    WHERE QuestionID = question_id;
    CALL strike_user(user_id);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `respond_to_message` */

/*!50003 DROP PROCEDURE IF EXISTS  `respond_to_message` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `respond_to_message`(IN message_id integer, IN admin_id integer, IN response varchar(512))
BEGIN
 UPDATE MESSAGES
    SET Response = response, AdminID = admin_id
    WHERE MessageID = message_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `score_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `score_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `score_question`(IN user_id integer, IN question_id integer, IN score_value integer)
BEGIN
 UPDATE VIEWED_QUESTIONS
    SET Score = score_value
    WHERE UserID = user_id AND QuestionID = question_id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `select_answer` */

/*!50003 DROP PROCEDURE IF EXISTS  `select_answer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `select_answer`(IN user_id integer, IN question_ID integer, IN answer integer)
BEGIN
UPDATE VIEWED_QUESTIONS
    SET Selected_answer = answer
    WHERE UserID = user_id AND QuestionID = question_id AND Selected_answer = 0;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `strike_question_report_author` */

/*!50003 DROP PROCEDURE IF EXISTS  `strike_question_report_author` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `strike_question_report_author`(IN question_id integer, IN user_id integer)
BEGIN
  UPDATE VIEWED_QUESTIONS
    SET Reported = 0
    WHERE QuestionID = question_id;
    CALL strike_user(user_id);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `strike_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `strike_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `strike_user`(IN user_id integer)
BEGIN
    DECLARE old_strikes integer;
    SELECT Strikes INTO old_strikes
    FROM USERS
    WHERE UserID = user_id;
    IF (old_strikes = 2) THEN
        DELETE FROM USERS
        WHERE UserID = user_id;
    ELSE
        UPDATE USERS
        SET Strikes = old_strikes + 1
        WHERE UserID = user_id;
    END IF;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `username_taken` */

/*!50003 DROP PROCEDURE IF EXISTS  `username_taken` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `username_taken`(IN uname varchar(32))
BEGIN
    SELECT true
    FROM USERS u, ADMINS a
    WHERE u.Username = uname OR a.Username = uname;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `view_question` */

/*!50003 DROP PROCEDURE IF EXISTS  `view_question` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `view_question`(IN user_id integer, IN question_id integer)
BEGIN
    INSERT INTO VIEWED_QUESTIONS(UserID, QuestionID)
    VALUES (user_id, question_id);
	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
