# Robot Framework Tests API com GitHub Actions

Este repositório contém um workflow do GitHub Actions configurado para executar testes automatizados usando o Robot Framework.

## Passo a Passo para Configuração e Execução do Workflow

### 1. Checkout do Repositório

O primeiro passo do workflow realiza o checkout do repositório atual utilizando a ação `actions/checkout@v2`.

### 2. Configuração da Versão do Python

Em seguida, o workflow configura a versão do Python necessária para os testes. A versão configurada é '3.x'.

### 3. Instalação de Dependências

Após configurar a versão do Python, o workflow instala as dependências necessárias para o Robot Framework e suas bibliotecas associadas, como `robotframework`, `robotframework-requests` e `robotframework-seleniumlibrary`.

### 4. Execução dos Testes do Robot Framework

Depois de instalar as dependências, o workflow executa os testes do Robot Framework utilizando o comando `robot -d results tests`. Este comando executa os testes e salva os resultados no diretório 'results'.

### 5. Arquivamento dos Resultados

Por fim, o workflow arquiva os resultados dos testes executados como um artefato do GitHub Actions. Isso permite que você acesse e analise os resultados dos testes após a execução do workflow.

## Execução do Workflow

O workflow é acionado automaticamente em cada push para o repositório.

## Próximos Passos

Após configurar e executar o workflow do GitHub Actions, você pode monitorar a execução dos testes e acessar os resultados no GitHub Actions.

