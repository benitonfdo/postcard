drop user if exists postcard;
CREATE USER 'postcard'@'%' IDENTIFIED BY 'Alten@123';
GRANT ALL PRIVILEGES ON *.* TO 'postcard'@'%' ;

CREATE TABLE `postcard`.`PROPERTIES` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100),
    `value` VARCHAR(300),
    PRIMARY KEY (`id`)
);

CREATE TABLE `postcard`.`postcard` (
  `orderId` int(11) DEFAULT NULL,
  `cardId` int(11) NOT NULL AUTO_INCREMENT,
  `cardKey` varchar(45) DEFAULT NULL,
  `attempts` int(11) DEFAULT NULL,
  `recipientJson` text DEFAULT NULL,
  `submissionStatus` varchar(45) DEFAULT NULL,
  `response` varchar(45) DEFAULT NULL,
  `cardStatus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cardId`),
CONSTRAINT order_idfk_1 FOREIGN KEY (`orderId`) REFERENCES `postcard`.`postcardorder` (`orderId`));
);

CREATE TABLE `postcard`.`postcardorder` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT,
   `imageId` int(11) NOT NULL,
  `senderJson` text DEFAULT NULL,
  `senderText` varchar(500) DEFAULT NULL,
  `brandingText` varchar(500) DEFAULT NULL,
  `brandingJson` text DEFAULT NULL,
  PRIMARY KEY (`orderId`),
CONSTRAINT image_idfk_1 FOREIGN KEY (`imageId`) REFERENCES `postcard`.`image` (`imageId`));	
);

CREATE TABLE `postcard`.`image` (
  `imageId` int(11) NOT NULL AUTO_INCREMENT,
  `image` longblob DEFAULT NULL,
  `imageType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`image_id`)
); 

CREATE TABLE `postcard`.`user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(250) NOT NULL,
  `role` varchar(45) NOT NULL,
  `userName` varchar(45) NOT NULL,
  PRIMARY KEY (`userId`)
);

CREATE TABLE `postcard`.`VALIDATION_CONFIGURATION` (
    `id` int(11) not null  AUTO_INCREMENT ,
    `key` varchar(50) not null,
    `configuration` text not null,
    primary key (`id`)
);

INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('enable-swagger','Y');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('authURL','https://apiint.post.ch/OAuth/authorization');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('accessTokenURL','https://apiint.post.ch/OAuth/token');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('clientID','3ff6558b0da85758e9d36fdd2092cc19');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('clientSecret','3552aa3d6dcb17e93353943758b6d63f');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('scope','PCCAPI');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('postcardAPI','api/v1/postcards/');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('campaignKey','0b6eee81-5ea3-475a-975b-0318335eb228');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('createPostcardEndPoint','api/v1/postcards?campaignKey=');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('campaignsEndPoint','api/v1/campaigns/');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('statisticEndpoint','/statistic');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('postcardBaseURL','https://apiint.post.ch/pcc/');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('stateEndPoint','/state');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('approvalEndPoint','/approval');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('senderAddressEndPoint','/addresses/sender');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('recipientAddressEndPoint','/addresses/recipient');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('frontImageEndPoint','/image');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('senderTextEndPoint','/sendertext?senderText=');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('brandingTextEndPoint','/branding/text');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('frontPreviewsEndPoint','/previews/front');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('backPreviewsEndPoint','/previews/back');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('brandingImageEndPoint','/branding/image');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('stampImageEndPoint','/stamp/image');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('getUserQuery','select * from user where userName=?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('jwt.secret','AltenCalsoftLabs');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('updateProperty','update PROPERTIES set value=? where name =?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('getValidationConfiguration','select `configuration` from VALIDATION_CONFIGURATION where `key`=?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('createPostcardOrderQuery','insert into postcardorder(senderText,senderJson,brandingText,brandingJson) values (?,?,?,?)');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('updatePostcardOrderQuery','update postcardorder set senderText =? ,senderJson=? ,brandingText=?,brandingJson=? where orderId = ?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('findOnePostcardOrderQuery','SELECT * FROM postcardorder WHERE orderId = ?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('findallPostcardOrderQuery','select * from postcardorder');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('deletePostcardOrderQuery','delete from postcardorder where orderId = ?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('createPostcardQuery','insert into postcard(orderId,cardKey,recipientJson,submissionStatus,response,attempts,cardStatus) values (?,?,?,?,?,?,?)');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('updatePostcardQuery','update postcard set recipientJson =? ,submissionStatus=? ,response=?,attempts=?,cardStatus=? where cardKey = ?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('findallPostcardQuery','select * from postcard');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('deletePostcardQuery','delete from Postcard where cardId = ?');
INSERT INTO `postcard`.`PROPERTIES` (`name`,`value`) VALUES ('findOnePostcardQuery','SELECT * FROM Postcard WHERE cardId = ?');

insert into `postcard`.`user`(`userName`,`password`,`role`)values('alten','$2a$10$ixlPY3AAd4ty1l6E2IsQ9OFZi2ba9ZQE0bP7RFcGIWNhyFrrT3YUi','ROLE_USER');
insert into `postcard`.`user`(`userName`,`password`,`role`)values('admin','$2a$10$ixlPY3AAd4ty1l6E2IsQ9OFZi2ba9ZQE0bP7RFcGIWNhyFrrT3YUi','ROLE_ADMIN');

insert into `postcard`.`VALIDATION_CONFIGURATION`(`key`,`configuration`)values('recipientAddress','{"title":{"validations":[{"type":"MANDATORY","message":"Title is mandatory"},{"type":"MAX_LENGTH","value":30,"message":"Title maximum length allowed is 30"}]},"lastname":{"validations":[{"type":"MANDATORY","message":"Last name is mandatory"},{"type":"MAX_LENGTH","value":75,"message":"Last name maximum length allowed is 75"}]},"firstname":{"validations":[{"type":"MANDATORY","message":"First name is mandatory"},{"type":"MAX_LENGTH","value":75,"message":"First name maximum length allowed is 75"}]},"company":{"validations":[{"type":"MANDATORY","message":"Company name is mandatory"},{"type":"MAX_LENGTH","value":100,"message":"Company name maximum length allowed is 100"}]},
"street":{"validations":[{"type":"NOT MANDATORY","message":"street is not mandatory"},{"type":"MAX_LENGTH","value":60,"message":"Street maximum length allowed is 60"}]},
"houseNr":{"validations":[{"type":"NOT MANDATORY","message":"houseNr is not mandatory"},{"type":"MAX_LENGTH","value":10,"message":"houseNr maximum length allowed is 10"}]},
"zip":{"validations":[{"type":"NOT MANDATORY","message":"zip is not mandatory"},{"type":"MAX_LENGTH","value":6,"message":"zip maximum length allowed is 6"}]},
"city":{"validations":[{"type":"NOT MANDATORY","message":"city is not mandatory"},{"type":"MAX_LENGTH","value":39,"message":"city maximum length allowed is 39"}]},
"country":{"validations":[{"type":"NOT MANDATORY","message":"country is not mandatory"},{"type":"MAX_LENGTH","value":60,"message":"country maximum length allowed is 60"}]},
"poBox":{"validations":[{"type":"NOT MANDATORY","message":"poBox is not mandatory"},{"type":"MAX_LENGTH","value":26,"message":"poBox maximum length allowed is 25"}]}}');


