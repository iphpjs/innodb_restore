#!/usr/bin/env ruby -w

require 'mysql2'
require_relative 'extend'

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
  def initialize(dbname='blog')
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
    tablename = 'failed_jobs'
    # p datadir
    @client.select_db(@dbname)
    dirname = '/Users/suse/Sync/opt/test/blog'
    files = Dir.new(dirname).get_files
    p files
    file = "#{dirname}/#{tablename}.frm"

    b = IO.read(file).bin2hex

    word_bit = 32
    byte_bit = 8
    hex_bit = 4
    bit = 1

    word_byte = word_bit / byte_bit
    byte_hex = byte_bit / hex_bit

    offset = b[byte_hex * 0x06, word_byte].reverse_by_byte.to_i(16) # io_size
    p 'offset', offset
    offset += b[byte_hex * 0x0e, word_byte].reverse_by_byte.to_i(16) # tmp_key_length
    p 'offset', offset
    offset += b[byte_hex * 0x10, word_byte].reverse_by_byte.to_i(16) # rec_length
    p 'offset', offset
    offset += 2
    p 'offset', offset
    len = b[byte_hex * offset, word_byte].reverse_by_byte.to_i(16) # type string length,in word
    offset += 2
    p 'offset', offset
    str = b[byte_hex * offset, byte_hex * len]

    return FALSE unless str.hex2bin == 'InnoDB'

    b[byte_hex * 3] = '0006'.hex2bin.byte_order_reverse.bin2hex
    b[byte_hex * 6] = '454d'.hex2bin.byte_order_reverse.bin2hex
    b[byte_hex * 8] = '4f4d'.hex2bin.byte_order_reverse.bin2hex
    b[byte_hex * 10] = '5952'.hex2bin.byte_order_reverse.bin2hex


    p 'b', b
    p 'datadir', datadir
    Dir.exist?(datadir) or Dir.mkdir(datadir)
    fullpath = "#{datadir}/#{File.basename(file)}"
    p 'fullpath', fullpath
    IO.binwrite(fullpath, b.hex2bin)


    @client.query('flush tables;')
    # @client.close
    # self.initialize
    result = @client.query("SHOW CREATE TABLE `#{tablename}`;")

    p 'result', result
    create_sql = nil
    result.each do |i|
      p i
    end

    a = 1

    True
  end

  def finalize
    @client.close
  end
end

Client.new(dbname).run




