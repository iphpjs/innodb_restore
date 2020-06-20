# innodb_restore
mysql innodb 引擎数据库恢复工具

#### 背影介绍

最近发现阿里云的服务器越来越贵了，有点买不起了，在别的主机提供商上面找到了便宜点的主机。于是得备份数据，迁移服务器。当前mysql本身的mysqldump迁移也很好用，但是做为一个极客，准备采用二进制的方式备份与恢复，于是开始了mysql存储引擎进制文件结构的研究。

#### 知识简介

mysql mysiam 引擎的表不具备事务，例如表名test的表使用mysiam引擎，则将
* test.frm 存储表定义
* test.MYD 存储表数据
* test.MYI 存储表索引
三个文件复制到对应目录即可完成恢复。

然而由于InnoDB存储引擎存在事务，按上述方法无法完成表的恢复。

下面介绍一下InnoDB存储引擎表的恢复原理

基本步骤如下：
   * 数据库创建表结构
   * 卸载表空间，会删除dbname.ibd文件（ALTER TABLE `table_name` DISCARD TABLESPACE;）
   * 复制table_name.ibd文件
   * 恢复表空间（ALTER TABLE `table_name` IMPORT TABLESPACE;）

其中后面三个步骤容易，第一个步骤数据库创建表结构这个，首先得知道原来的表结构才行。

下面根据实践及资料得知：

* 二进制存储结构
    * mysql 5.6及以下版本 (version: 10.1.32-MariaDB, innodb_version: 5.6.38-83.0)
        * table_name.frm # 存储了表结构
        * table_name.ibd # 存储了表数据及索引
    * mysql 5.7 (version: 5.7.14, innodb_version: 5.7.14)
        * table_name.frm # 存储了表结构
        * table_name.ibd # 存储了表结构及表数据及索引
      * mysql 8.0 (version: 8.0.19, innodb_version: 8.0.19)
         * table_name.frm # 没有此文件
         * table_name.ibd # 存储了表结构及表数据及索引
         
* 使用mysql-utilities-1.6.4中的mysqlfrm测试获取表结构，
mysql 5.7的frm可以得到表结构，mysql 5.6的frm不行
* 使用mysql-utilities-1.6.4中的ibd2sdi测试mysql 5.7和mysql 5.8的ibd文件可以得到结构信息

 

#### 参考
https://blog.csdn.net/xiaoyi23000/article/details/53150776
https://www.zcgonvh.com/post/mysql_innodb_restore.html
https://blog.csdn.net/HuaLingPiaoXue/article/details/104953594
http://www.leviathan.vip/2019/04/18/InnoDB的文件组织结构/#内存文件管理