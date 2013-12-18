module ProjectsHelper
  def emails_from_lines(text)
    text.lines.map(&:strip)
  end
end
