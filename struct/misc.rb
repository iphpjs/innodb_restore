#
# Definitions and types for interpreting the .frm file values.
#

# Misc. constants
_PORTABLE_SIZEOF_CHAR_PTR = 8
_MY_CHARSET_BIN_NUM = 63
_HA_NOSAME = 1
_DIG2BYTES = [0, 1, 1, 2, 2, 3, 3, 4, 4, 4]
_DIG_PER_DEC1 = 9
_HEADER_LEN = 64
_TABLE_TYPE = 0x01fe # Magic number for table .frm files
_VIEW_TYPE = 0x5954 # Magic number for view .frm files
_FIELD_NR_MASK = 16383
_HA_USES_COMMENT = 4096

# MySQL data type definitions
_MYSQL_TYPE_DECIMAL = 0
_MYSQL_TYPE_TINY = 1
_MYSQL_TYPE_SHORT = 2
_MYSQL_TYPE_LONG = 3
_MYSQL_TYPE_FLOAT = 4
_MYSQL_TYPE_DOUBLE = 5
_MYSQL_TYPE_NULL = 6
_MYSQL_TYPE_TIMESTAMP = 7
_MYSQL_TYPE_LONGLONG = 8
_MYSQL_TYPE_INT24 = 9
_MYSQL_TYPE_DATE = 10
_MYSQL_TYPE_TIME = 11
_MYSQL_TYPE_DATETIME = 12
_MYSQL_TYPE_YEAR = 13
_MYSQL_TYPE_NEWDATE = 14
_MYSQL_TYPE_VARCHAR = 15
_MYSQL_TYPE_BIT = 16
_MYSQL_TYPE_TIMESTAMP2 = 17
_MYSQL_TYPE_DATETIME2 = 18
_MYSQL_TYPE_TIME2 = 19
_MYSQL_TYPE_NEWDECIMAL = 246
_MYSQL_TYPE_ENUM = 247
_MYSQL_TYPE_SET = 248
_MYSQL_TYPE_TINY_BLOB = 249
_MYSQL_TYPE_MEDIUM_BLOB = 250
_MYSQL_TYPE_LONG_BLOB = 251
_MYSQL_TYPE_BLOB = 252
_MYSQL_TYPE_VAR_STRING = 253
_MYSQL_TYPE_STRING = 254
_MYSQL_TYPE_GEOMETRY = 255

# Mapping of field data types to data type names
_col_types = [
    {'value': _MYSQL_TYPE_DECIMAL, 'text': 'decimal', 'size': None},
    {'value': _MYSQL_TYPE_TINY, 'text': 'tinyint', 'size': 1},
    {'value': _MYSQL_TYPE_SHORT, 'text': 'smallint', 'size': 2},
    {'value': _MYSQL_TYPE_LONG, 'text': 'int', 'size': 4},
    {'value': _MYSQL_TYPE_FLOAT, 'text': 'float', 'size': 4},
    {'value': _MYSQL_TYPE_DOUBLE, 'text': 'double', 'size': 8},
    {'value': _MYSQL_TYPE_NULL, 'text': 'NULL', 'size': 0},
    {'value': _MYSQL_TYPE_TIMESTAMP, 'text': 'timestamp', 'size': 4},
    {'value': _MYSQL_TYPE_LONGLONG, 'text': 'bigint', 'size': 8},
    {'value': _MYSQL_TYPE_INT24, 'text': 'mediumint', 'size': 3},
    {'value': _MYSQL_TYPE_DATE, 'text': 'date', 'size': 4},
    {'value': _MYSQL_TYPE_TIME, 'text': 'time', 'size': 3},
    {'value': _MYSQL_TYPE_DATETIME, 'text': 'datetime', 'size': 8},
    {'value': _MYSQL_TYPE_YEAR, 'text': 'year', 'size': 1},
    {'value': _MYSQL_TYPE_NEWDATE, 'text': 'date', 'size': 3},
    # Size must be calculated
    {'value': _MYSQL_TYPE_VARCHAR, 'text': 'varchar', 'size': -1},
    # Size must be calculated
    {'value': _MYSQL_TYPE_BIT, 'text': 'bit', 'size': -2},
    {'value': _MYSQL_TYPE_TIMESTAMP2, 'text': 'timestamp', 'size': 4},
    {'value': _MYSQL_TYPE_DATETIME2, 'text': 'datetime', 'size': 8},
    {'value': _MYSQL_TYPE_TIME2, 'text': 'time', 'size': 3},
    {'value': _MYSQL_TYPE_NEWDECIMAL, 'text': 'decimal', 'size': None},
    {'value': _MYSQL_TYPE_ENUM, 'text': 'enum', 'size': 0},
    {'value': _MYSQL_TYPE_SET, 'text': 'set', 'size': 0},
    {'value': _MYSQL_TYPE_TINY_BLOB, 'text': 'tinyblob',
     'size': 1 + _PORTABLE_SIZEOF_CHAR_PTR},
    {'value': _MYSQL_TYPE_MEDIUM_BLOB, 'text': 'mediumblob',
     'size': 3 + _PORTABLE_SIZEOF_CHAR_PTR},
    {'value': _MYSQL_TYPE_LONG_BLOB, 'text': 'longblob',
     'size': 4 + _PORTABLE_SIZEOF_CHAR_PTR},
    {'value': _MYSQL_TYPE_BLOB, 'text': 'blob',
     'size': 2 + _PORTABLE_SIZEOF_CHAR_PTR},
    # Size must be calculated
    {'value': _MYSQL_TYPE_VAR_STRING, 'text': 'varchar', 'size': -1},
    {'value': _MYSQL_TYPE_STRING, 'text': 'char', 'size': None},
    {'value': _MYSQL_TYPE_GEOMETRY, 'text': 'geometry',
     'size': 4 + _PORTABLE_SIZEOF_CHAR_PTR},
]

_col_keys = _col_types.map { |i| i[:value] }

# Database/engine type definitions
_DB_TYPE_UNKNOWN = 0
_DB_TYPE_DIAB_ISAM = 1
_DB_TYPE_HASH = 2
_DB_TYPE_MISAM = 3
_DB_TYPE_PISAM = 4
_DB_TYPE_RMS_ISAM = 5
_DB_TYPE_HEAP = 6
_DB_TYPE_ISAM = 7
_DB_TYPE_MRG_ISAM = 8
_DB_TYPE_MYISAM = 9
_DB_TYPE_MRG_MYISAM = 10
_DB_TYPE_BERKELEY_DB = 11
_DB_TYPE_INNODB = 12
_DB_TYPE_GEMINI = 13
_DB_TYPE_NDBCLUSTER = 14
_DB_TYPE_EXAMPLE_DB = 15
_DB_TYPE_ARCHIVE_DB = 16
_DB_TYPE_CSV_DB = 17
_DB_TYPE_FEDERATED_DB = 18
_DB_TYPE_BLACKHOLE_DB = 19
_DB_TYPE_PARTITION_DB = 20
_DB_TYPE_BINLOG = 21
_DB_TYPE_SOLID = 22
_DB_TYPE_PBXT = 23
_DB_TYPE_TABLE_FUNCTION = 24
_DB_TYPE_MEMCACHE = 25
_DB_TYPE_FALCON = 26
_DB_TYPE_MARIA = 27
_DB_TYPE_PERFORMANCE_SCHEMA = 28
_DB_TYPE_FIRST_DYNAMIC = 42
_DB_TYPE_DEFAULT = 127

# Mapping of engine types to engine names
_engine_types = [
    {'value': _DB_TYPE_UNKNOWN, 'text': 'UNKNOWN'},
    {'value': _DB_TYPE_DIAB_ISAM, 'text': 'ISAM'},
    {'value': _DB_TYPE_HASH, 'text': 'HASH'},
    {'value': _DB_TYPE_MISAM, 'text': 'MISAM'},
    {'value': _DB_TYPE_PISAM, 'text': 'PISAM'},
    {'value': _DB_TYPE_RMS_ISAM, 'text': 'RMS_ISAM'},
    {'value': _DB_TYPE_HEAP, 'text': 'HEAP'},
    {'value': _DB_TYPE_ISAM, 'text': 'ISAM'},
    {'value': _DB_TYPE_MRG_ISAM, 'text': 'MERGE'},
    {'value': _DB_TYPE_MYISAM, 'text': 'MYISAM'},
    {'value': _DB_TYPE_MRG_MYISAM, 'text': 'MERGE'},
    {'value': _DB_TYPE_BERKELEY_DB, 'text': 'BDB'},
    {'value': _DB_TYPE_INNODB, 'text': 'INNODB'},
    {'value': _DB_TYPE_GEMINI, 'text': 'GEMINI'},
    {'value': _DB_TYPE_NDBCLUSTER, 'text': 'NDBCLUSTER'},
    {'value': _DB_TYPE_EXAMPLE_DB, 'text': 'EXAMPLE'},
    {'value': _DB_TYPE_ARCHIVE_DB, 'text': 'ARCHIVE'},
    {'value': _DB_TYPE_CSV_DB, 'text': 'CSV'},
    {'value': _DB_TYPE_FEDERATED_DB, 'text': 'FEDERATED'},
    {'value': _DB_TYPE_BLACKHOLE_DB, 'text': 'BLACKHOLE'},
    {'value': _DB_TYPE_PARTITION_DB, 'text': 'PARTITION'},
    {'value': _DB_TYPE_BINLOG, 'text': 'BINLOG'},
    {'value': _DB_TYPE_SOLID, 'text': 'SOLID'},
    {'value': _DB_TYPE_PBXT, 'text': 'PBXT'},
    {'value': _DB_TYPE_TABLE_FUNCTION, 'text': 'FUNCTION'},
    {'value': _DB_TYPE_MEMCACHE, 'text': 'MEMCACHE'},
    {'value': _DB_TYPE_FALCON, 'text': 'FALCON'},
    {'value': _DB_TYPE_MARIA, 'text': 'MARIA'},
    {'value': _DB_TYPE_PERFORMANCE_SCHEMA, 'text': 'PERFORMANCE_SCHEMA'},
    {'value': _DB_TYPE_FIRST_DYNAMIC, 'text': 'DYNAMIC'},
    {'value': _DB_TYPE_DEFAULT, 'text': 'DEFAULT'},
]
_engine_keys = _engine_type.map { |i| i[:value] }

# Key algorithms
_KEY_ALG = ['UNDEFINED', 'BTREE', 'RTREE', 'HASH', 'FULLTEXT']

# Format definitions
#                            1         2         3
#                  01234567890123456789012345678901
_HEADER_FORMAT = "<BBBBHHIHHIHHHHHBBIBBBBBIIIIBBBHH"
#                        11122222333333444445556666
#                  12346824602468023489012371590124
#                 ***   111111
#             0123456789012345
_COL_DATA = "<BBBBBBBBBBBBBBBH"
#             0123456789111111
#                       012345

# Various flags copied from server source code - some may not be used but
# may find a use as more esoteric table configurations are tested. These
# are derived from fields.h and all may not apply but are included for
# future expansion/features.
_FIELDFLAG_DECIMAL = 1
_FIELDFLAG_BINARY = 1
_FIELDFLAG_NUMBER = 2
_FIELDFLAG_ZEROFILL = 4
_FIELDFLAG_PACK = 120 # Bits used for packing
_FIELDFLAG_INTERVAL = 256 # mangled with decimals!
_FIELDFLAG_BITFIELD = 512 # mangled with decimals!
_FIELDFLAG_BLOB = 1024 # mangled with decimals!
_FIELDFLAG_GEOM = 2048 # mangled with decimals!
_FIELDFLAG_TREAT_BIT_AS_CHAR = 4096 # use Field_bit_as_char
_FIELDFLAG_LEFT_FULLSCREEN = 8192
_FIELDFLAG_RIGHT_FULLSCREEN = 16384
_FIELDFLAG_FORMAT_NUMBER = 16384 # predit: ###,,## in output
_FIELDFLAG_NO_DEFAULT = 16384 # sql
_FIELDFLAG_SUM = 32768 # predit: +#fieldflag
_FIELDFLAG_MAYBE_NULL = 32768 # sql
_FIELDFLAG_HEX_ESCAPE = 0x10000
_FIELDFLAG_PACK_SHIFT = 3
_FIELDFLAG_DEC_SHIFT = 8
_FIELDFLAG_MAX_DEC = 31
_FIELDFLAG_NUM_SCREEN_TYPE = 0x7F01
_FIELDFLAG_ALFA_SCREEN_TYPE = 0x7800

# Additional flags
_NOT_NULL_FLAG = 1 # Field can't be NULL
_PRI_KEY_FLAG = 2 # Field is part of a primary key
_UNIQUE_KEY_FLAG = 4 # Field is part of a unique key
_MULTIPLE_KEY_FLAG = 8 # Field is part of a key
_BLOB_FLAG = 16 # Field is a blob
_UNSIGNED_FLAG = 32 # Field is unsigned
_HA_PACK_RECORD = 1 # Pack record?
_HA_FULLTEXT = 128 # For full-text search
_HA_SPATIAL = 1024 # For spatial search

# Row type definitions
_ROW_TYPE_DEFAULT, _ROW_TYPE_FIXED, _ROW_TYPE_DYNAMIC, _ROW_TYPE_COMPRESSED, \
    _ROW_TYPE_REDUNDANT, _ROW_TYPE_COMPACT, _ROW_TYPE_PAGE = range(0, 7)

# enum utypes from field.h
_NONE, _DATE, _SHIELD, _NOEMPTY, _CASEUP, _PNR, _BGNR, _PGNR, _YES, _NO, \
    _REL, _CHECK, _EMPTY, _UNKNOWN_FIELD, _CASEDN, _NEXT_NUMBER, \
    _INTERVAL_FIELD, _BIT_FIELD, _TIMESTAMP_OLD_FIELD, _CAPITALIZE, \
    _BLOB_FIELD, _TIMESTAMP_DN_FIELD, _TIMESTAMP_UN_FIELD, \
    _TIMESTAMP_DNUN_FIELD = range(0, 24)

# Array of field data types that can be unsigned
_UNSIGNED_FIELDS = ['TINYINT', 'SMALLINT', 'MEDIUMINT', 'INT', 'INTEGER',
                    'BIGINT', 'REAL', 'DOUBLE', 'FLOAT', 'DECIMAL', 'NUMERIC']

# Array of field data types that can have character set options
_CS_ENABLED = ['CHAR', 'VARCHAR', 'TINYBLOB', 'BLOB', 'MEDIUMBLOB', 'LONGBLOB',
               'ENUM', 'SET']

# Array of index (key) types
_KEY_TYPES = ['PRIMARY', 'UNIQUE', 'MULTIPLE', 'FULLTEXT', 'SPATIAL',
              'FOREIGN_KEY']

# Array of field data types that do not require parens for size
_NO_PARENS = ['TIMESTAMP', 'DATETIME', 'DATE', 'TIME',
              'TINYBLOB', 'BLOB', 'MEDIUMBLOB', 'LONGBLOB',
              'TINYTEXT', 'TEXT', 'MEDIUMTEXT', 'LONGTEXT']

# Array of field data types that are real data
_REAL_TYPES = ['REAL', 'DOUBLE', 'FLOAT', 'DECIMAL', 'NUMERIC']

# Array of blob data types
_BLOB_TYPES = [_MYSQL_TYPE_TINY_BLOB, _MYSQL_TYPE_MEDIUM_BLOB,
               _MYSQL_TYPE_LONG_BLOB, _MYSQL_TYPE_BLOB,
               _MYSQL_TYPE_GEOMETRY]

# Array of data types that do not use keysize for indexes
_NO_KEYSIZE = ['BIT', 'ENUM', 'SET', 'DECIMAL', 'NUMERIC',
               'TIMESTAMP', 'TIME', 'DATETIME']



