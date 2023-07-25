require 'json'

require_relative 'database'

class ConsultExams

  def consult
    query = "SELECT * FROM exams"
    result = Database.execute(query)
    data = result.map(&:to_h)

    grouped_data = data.group_by { |record| record["token_resultado_exame"] }
    output_data = grouped_data.map do |result_token, records|
      {
        "result_token": result_token,
        "result_date": records[0]["data_exame"],
        "cpf": records[0]["cpf"],
        "name": records[0]["nome_paciente"],
        "email": records[0]["email_paciente"],
        "birthday": records[0]["data_nascimento_paciente"],
        "doctor": {
          "crm": records[0]["crm_médico"],
          "crm_state": records[0]["crm_médico_estado"],
          "name": records[0]["nome_médico"]
        },
        "tests": records.map do |record|
          {
            "type": record["tipo_exame"],
            "limits": record["limites_tipo_exame"],
            "result": record["resultado_tipo_exame"]
          }
        end
      }
    end

    output_data.to_json
  end
end

