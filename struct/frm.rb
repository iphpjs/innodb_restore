require 'bit-struct'
require_relative 'misc'

class FileHeader < BitStruct

end

class Frm < BitStruct
  FileHeader :fheader, _HEADER_LEN, 'File Header'
  rest :body
  unsigned :trailer, 8, 'trailer'
end