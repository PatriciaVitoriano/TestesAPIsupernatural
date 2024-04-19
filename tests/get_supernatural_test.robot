*** Settings ***
Resource    ../resources/supernatural_testes_recursos.resource


*** Variables ***


*** Test Cases ***
Entrar com usuário sysadmin
    Desativar Avisos TLS
    Criar sessão
    Entrar com usuário sysadmin

Teste para validar o token
    Desativar Avisos TLS
    Criar sessão
    Entrar com usuário sysadmin
    Validar o token
    

Teste listar Departamentos
    Criar sessão
    Entrar com usuário sysadmin
    Validar o token
    Listar Departamentos

Teste para contar Departamentos
    Criar sessão
    Entrar com usuário sysadmin
    Validar o token
    Contar Departamentos

Teste Listar Departamento Específico
    Criar sessão
    Entrar com usuário sysadmin
    Validar o token
    ${department_id}=    Set Variable    65fe0cd72666bf11c8208db2
    Listar Departamento Específico       ${department_id}

