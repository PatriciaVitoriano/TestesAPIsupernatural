*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes
Library   RequestsLibrary
Library   String
Library   Collections
Library   OperatingSystem


*** Variables ***


${BASE_URL}            https://supernatural.qacoders-academy.com.br
${LOGIN_ENDPOINT}      api/login
${POST_ENDPOINT}       api/user
${GET_ENDPOINT}        api/department
${COUNT_ENDPOINT}      api/department/count
${USERNAME}            sysadmin@qacoders.com
${PASSWORD}            1234@Test             
             
*** Keywords ***

Desativar Avisos TLS
    ${result}=    Evaluate    urllib3.disable_warnings()    urllib3
    Log    Avisos de TLS/SSL desativados: ${result}
    RETURN    ${result}

Criar sessão
    ${headers}  Create Dictionary  Accept=application/json  Content-Type=application/json
    Create Session    alias=supernatural    url=https://supernatural.qacoders-academy.com.br  headers=${headers}

Entrar com usuário sysadmin
    ${body}  Create Dictionary  mail=sysadmin@qacoders.com  password=1234@Test
    Log  ${body}
    Criar sessão
    ${resposta}  POST On Session  alias=supernatural  url=/api/login  json=${body}
    Log  ${resposta.json()}
    Set Test Variable    ${TOKEN}  ${resposta.json()["token"]}

Validar o token
    ${headers}=  Create Dictionary  Authorization=Bearer ${TOKEN}
    ${resposta}=  GET On Session  alias=supernatural  url=/api/validateToken  headers=${headers}
    
    # Convertendo a resposta para string antes de registrar como log
    ${resposta_str}=  Convert To String  ${resposta.content}
    
    # Verificando se a resposta é inválida
    Should Be Equal As Strings  ${resposta.json()["valid"]}  False



Adicionar um novo usuário
    Desativar Avisos TLS
    
    Create Session    MinhaSessão    ${BASE_URL}
    ${url}=    Set Variable    ${POST_ENDPOINT}?token=${TOKEN}    # Usando a variável global ${TOKEN}
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    Accept=application/json

    ${first_name}=  Generate Random String  length=5  chars=abcdefghijklmnopqrstuvwxyz
    ${last_name}=  Generate Random String  length=5  chars=abcdefghijklmnopqrstuvwxyz
    
    ${full_name}=  Set Variable  ${first_name.capitalize()} ${last_name.capitalize()}  # Primeira letra em maiúscula
    
    ${random_number}=  Generate Random String  length=6  chars=0123456789  # Aumentado o número de caracteres
    ${mail}=  Set Variable  ${first_name}@qacoders.com.br  # Utilizando o nome completo gerado
    
    ${cpf}=  Generate Random String  length=11  chars=0123456789
    
    ${body}=  Create Dictionary  
        ...  fullName=${full_name}
        ...  mail=${mail}  
        ...  password=${PASSWORD}
        ...  accessProfile=ADMIN  
        ...  cpf=${cpf}
        ...  confirmPassword=${PASSWORD}
        
    ${response}=  Evaluate  requests.post(url="${BASE_URL}/api/user", headers=${headers}, json=${body}, verify=False).json()
    
    # Log da resposta da requisição
    Log  ${response}
    
    Should Not Contain  ${response}  Failed to authenticate token.

Listar Departamentos
    Create Session    MinhaSessão    ${BASE_URL}
    ${url}=    Set Variable    ${GET_ENDPOINT}?token=${TOKEN}    # Usando a variável global ${TOKEN}
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    Accept=application/json
    ${get_response}=    GET On Session    MinhaSessão    ${url}    headers=${headers}
    Should Be Equal As Strings    ${get_response.status_code}    200
    Log    ${get_response.json()}

    ${departments_list}=    Convert To List    ${get_response.json()}    # Converte o resultado para uma lista
    ${first_department}=    Get From List    ${departments_list}    0    # Pega o primeiro departamento da lista
    Should Not Be Equal As Strings    ${first_department}    ${None}    # Verifica se o primeiro departamento não é None
    Log    First Department: ${first_department}

    
Contar Departamentos
    Create Session    MinhaSessão    ${BASE_URL}
    ${url}=    Set Variable    ${COUNT_ENDPOINT}?token=${TOKEN}
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    Accept=application/json
    ${count_response}=    GET On Session    MinhaSessão    ${url}    headers=${headers}
    Should Be Equal As Strings    ${count_response.status_code}    200
    Log    ${count_response.json()}
    
    ${count}=    Get From Dictionary    ${count_response.json()}    count    default=None
    Should Not Be Equal As Strings    ${count}    ${None}
    Log    Total de Departamentos: ${count}


Listar Departamento Específico
    [Arguments]    ${department_id}
    
    Create Session    MinhaSessão    ${BASE_URL}
    ${url}=    Set Variable    ${GET_ENDPOINT}/${department_id}?token=${TOKEN}
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    Accept=application/json
    ${response}=    GET On Session    MinhaSessão    ${url}    headers=${headers}
    
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.json()}





