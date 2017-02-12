module ValidateSaleCsvFile
  def verify_file_exist(path)
    raise "Nenhum arquivo foi selecionado." if path.blank?
    raise "Arquivo não encontrado." unless File.exists? path
  end

  def verify_structure(file)
    columns = [
      "comprador",
      "descricao",
      "preco_unitario",
      "quantidade",
      "endereco",
      "fornecedor"
    ] - file.headers

    return if columns.empty?

    not_founded = columns.to_sentence(words_connector: ', ',
                                      two_words_connector: ' e ',
                                      last_word_connector: ''
                                      )
    raise "As seguintes colunas não foram encontradas: #{not_founded}"
  end

  def verify_content_type(path)
    content_type = [
      "text/plain",
      "text/x-csv",
      "text/plain",
      "text/csv",
      "text/comma-separated-values",
      "text/x-comma-separated-values",
      "text/tab-separated-values",
      "text/x-csv",
      "application/vnd.ms-excel",
      "application/csv",
      "application/x-csv",
    ].include? MIME::Types.type_for(path).first.content_type
    return if content_type
    raise "Formato inválido de arquivo."
  end
end
