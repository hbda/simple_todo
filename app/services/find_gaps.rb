class FindGaps
  def call m, gaps_count = 2, offset =  0
    loop do
      if m.size == 1
        if gaps_count == 1
          return m[0] - 1
        else
          return [m[0] - 2, m[0] - 1]
        end
      end

      i = m.size / 2
      i -= 1 if m.size.even?
      if m[i] == offset + i + 1
        offset += i + 1
        m = m[i + 1..-1]
      elsif m[i] == offset + i + 1 + gaps_count
        m = m[0..i]
      else
        return [call(m[0..i], 1), call(m[i + 1..-1], 1, offset + i + 2)]
      end
    end
  end
end
