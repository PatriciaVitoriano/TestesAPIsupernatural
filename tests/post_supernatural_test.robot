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
    

Teste de Adicionar de Usuário
    Criar sessão
    Entrar com usuário sysadmin
    Validar o token
    Adicionar um novo usuário





