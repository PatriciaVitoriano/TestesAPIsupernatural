# Robot Framework Tests API com GitHub Actions

Este repositório contém um workflow do GitHub Actions configurado para executar testes de API automatizados usando o Robot Framework.

## Estrutura do Arquivo YAML do Workflow

O arquivo `yml` do workflow define os seguintes passos:

```yaml
name: Robot Framework Tests
on: push

jobs:
  test:
    name: Run Tests
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Repository
      uses: actions/checkout@v2

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.x'

    - name: Install dependencies
      run: |
        pip install robotframework
        pip install robotframework-requests
        pip install robotframework-seleniumlibrary

    - name: Run Robot Framework tests
      run: |
        robot -d results tests

    - name: Archive Robot Framework results
      if: ${{ always() }}
      uses: actions/upload-artifact@v3
      with:
        name: robot-results
        path: ./results

Após configurar o workflow do GitHub Actions, você pode monitorar a execução dos testes
 e o upload dos resultados no GitHub Actions.
