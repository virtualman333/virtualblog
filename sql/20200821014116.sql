/*
MySQL Backup
Database: virtualblog
Backup Time: 2020-08-21 01:41:16
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `virtualblog`.`virtual_article_sort`;
DROP TABLE IF EXISTS `virtualblog`.`virtual_articles`;
DROP TABLE IF EXISTS `virtualblog`.`virtual_comment`;
DROP TABLE IF EXISTS `virtualblog`.`virtual_sort`;
DROP TABLE IF EXISTS `virtualblog`.`virtual_users`;
CREATE TABLE `virtual_article_sort` (
  `article_id` bigint(20) NOT NULL COMMENT '文章ID',
  `sort_id` bigint(20) NOT NULL COMMENT '分类ID',
  PRIMARY KEY (`article_id`,`sort_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
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
  `sort_alias` varchar(255) NOT NULL COMMENT '别名',
  `sort_description` text NOT NULL COMMENT '描述',
  `parent_sort_id` bigint(20) NOT NULL COMMENT '父分类ID 默认为0',
  PRIMARY KEY (`sort_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
CREATE TABLE `virtual_users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_ip` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `user_password` varchar(255) NOT NULL COMMENT '密码',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_article_sort` WRITE;
DELETE FROM `virtualblog`.`virtual_article_sort`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_articles` WRITE;
DELETE FROM `virtualblog`.`virtual_articles`;
INSERT INTO `virtualblog`.`virtual_articles` (`article_id`,`article_title`,`article_content`,`article_views`,`article_comment_count`,`article_datatime`,`article_like_count`,`article_class_id`) VALUES (1, 'helloworld', '作者 | CDA数据分析师\r\n\r\n1、列表的概念\r\n\r\n列表（list）是用来存储一组有序数据元素的数据结构，元素之间用都好分隔。列表中的数据元素应该包括在方括号中，而且列表是可变的数据类型，一旦创建了一个列表，你可以添加、删除或者搜索列表中的元素。在方括号中的数据可以是int型，也可以是str型。\r\n\r\n2、新建一个列表\r\n\r\n新建列表的方法比较简单，直接将数据元素用方括号括起来就行，下面是集中常见类型列表的新建实例。\r\n\r\n■新建一个空列表，如下图：\r\n\r\n\r\n■建立一个int类型列表\r\n\r\n当方括号中的数据元素全部为int类型时，这个列表就是int类型的列表\r\n\r\n\r\n■建立一个str类型列表\r\n\r\n当方括号中的数据元素全部为str类型时，这个列表就是str类型的列表\r\n\r\n\r\n■建立一个int+str类型列表\r\n\r\n当方括号中的数据元素既有int类型，又有str类型时，这个列表就是int+str类型列表。\r\n\r\n\r\n3、列表的复制\r\n\r\n列表的复制和字符串的复制类似，也是利用*操作符。\r\n\r\n\r\n\r\n4、列表的合并\r\n\r\n列表的合并就是将两个现有的list合并在一起，主要有两种实现方式，一种是利用+操作符，它和字符串的连接一致；另外一种用的是extend()函数。\r\n\r\n直接将两个列表用+操作符连接即可达到合并的目的，列表的合并是有先后顺序的。\r\n\r\n\r\n将列表B合并到列表A中，用到的方法是A.extend(B)，将列表A合并到列表B中，用到的方法是B.extend(A)。\r\n\r\n\r\n5、向列表中插入新元素\r\n\r\n列表是可变的，也就是当新建一个列表后你还可以对这个列表进行操作，对列表进行插入数据元素的操作主要有append()和insert()两个函数可用。这两个函数都会直接改变原列表，不会直接输出解雇哦，需要调用原列表的列表名来获取插入新元素以后的列表。\r\n\r\n函数append()是在列表末尾插入新的数据元素，如下图：\r\n\r\n\r\n函数insert()是在列表指定位置插入新的数据元素，如下图：\r\n\r\n\r\n6、获取列表中值出现的次数\r\n\r\n利用count()函数获取某个值在列表中出现的次数。\r\n\r\n例如，全校成绩排名前五的5个学生对应的班级组成一个列表，想看一下你所在的班级（一班）有几个人在这个列表中。\r\n\r\n\r\n7、获取列表中值出现的位置\r\n\r\n获取值出现的位置，就是看该值位于列表中的哪里。\r\n\r\n已知公司的所有的销售业绩是按降序排列的，想看一下杨新竹的业绩排在第几。\r\n\r\n\r\n上边的结果是3，也就是杨新竹的业绩排第四名。\r\n\r\n\r\n8、获取列表中指定位置的值\r\n\r\n获取指定位置的值利用的方法和字符串索引是一致的，主要是有普通索引和切片索引两种。\r\n\r\n（1）普通索引：普通索引是活期某一特定位置的数，如下图：\r\n\r\n\r\n（2）切片索引：切片索引是获取某一位置区间内的数，如下图：\r\n\r\n\r\n9、删除列表中的值\r\n\r\n对列表中的值进行删除时，有pop()和remove()两个函数可用。\r\n\r\npop()函数是根据列表中的位置进行删除，也就是删除指定位置的值，如下图：\r\n\r\n\r\nremove()函数是根据列表中的元素进行删除，也就是删除某一元素，如下图：\r\n\r\n\r\n10、对列表中的值进行排序\r\n\r\n对列表中的值排序利用的是sort()函数，sort()函数默认采用升序排列，如下图：\r\n\r\n\r\n\r\n数据结构——字典\r\n\r\n1、字典的概念\r\n\r\n字典是一种键值对的结构，类似于通过联系人姓名查找地址和联系人详细情况的地址簿，即把键（名字）和值（详细情况）联系在一起。注意，键必须是唯一的，就像如果有两个人恰巧同名，那么你无法找到正确的信息一样。\r\n\r\n键值对在字典中以{key1：value，key2：value}方式标记。注意，键值对内部用冒号分隔，而各个对之间用逗号分隔，所有这些都包括在花括号中。\r\n\r\n2、新建一个字典\r\n\r\n先创建一个空的字典，然后向该字典内输入值。下面新建一个通讯录：\r\n\r\n\r\n将值直接以列表的形式存放在元组中，然后用dict进行转换。\r\n\r\n\r\n将键值以列表的形式存放在元组中，然后用dict进行转换。\r\n\r\n\r\n3、字典中的keys()、values()和items()方法\r\n\r\n■keys()方法用来获取字典内的所有键。\r\n\r\n\r\n■values()方法用来获取字典内的所有值。\r\n\r\n\r\n■items()方法用来得到一组组的键值对。\r\n\r\n\r\n\r\n数据结构——元组\r\n\r\n1、元组的概念\r\n\r\n元组虽然与列表类似，但是也有不同支持，元组的元素不能修改；元组适用小括号，而列表中使用中括号。\r\n\r\n2、新建一个元组\r\n\r\n元组的创建比较简单，直接将一组数据元素用小括号括起来即可。\r\n\r\n\r\n3、获取元组的长度\r\n\r\n获取元组的长度的方法与获取列表长度的方法是一样的，都使用函数len()。\r\n\r\n\r\n4、获取元组内的元素\r\n\r\n元组内的元素的获取方法主要分为普通索引和切片索引两种。\r\n\r\n（1）普通索引\r\n\r\n\r\n（2）切片索引\r\n\r\n\r\n5、元组与列表相互转换\r\n\r\n元组和列表是两种相似的数据结构，两者经常互相转换。\r\n\r\n使用函数list()将元组转化为列表。\r\n\r\n\r\n使用函数tuple()将列表转化为元组。\r\n\r\n\r\n\r\n6、zip()函数\r\n\r\nzip()函数用于将可迭代的对象（列表、原组）作为参数，将对象中对应的元素打包成一个个元组，然后返回由这些元组组成的列表。zip()函数常与for循环一起搭配使用。\r\n\r\n当迭代对象是列表时：\r\n\r\n\r\n\r\n当迭代对象是元组时：\r\n\r\n\r\n运算符\r\n\r\n1、算数运算符\r\n\r\n算数运算符就是常规的加、减、乘、除类运算。下表为基本的运算符及其示例。\r\n\r\n\r\n2、比较运算符\r\n\r\n比较运算符就是大于、等于、小于之类的，主要是用来做比较的，返回是True或者False的结果，常用的比较运算符如下表所示。\r\n\r\n\r\n续集\r\n\r\n\r\n3、逻辑运算符\r\n\r\n逻辑运算符就是与、或、非，下表为逻辑运算符及其示例。', 110, 2, '2020-08-20 16:15:30', 0, 1),(2, '我的第二篇测试文章', '鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大鞍山师范撒所多所大', 69, 0, '2020-08-21 16:34:40', 11, 1),(3, '标题', '内容', 29, 0, '2020-08-20 19:26:00', 0, 1),(4, '12', '\r\n### 科学公式 TeX(KaTeX)\r\n                    \r\n$$E=mc^2$$\r\n\r\n行内的公式$$E=mc^2$$行内的公式，行内的$$E=mc^2$$公式。\r\n\r\n$$\\(\\sqrt{3x-1}+(1+x)^2\\)$$\r\n                    \r\n$$\\sin(\\alpha)^{\\theta}=\\sum_{i=0}^{n}(x^i + \\cos(f))$$\r\n\r\n$$X^2 > Y$$\r\n\r\n#####上标和下标\r\n\r\n上标：X&lt;sup&gt;2&lt;/sup&gt;\r\n\r\n下标：O&lt;sub&gt;2&lt;/sub&gt;\r\n\r\n##### 代码块里包含的过滤标签及属性不会被过滤\r\n\r\n```html\r\n&lt;style type=\"text/style\"&gt;\r\nbody{background:red;}\r\n&lt;/style&gt;\r\n\r\n&lt;script type=\"text/javscript\"&gt;\r\nalert(\"script\");\r\n&lt;/script&gt;\r\n\r\n&lt;iframe height=498 width=510 src=\"http://player.youku.com/embed/XMzA0MzIwMDgw\" frameborder=0 allowfullscreen&gt;&lt;/iframe&gt;\r\n```\r\n\r\n#####Style\r\n\r\n&lt;style&gt;\r\nbody{background:red;}\r\n&lt;/style&gt;\r\n\r\n&lt;style type=\"text/style\"&gt;\r\nbody{background:red;}\r\n&lt;/style&gt;\r\n\r\n#####Script\r\n\r\n&lt;script&gt;\r\nalert(\"script\");\r\n&lt;/script&gt;\r\n\r\n&lt;script type=\"text/javscript\"&gt;\r\nalert(\"script\");\r\n&lt;/script&gt;', 18, 0, '2020-07-30 19:26:21', 0, 1),(5, '阿萨斯多', '# 啊实打实阿斯顿\r\n###### 阿斯顿\r\n- 仨\r\n\r\n------------\r\n\r\n安上', 46, 0, '2020-08-08 00:00:00', 0, 1),(6, '【算法】位运算与优化', '刚刚学算法的时候，看到dalao处处用位运算，感觉真的太玄学了，然后直到今天才深入理解了下位运算的操作，其实并没有多么玄学，只不过是利用了计算机本身的性质罢了。\r\n基本概念：\r\n真值：\r\n带符号位的机器数对应的真正数值称为机器数的真值\r\n0000 0001的真值 = +000 0001 = +1，1000 0001的真值 = –000 0001 = –1\r\n\r\n原码：\r\n原码就是符号位加上真值的绝对值, 即用第一位表示符号, 其余位表示值\r\nPS：正数的原、反、补码都一样：0的原码跟反码都有两个，因为这里0被分为+0和-0。\r\n\r\n\r\n反码：\r\n正数的反码是其本身\r\n负数的反码是在其原码的基础上, 符号位不变，其余各个位取反.\r\n[+1] = [00000001]原 = [00000001]反\r\n[-1] = [10000001]原 = [11111110]反\r\n\r\n补码：\r\n正数的补码就是其本身\r\n\r\n负数的补码是在其原码的基础上, 符号位不变, 其余各位取反, 最后+1. (即在反码的基础上+1)\r\n\r\n[+1] = [00000001]原 = [00000001]反 = [00000001]补\r\n[-1] = [10000001]原 = [11111110]反 = [11111111]补\r\n\r\nPS：0的补码是唯一的，如果机器字长为8那么[0]补=00000000。\r\n\r\n\r\n移码：\r\n移码最简单了，不管正负数，只要将其补码的符号位取反即可。\r\n\r\n例如：X=-101011 , [X]原= 10101011 ，[X]反=11010100，[X]补=11010101，[X]移=01010101\r\n\r\n位运算基本运算符：\r\n&：按位与\r\n|：按位或\r\n^：按位异或（相同为1，不同为0）\r\n~：取反\r\n<<：左移\r\n>>：右移\r\n\r\n常用位运算优化方法：\r\n1.判断整数奇(1)偶(0)性：\r\n\r\nbool IsOdd(int x)//判断是否为奇数\r\n{\r\n    return x&1;\r\n}\r\n \r\n\r\n2.乘以或除以2的幂：\r\n\r\n \r\n\r\n列如：    乘以2: x<<1;\r\n　　　　 乘以2的n次方：x<<n;\r\n　　　　 除以2：x>>2;\r\n　　　　 除以2的n次方：x>>n;\r\n变式：    计算2的n次方：2<<(n-1);\r\n \r\n\r\n3.比较两个数是否相等：\r\n\r\n计算两个数的异或值，若等于0，则两数相等。\r\n\r\nbool IsEqual(int a,int b)\r\n{\r\n    return !(a^b);\r\n}\r\n \r\n\r\n4.不使用第三方变量交换a，b：\r\n\r\nint a,int b;\r\na=a^b;\r\nb=a^b;\r\na=a^b;\r\n \r\n\r\n5.判断两个数是否同号：\r\n\r\n!((a^b)>>31);\r\n \r\n\r\n6.求n的绝对值：\r\n\r\n(n^(n>>31))-(n>>31);\r\n \r\n\r\n7.提取lowbit()：\r\n\r\nint lowbit(int x)\r\n{\r\n    return x&-x;\r\n}\r\n \r\n\r\n8.计算整数x和y的平均值，可防止溢出。\r\n\r\nint average(int x, int y) //返回X,Y 的平均值 \r\n{ \r\n　　return (x&y)+((x^y)>>1); \r\n}\r\n \r\n\r\n9.判断一个整数n是否为2的幂 2^n：\r\n\r\n((x&(x-1))==0)&&(x!=0);', 13, 1, '2020-08-20 00:00:00', 0, 1);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_comment` WRITE;
DELETE FROM `virtualblog`.`virtual_comment`;
INSERT INTO `virtualblog`.`virtual_comment` (`comment_id`,`comment_user_name`,`comment_article_id`,`comment_datatime`,`comment_content`,`comment_mail`,`comment_url`) VALUES (1, 'cyg2001', 1, '0000-00-00 00:00:00', '', '', ''),(2, 'asdas', 1, '2020-08-25 21:33:24', 'adfsdsf', 'mai', 'url'),(3, 'asdf', 2, '2020-08-20 21:34:01', 'sadf', 'sag', 'asfd'),(4, 'cyg', 1, '2020-08-20 21:37:12', 'sdasd', '1515518552@qq.com', 'baidu.com'),(5, 'asd', 1, '2020-08-20 21:37:40', 'sdafasfd', 'virtualman@yeah.net', 'sdaffas'),(6, 'asd', 1, '2020-08-20 21:37:43', 'sdafasfd', 'virtualman@yeah.net', 'sdaffas'),(7, 'sadaf', 1, '2020-08-20 21:38:37', 'asdfg', 'fsdfaa', 'sdffas'),(8, 'asd', 1, '2020-08-20 21:45:47', '写的很好', '1515518552@qq.com', 'http://127.0.0.1:5000/article?article_id=1'),(9, '陈永贵', 6, '2020-08-20 21:52:50', 'nb', '1515518552@qq.com', 'http://127.0.0.1:5000/article?article_id=6'),(10, 'ASD', 6, '2020-08-20 21:54:36', '4.不使用第三方变量交换a，b： \r\n那里有错误！！！', '1515518552@qq.com', '');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_sort` WRITE;
DELETE FROM `virtualblog`.`virtual_sort`;
INSERT INTO `virtualblog`.`virtual_sort` (`sort_id`,`sort_name`,`sort_alias`,`sort_description`,`parent_sort_id`) VALUES (1, '未分类文章', '未分类文章', '未分类文章', 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `virtualblog`.`virtual_users` WRITE;
DELETE FROM `virtualblog`.`virtual_users`;
INSERT INTO `virtualblog`.`virtual_users` (`user_id`,`user_ip`,`user_name`,`user_password`) VALUES (1, '', 'virtualman', '84711841');
UNLOCK TABLES;
COMMIT;
