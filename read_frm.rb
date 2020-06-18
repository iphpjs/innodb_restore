require 'bit-struct'
require 'binary_struct'

class FrmReader
  def initialize(filename)
    @dbname = File.basename(File.dirname(filename))
    @table = File.basename(filename, '.*')
    @bytes = IO.binread(filename)
  end

  # Build the column definitions
  #
  #         This method constructs the column definitions from the column data
  #         read from the file.
  #
  #         Returns list of strings - column definitions
  def _get_column_definitions
    columns = []
    stop = len(self.column_data)

  end

  def get_create_table_statement
    # CREATE statement preamble
    parts = []

    # Create preamble
    preamble = "CREATE TABLE %s`%s` ("
    parts.append(sprintf(preamble, "`#{@dbname}`.", @table))

    # Get columns
    parts.concat(self._get_column_definitions)
    # Get indexes
    parts.extend(self._get_key_columns)

    # Create postamble and table options
    parts.append(self._get_table_options)


    parts.join('\n')
  end
end

filename = '/Users/suse/Sync/opt/test/blog/failed_jobs.frm'
# p FrmReader.new(filename).get_create_table_statement

class FileHeader < BitStruct
  unsigned :magic, 4, 'Magic'
  unsigned :frm_version, 4, 'Frm version'
  unsigned :legacy_db_type, 4, 'Legacy db type'
  unsigned :IO_SIZE, 4, 'Io size'
  unsigned :len, 4, 'Length'
  unsigned :tmp_key_length, 4, 'Tmp key length'
  unsigned :rec_length, 4, 'Rec length'
  unsigned :max_rows, 4, 'Max rows'
  unsigned :min_rows, 4, 'Min rows'
  unsigned :db_create_pack, 4, 'Db create pack'
  unsigned :key_info_length, 4, 'Key info length'
  unsigned :create_options, 4, 'Create options'
  unsigned :frm_file_ver, 4, 'Frm file ver'
  unsigned :avg_row_length, 4, 'Avg row length'
  unsigned :default_charset, 4, 'Default charset'
  unsigned :row_type, 4, 'Row type'
  unsigned :charset_low, 4, 'Charset low'
  unsigned :table_charset, 4, 'Table charset'
  unsigned :key_length, 4, 'Key length'
  unsigned :MYSQL_VERSION_ID, 4, 'Mysql version id'
  unsigned :extra_size, 4, 'Extra size'
  unsigned :default_part_eng, 4, 'Default part eng'
  unsigned :key_block_size, 4, 'Key block size'
end

header = File.open(filename).read(92)

frm_header = BinaryStruct.new([
                                  'B', :frm_version,
                                  'B', :legacy_db_type,
                                  'B', :IO_SIZE,
                                  'B', :length,
                                  'B', :tmp_key_length,
                                  'B', :rec_length,
                                  'B', :max_rows,
                                  'B', :min_rows,
                                  'B', :db_create_pack,
                                  'B', :key_info_length,
                                  'B', :create_options,
                                  'B', :frm_file_ver,
                                  'B', :avg_row_length,
                                  'B', :default_charset,
                                  'B', :row_type,
                                  'B', :charset_low,
                                  'B', :table_charset,
                                  'B', :key_length,
                                  'B', :MYSQL_VERSION_ID,
                                  'B', :extra_size,
                                  'B', :default_part_eng,
                                  'B', :key_block_size,
                              ])

header_size = frm_header.size
puts header.size
puts header_size
h = frm_header.decode(header[0,header_size])

a = 1