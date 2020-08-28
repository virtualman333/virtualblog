/*
MySQL Backup
Database: virtualblog
Backup Time: 2020-08-22 00:21:55
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `virtualblog`.`virtual_articles`;
DROP TABLE IF EXISTS `virtualblog`.`virtual_comment`;
DROP TABLE IF EXISTS `virtualblog`.`virtual_sort`;
DROP TABLE IF EXISTS `virtualblog`.`virtual_users`;
CREATE TABLE `virtual_articles` (
  `article_id` bigint(255) NOT NULL AUTO_INCREMENT COMMENT '博文ID',
  `article_title` text NOT NULL COMMENT '标题',
  `article_content` longtext NOT NULL COMMENT '内容',
  `article_views` bigint(255) unsigned NOT NULL COMMENT '流量',
  `article_comment_count` bigint(255) unsigned NOT NULL COMMENT '评论数',
  `article_datatime` datetime NOT NULL COMMENT '发布时间',
  `article_like_count` bigint(255) unsigned NOT NULL COMMENT '点赞数',
  `article_class_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
CREATE TABLE `virtual_comment` (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `comment_user_name` text NOT NULL COMMENT '发表用户名',
  `comment_article_id` bigint(20) NOT NULL COMMENT '评论文章ID',
  `comment_datatime` datetime NOT NULL COMMENT '日期',
  `comment_content` text NOT NULL COMMENT '内容',
  `comment_mail` varchar(255) NOT NULL,
  `comment_url` varchar(255) NOT NULL COMMENT 'url',
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
CREATE TABLE `virtual_sort` (
  `sort_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `sort_name` varchar(255) NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`sort_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
CREATE TABLE `virtual_users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_ip` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `user_password` varchar(255) NOT NULL COMMENT '密码',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_articles` WRITE;
DELETE FROM `virtualblog`.`virtual_articles`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_comment` WRITE;
DELETE FROM `virtualblog`.`virtual_comment`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_sort` WRITE;
DELETE FROM `virtualblog`.`virtual_sort`;
INSERT INTO `virtualblog`.`virtual_sort` (`sort_id`,`sort_name`) VALUES (1, '未分类文章'),(3, '算法与数据结构'),(4, '编程语言'),(5, '技术问题'),(6, '操作系统'),(7, '数据库'),(8, '人工智能'),(9, 'Web前端'),(10, '计算机网络');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_users` WRITE;
DELETE FROM `virtualblog`.`virtual_users`;
INSERT INTO `virtualblog`.`virtual_users` (`user_id`,`user_ip`,`user_name`,`user_password`) VALUES (1, '', 'virtualman', '84711841');
UNLOCK TABLES;
COMMIT;
