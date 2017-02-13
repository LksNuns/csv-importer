# CSV IMPORTER

`ruby 2.3.1` `rails 4.2.7.1`

Sobre
Sistema simples que realiza a importação de um arquivo csv e adiciona os dados em uma tabela.

# CSV IMPORTER
`ruby 2.3.1`
`rails 4.2.7.1`

### Sobre
Sistema simples que realiza a importação de arquivos `csv` e adiciona os dados em uma tabela.

### Frontend
O aplicativo foi desenvolvido utilizando `bootstrap 3` para ser responsivo.

### Backend
Para a realização da conversão do arquivo `csv`, foi criada a classe `SaleCsvParser` que se encontra no diretório `app/csv_parsers`.
Também foi usado a gem interactor-rails para a melhor organização do controller

### Banco de dados
Como o objetivo não era a modelagem do banco de dados, os campos `buyer` `address` e `provider` foram criados como string diretamente na tabela `sales` ao invés de se criar chaves estrangeiras e tabelas específicas para estes campos.
Também foi utilizada a gem `money-rails` para melhor controle e facilidade com o campo `amount`

### Testes
Para a realização do projeto foram realizados testes para `models`, `controllers`, `features` utilizando o `capybara`, `interactors`, `parsers`.
Também para o teste utilizando o `capybara` foi utilizdo o padrão `Page Object`.

### Como Rodar
```
rake db:create && rake db:migrate && rake db:seeds
rails s
```
#### Acessar:
```localhost:3000```

#### Modelo de arquivo CSV:
Um arquivo de modelo `csv` está no root do projeto com o nome de `sale_dados.csv`.
