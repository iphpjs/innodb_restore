require 'bit-struct'
require 'binary_struct'
require_relative 'extend'
require_relative 'struct/misc'

p Misc.constants

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

filename = '/Users/suse/Sync/opt/test/blog/users.frm'
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

header_bin = File.open(filename).read(Misc::MAGIC_LEN+Misc::HEADER_LEN)

frm_header = BinaryStruct.new([
                                  'H4', :magic,
                                  'C', :frm_version,
                                  'H6', :reversed_1,
                                  # 'C', :legacy_db_type,
                                  'C', :IO_SIZE,
                                  'H6', :reversed_2,
                                  'v', :length,
                                  'n', :tmp_key_length,
                                  'v', :reserved_3,
                                  'n', :rec_length,
                                  'n', :max_rows,
                                  'n', :min_rows,
                                  'H6', :reserved_4,
                                  'C', :db_create_pack,
                                  'C', :key_info_length,
                                  'C', :create_options,
                                  'C', :frm_file_ver,
                                  'C', :avg_row_length,
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


header_unpacked = header_bin.unpack(sprintf('%s%s', Misc::MAGIC_FORMAT, Misc::HEADER_FORMAT))

magic = header_unpacked[0]
header = header_unpacked[1..]

general_data = {
    'frm_version': header[0],
    'legacy_db_type': Misc::ENGINE_TYPES[header[1]][:text],
    'IO_SIZE': header[4],
    'length': header[6],
    'tmp_key_length': header[7],
    'rec_length': header[8],
    'max_rows': header[10],
    'min_rows': header[11],
    'db_create_pack': header[12] >> 8,  # only want 1 byte
    'key_info_length': header[13],
    'create_options': header[14],
    'frm_file_ver': header[16],
    'avg_row_length': header[17],
    'default_charset': header[18],
    'row_type': header[20],
    'charset_low': header[21],
    'table_charset': (header[21] << 8) + header[18],
    'key_length': header[24],
    'MYSQL_VERSION_ID': header[25],
    'extra_size': header[26],
    'default_part_eng': header[29],
    'key_block_size': header[30],
}



a = 1