require 'json'

require_relative 'database'

class ConsultExams

  def consult
    query = "SELECT * FROM exams"
    result = Database.execute(query)
    data = result.map(&:to_h)
    data.to_json
  end
end

