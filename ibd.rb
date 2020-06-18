

class Pager < BitStruct
  FileHeader :fheader
  rest :body
  unsigned :trailer, 8, 'trailer'
end

class Ibd < BitStruct
  unsigned :ip_v, 4, "Version"
  rest :body, "Body of message"
end
