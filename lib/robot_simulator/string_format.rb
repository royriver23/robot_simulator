class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def bold;           "\e[1m#{self}\e[22m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
end
