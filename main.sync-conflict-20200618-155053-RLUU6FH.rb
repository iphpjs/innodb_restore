#!/usr/bin/env ruby -w

require 'mysql2'

dbname = 'blog'

class Dir
  def initialize(dirname)
    @dirname = dirname
    @dir = Dir.open(dirname)
  end

  def get_files
    arr = []
    @dir.each do |name|
      arr.push("#{@dirname}/#{name}") unless name.start_with?('.')
    end
    arr
  end

  def finialize
    @dir.close
  end
end

class Client
  def initialize(dbname)
    @dbname = dbname
    @client = Mysql2::Client.new(
        :host => 'localhost',
        :username => 'root',
        :password => '', # 密码
        :encoding => 'utf8' # 编码
    )
  end

  def get_data_dir
    # client.query("SET GLOBAL innodb_file_format='Barracuda';")
    @client.query("SET GLOBAL innodb_file_per_table='on';")
    @client.query("SET NAMES UTF8;")
    @client.query("CREATE DATABASE IF NOT EXISTS `#{@dbname}` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;")
    results = @client.query("SELECT @@datadir;")

    datadir = nil

    results.each do |row|
      datadir = sprintf('%s%s', row['@@datadir'], @dbname)
    end

    datadir
  end

  def run
    datadir = self.get_data_dir
    # p datadir
    @client.select_db(@dbname)
    dirname = '/Applications/XAMPP/xamppfiles/var/mysql/blog'
    files = Dir.new(dirname).get_files
    p files
    file = '/Applications/XAMPP/xamppfiles/var/mysql/blog/failed_jobs.ibd'

    b = IO.read(file)
    offset = struct.unpack('<L',b[6]) #io_size

    a = 1

  end

  def finalize
    @client.close
  end
end

Client.new(dbname).run




