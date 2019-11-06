---
layout: tutorial
title: Servidor MobileFirst, mensagens de tempo de execução e console
breadcrumb_title: Foundation Server
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Visão Geral
{: #overview }
Encontre informações para ajudar a resolver problemas que você pode encontrar com o Mobile Foundation Server.

## Mensagens de tempo de execução do Mobile Foundation
{: #mfp-runtime-error-codes }
**Prefixo:** FWLSE<br/>
**Intervalo:** 0000-0012

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE0000E** | *Não foi possível armazenar AutorizationGrant {0} no TransientStorage.* |
| **FWLSE0001E** | *Falha ao recuperar o cliente {0}.* |
| **FWLSE0002E** | *Solicitação inválida, parâmetros ausentes ou inválidos: {0}.* |
| **FWLSE0003E** | *Tipo de concessão não suportado {0}.* |
| **FWLSE0004E** | *RedirectUri foi passado para terminal de autorização: {0}, mas não foi passado para terminal de token.* |
| **FWLSE0005E** | *Conflito de RedirectUri. Terminal de autorização: {0}, terminal de token: {1}.* |
| **FWLSE0006E** | *Falha ao analisar código de concessão a partir da solicitação de token: {0}.* |
| **FWLSE0007E** | *A validação do código de concessão falhou. O código de concessão {0} foi fornecido para o clientId {1}, mas usado por clientId {2}.* |
| **FWLSE0008E** | *AccessToken de análise de ação falhou com exceção.* |
| **FWLSE0009E** | *Não é possível assinar token de acesso.* |
| **FWLSE0010E** | *Não é possível validar JWT, error no keystore do servidor.* |
| **FWLSE0011E** | *Não é possível validar JWT, {0}.* |
| **FWLSE0012E** | *A autenticação do cliente JWT falhou - jti inválido.* |


### Mensagens do adaptador Java

**Prefixo:** FWLSE<br/>
**Intervalo:** 0290-0299

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE0290E** | *Classe de aplicativo JAXRS: {0} não foi localizada (ou não pode ser carregada). Certifie-se de que o nome da classe no arquivo xml do adaptador esteja correto e que a classe realmente exista na pasta bin do adaptador ou em um dos jars da pasta lib do adaptador.* |
| **FWLSE0291E** | *Classe de aplicativo JAXRS: {0} não pode ser instanciada. Certifique-se de que a classe tenha um construtor de argumentos zero público. Se houver um construtor, consulte o log do servidor para ver a causa raiz para a falha na criação da instância.* |
| **FWLSE0292E** | *Classe de aplicativo JAXRS: {0} deve estender javax.ws.rs.Application.* |
| **FWLSE0293E** | *Implementação do adaptador falhou. O tipo de propriedade {0} não é suportado.* |
| **FWLSE0294E** | *Implementação do adaptador falhou. O valor {0} é ilegal para o tipo {1}.* |
| **FWLSE0295E** | *Implementação de configuração do adaptador falhou. A propriedade {0} não está definida no adaptador {1}.* |
| **FWLSE0296E** | *Implementação de configuração do adaptador falhou. A propriedade {0} é inválida para o tipo {1}.* |
| **FWLSE0297W** | *Falha ao gerar a documentação do Swagger para o adaptador {0}.* |
| **FWLSE0298W** | *Procedimento {0} no adaptador {1} tem o atributo 'connectAs' configurado como 'enduser'. Esse recurso não é suportado.* |
| **FWLSE0299E** | *Implementação de configuração de conectividade do adaptador falhou. As propriedades {0} não existem.* |


**Prefixo:** FWLSE<br/>
**Intervalo:** 0500-0506

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE0500E** | *Implementação de configuração de conectividade do adaptador falhou. O parâmetro {0} deve ser um número inteiro.* |
| **FWLSE0501E** | *Implementação de configuração de conectividade do adaptador falhou. O parâmetro {0} deve ser positivo.* |
| **FWLSE0502E** | *Implementação de configuração de conectividade do adaptador falhou. O parâmetro {0} está fora do intervalo.* |
| **FWLSE0503E** | *Implementação de configuração de conectividade do adaptador falhou. O parâmetro {0} deve ser um booleano.* |
| **FWLSE0504E** | *Implementação de configuração de conectividade do adaptador falhou. O {0} deve ser http ou https.* |
| **FWLSE0505E** | *Implementação de configuração de conectividade do adaptador falhou. A política de cookies {0} não é suporte.* |
| **FWLSE0506E** | *Implementação de configuração de conectividade do adaptador falhou. O parâmetro {0} deve ser uma sequência.* |

### Mensagens de registro

**Prefixo:** FWLSE<br/>
**Intervalo:** 4200-4229

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE4200E** | *O status do aplicativo do dispositivo de mudança falhou.* |
| **FWLSE4201E** | *O status do dispositivo de mudança falhou.* |
| **FWLSE4202E** | *Obtenção de dispositivos falhou.* |
| **FWLSE4203E** | *Remoção de dispositivos falhou.* |
| **FWLSE4204E** | *Obtenção de clientes associados ao dispositivo falhou.* |
| **FWLSE4205E** | *getAll para pageInfo: {0} falhou.* |
| **FWLSE4206E** | *GetByAttributes falhou.* |
| **FWLSE4207E** | *Não foi possível converter dados em dados persistentes.* |
| **FWLSE4208E** | *Falha ao ler o cliente {0}.* |
| **FWLSE4209E** | *Falha ao atualizar nome de exibição do dispositivo.* |
| **FWLSE4210E** | *Não é possível criar assinatura.* |
| **FWLSE4211E** | *Falha ao armazenar dados de registro do cliente porque ele não foi recuperado corretamente. ID do Cliente: {0}.* |
| **FWLSE4212E** | *Falha ao atualizar nome de exibição em todos os clientes do dispositivo.* |
| **FWLSE4213E** | *A autenticação do cliente JWT falhou - as chaves públicas não correspondem.* |
| **FWLSE4214E** | *Os dados do cliente são nulos - isso pode acontecer se os dados do cliente tiverem sido arquivados (excluídos) apenas agora.* |
| **FWLSE4215E** | *Tentando acessar o console várias vezes, desistindo.* |
| **FWLSE4216E** | *GetDeviceClientsError por deviceId: {0}.* |
| **FWLSE4217E** | *Error ao tentar obter dispositivos com pageStart: {0} e pageSize: {1}.* |
| **FWLSE4218E** | *Error ao tentar obter dispositivos para o nome: {0} com pageStart: {1} e pageSize: {2}.* |
| **FWLSE4219E** | *RemoveDeviceError para deviceId: {0}.* |
| **FWLSE4220E** | *Falha ao criar chave da web para o cliente {0}.* |
| **FWLSE4221E** | *Os dispositivos de procura falharam com pageInfo: {0}, searchMethod: {1} e filtro: {2}.* |
| **FWLSE4222E** | *Registro de cliente falhou - assinatura inválida.* |
| **FWLSE4223E** | *Registro de cliente falhou - aplicativo inválido. erro: {0}.* |
| **FWLSE4224E** | *Falha ao processar solicitação de registro.* |
| **FWLSE4225E** | *Solicitação de autorregistro de atualização inválido, assinatura do cliente não pôde ser verificada.* |
| **FWLSE4226E** | *Falha na autenticidade do aplicativo na atualização de registro, atualização falhou {0}.* |
| **FWLSE4227E** | *Falha ao atualizar registro.* |
| **FWLSE4228E** | *Falha de applyRegistrationValidations no registro, removendo o cliente {0}.* |
| **FWLSE4229W** | *Releitura do contexto do cliente inicializado, as mudanças podem ser perdidas.* |

### Mensagens do Aplicativo

**Prefixo:** FWLST<br/>
**Intervalo:** 0100-0106

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLST0100E** | *tentativa de acessar a atualização direta para um aplicativo que nunca foi associado à segurança de atualização direta.* |
| **FWLST0101E** | *Nenhum aplicativo com o nome: {0} encontrado.* |
| **FWLST0102E** | *não é possível concluir a atualização direta devido a {0}.* |
| **FWLST0110E** | *tentativa de acessar a atualização nativa para um aplicativo que nunca foi associado à segurança de atualização nativa.* |
| **FWLST0111E** | *Nenhum aplicativo com o nome: {0} encontrado.* |
| **FWLST0112E** | *não é possível concluir a atualização nativa devido a {0}.* |
| **FWLST0120E** | *tentativa de acessar a atualização do modelo para um aplicativo que nunca foi associado à segurança de atualização do modelo.* |
| **FWLST0121E** | *Nenhum aplicativo com o nome: {0} encontrado.* |
| **FWLST0122E** | *não é possível concluir a atualização do modelo devido a {0}.* |
| **FWLST0103E** | *Perfil de log do cliente inválido, nível não deve ser nulo.* |
| **FWLST0104E** | *Perfil de log do cliente inválido, localizado mais de um perfil global.* |
| **FWLST0105E** | *Não é possível fazer upload do arquivo de log do usuário devido a {0}.* |
| **FWLST0106E** | *Implementação de aplicativo falhou. O ID do aplicativo {0} é ilegal. O ID do aplicativo pode conter somente a-z, A-Z, _-. .* |

### Mensagens do adaptador JavaScript

**Prefixo:** FWLST<br/>
**Intervalo:** 0900-0906

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLST0900E** | *A implementação do descritor do adaptador falhou. Keystore inválido.* |
| **FWLST0901W** | *O alias de SSL {0} não existe no keystore. Chamadas de backend que requerem o keystore falharão.* |
| **FWLST0902W** | *O alias de SSL existe no descritor, mas sem senha. Chamadas de backend que requerem o keystore falharão.* |
| **FWLST0902W** | *Senha SSL existe no descritor, mas sem alias. Chamadas de backend que requerem o keystore falharão.* |
| **FWLST0903W** | *Alias e senha SSL inválidos. Chamadas de backend que requerem o keystore falharão.* |
| **FWLST0904E** | *Exceção foi lançada ao chamar procedimento: {0} no adaptador: {1}.* |
| **FWLST0905E** | *Implementação do adaptador falhou. O driver SQL {0} não foi localizado nos recursos do adaptador.* |
| **FWLST0906E** | *Exceção foi lançada ao chamar o SQL {0}.* |


**Prefixo:** FWLSE<br/>

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE0014W** | *O parâmetro {0} não é conhecido e será ignorado.* |
| **FWLSE0152E** | *Não é possível localizar cadeia de certificados com alias: {0}.* |
| **FWLSE0207E** | *Falha ao ler a partir do fluxo de entrada de resposta HTTP.* |
| **FWLSE0299W** | *Resposta para solicitação: {0} retornada em 0ms. A investigação do fluxo de mensagens HTTP é necessária.* |
| **FWLSE0310E** | *Falha de análise de JSON.* |
| **FWLSE0311E** | *Falha de análise ou de transformação de XML.* |
| **FWLSE0318I** | *{0}.* |
| **FWLSE0319W** | *O tipo de conteúdo de resposta de backend {0} não correspondeu ao tipo de conteúdo esperado {1}, continuar processando a resposta. Os cabeçalhos e o corpo da solicitação e da resposta: {2}.* |
| **FWLSE0330E** | *Não é possível inicializar o contexto SSL do WebSphere.* |


### Mensagens principais

**Prefixo:** FWLST<br/>

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLST3022W** | *Pasta {0} não é gravável. O diretório inicial baseado em usuário será usado.* |
| **FWLST3023E** | *O projeto {0} falhou ao iniciar: não foi possível criar o diretório {1}.* |
| **FWLST3024I** | *O servidor MFP está usando a pasta {0} como cache de sistema de arquivos.* |
| **FWLST3025W** | *O relatório de analítica do servidor MFP está desativado devido à URL vazia na configuração do registro.* |
| **FWLST3026W** | *O servidor MFP teve um erro ao chamar o serviço de analítica: {0}.* |
| **FWLST3027I** | *Configuração alterada. O servidor analítico agora está ativado em: {0}.* |
| **FWLST4047W** | *A versão do produto não pôde ser localizada. Procurado em arquivo denominado: {0} e propriedade denominada: {1}.* |
| **FWLST4048W** | *A versão de tempo de execução não pôde ser localizada. Procurado em arquivo denominado: {0} e propriedade denominada: {1}.* |

### Mensagens de Segurança

**Prefixo:** FWLSE<br/>
**Intervalo:** 4010-4068

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE4010E** | *Não é possível ler arquivo zip de implementação do keystore. |
| **FWLSE4011E** | *Arquivo Zip não inclui arquivo keystore.* |
| **FWLSE4012E** | *Arquivo Zip não inclui arquivo de propriedades.* |
| **FWLSE4016E** | *O tipo do algoritmo de certificado keystore não é RSA. Siga o guia do console para criar um keystore
com um algoritmo RSA.* |
| **FWLSE4017E** | *Não é possível criar o keystore. Keystore: tipo: {0}.* |
| **FWLSE4018E** | *Alguns algoritmos criptográficos não são suportados nesse ambiente. Keystore: tipo: {0}.* |
| **FWLSE4019E** | *Esta exceção indica um de vários problemas de certificado. Keystore: tipo: {0}.* |
| **FWLSE4021E** | *Não é possível criar o keystore. Caminho: tipo: {0}.* |
| **FWLSE4022E** | *Não é possível recuperar chave do keystore. Keystore: tipo: {0}.* |
| **FWLSE4023E** | *Não é possível extrair chave privada a partir do KeyStore, alias ausente ou inválido. alias: {0}.* |
| **FWLSE4024W** | *Duplicar a configuração para a verificação de segurança {0} neste adaptador. Configuração usada: {1}.* |
| **FWLSE4025W** | *A verificação de segurança {0} já estava configurada em um adaptador diferente, a nova configuração não será utilizada.* |
| **FWLSE4026E** | *Classe {1} para verificação de segurança {0} não foi localizada.* |
| **FWLSE4027E** | *Não é possível criar verificação de segurança {0}. classe: {1}, erro: {2}.* |
| **FWLSE4028E** | *Classe {1} para verificação de segurança {0} não implementa a interface SecurityCheck.* |
| **FWLSE4029E** | *A implementação de dados de autenticidade falhou. Mensagem de Erros: {0}.* |
| **FWLSE4030E** | *Mapeamento de elemento de escopo duplicado foi localizado para o elemento de escopo {0}, mapeamento usado: {1}.* |
| **FWLSE4031E** | *Configuração de verificação de segurança duplicada foi localizada para verificação de segurança {0}.* |
| **FWLSE4032E** | *O descritor de aplicativo do aplicativo {0} contém uma configuração para verificação de segurança {1}. A verificação de segurança está ausente ou houve uma tentativa de removê-la.* |
| **FWLSE4033E** | *O descritor de aplicativo do aplicativo {0} contém uma configuração para verificação de segurança {1}. A configuração de verificação de segurança não pôde ser aplicada.* |
| **FWLSE4034E** | *A verificação de segurança {0} tem um erro de configuração para o parâmetro {1}: {2}.* |
| **FWLSE4035W** | *A verificação de segurança ''{0}'' tem um aviso de configuração para o parâmetro {1}: {2}.* |
| **FWLSE4036W** | *O descritor de aplicativo do aplicativo {0} contém uma configuração para um escopo do aplicativo obrigatório {1}. Um ou mais dos elementos do escopo estão ausentes ou houve uma tentativa de removê-los.* |
| **FWLSE4037E** | *A verificação de segurança {0} não pode ter o mesmo nome que um mapeamento de elemento de escopo.* |
| **FWLSE4038E** | *O descritor de aplicativo do aplicativo {0} contém uma configuração para um escopo {1} que é mapeado para a verificação de segurança {2}. A verificação de segurança está ausente ou houve uma tentativa de removê-la.* |
| **FWLSE4039W** | *Elemento do escopo vazio não pode ser mapeado. Tentando mapear para: {0}.* |
| **FWLSE4040E** | *O campo {0} para configuração do adaptador não está formatado corretamente.* |
| **FWLSE4041W** | *Caractere ilegal usados no elemento de escopo {0}. Os caracteres legais incluem letras, números, '-' e '_'.* |
| **FWLSE4042I** | *Configuração da verificação de segurança {0} para o parâmetro {1}: {2}.* |
| **FWLSE4043E** | *A expiração máxima de token do aplicativo deve ser positiva. Configurado: {0}.* |
| **FWLSE4044I** | *O usuário {0} é autenticado por meio da segurança SSO Baseada em Ltpa.* |
| **FWLSE4045I** | *O usuário NÃO é autenticado por meio da segurança de SSO baseada em Ltpa.* |
| **FWLSE4046** | *Verificando se o dispositivo desativado para registro falhou com exceção.* |
| **FWLSE4047:** | *O valor máximo de expiração de token para o aplicativo {0} é maior que o limite de expiração. Valor: {1}, limite de expiração: {2}.* |
| **FWLSE4048E** | *Falha ao validar o token de acesso com o servidor AZ externo {0}.* |
| **FWLSE4049E** | *Falha nas verificações de segurança de pedidos.* |
| **FWLSE4050E** | *Dados do cliente inválidos.* |
| **FWLSE4051E** | *O aplicativo não existe.* |
| **FWLSE4052E** | *Falha ao ler verificações de segurança externalizadas. Limpeza de contexto inicializada para cliente: {0}.* |
| **FWLSE4053E** | *A verificação de segurança não existe - {0}.* |
| **FWLSE4054E** | *Falha ao externalizar as verificações de segurança. As verificações de segurança são excluídas para o cliente: {0}.* |
| **FWLSE4055E** | *Falha ao obter a expiração do escopo, 0 retornados.* |
| **FWLSE4056E** | *A introspecção falhou com exceção.* |
| **FWLSE4057E** | *Resultado de validação de token inesperado: {0}.* |
| **FWLSE4058E** | *Erro ao codificar cabeçalho e carga útil.* |
| **FWLSE4059E** | *Falha ao criar objeto de cabeçalho a partir do cabeçalho decodificado: {0}.* |
| **FWLSE4060E** | *Falha ao criar objeto de carga útil a partir da carga útil decodificada: {1}.* |
| **FWLSE4061E** | *Erro ao codificar header64 + payload64.* |
| **FWLSE4062E** | *Erro ao codificar cabeçalho para assinar ou ao criar cabeçalho.* |
| **FWLSE4063E** | *Erro ao codificar a carga útil.* |
| **FWLSE4064E** | *O cliente não tem permissão para o escopo {0}.* |
| **FWLSE4065E** | *O cliente é desautorizado.* |
| **FWLSE4066E** | *Fluxo de concessão implícita está disponível apenas para a UI do Swagger.* |
| **FWLSE4067E** | *O cliente é desautorizado.* |
| **FWLSE4068E** | *O cliente é desautorizado.* |


### Mensagens de persistência do servidor

**Prefixo:** FWLSE<br/>
**Intervalo:** 3000-3009

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE3000E** | *Ligação de JNDI de origem de dados não encontrada para nomes: {0} e {1}.* |
| **FWLSE3001E** | *Não é possível serializar Lista para a matriz json.* |
| **FWLSE3002E** | *Não é possível criar item de dados persistente: {0}.* |
| **FWLSE3003E** | *Problema de desserialização de matriz JSON.* |
| **FWLSE3004E** | *Não é possível ler a coluna de valor CLOB.* |
| **FWLSE3005E** | *Não é possível serializar Lista para a matriz json.* |
| **FWLSE3006E** | *Não foi possível iniciar a transação: {0}.* |
| **FWLSE3007E** | *Erro inesperado encontrado.* |
| **FWLSE3008E** | *Não foi possível gerar o hash.* |
| **FWLSE3009E** | *Ocorreu um erro ao tentar confirmar a transação.* |

### Mensagens de war do servidor

**Prefixo:** FWLSE<br/>
**Intervalo:** 3100-3103

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE3100E** | *Modo de servidor de autorização não reconhecido: {0}.* |
| **FWLSE3101E** | *Entrada Jndi {0} não localizada, modo de servidor de autorização desconhecido.* |
| **FWLSE3102I** | *Falha ao reunir anotações para a classe {0}. A UI do Swagger pode ter algum escopo ausente.* |
| **FWLSE3103I** | *Falha ao determinar a classe para o bean {0}. A UI do Swagger pode ter alguns escopos ausentes.* |
| **FWLSE3103I** | *Iniciando com o servidor de autorizações integrado.* |
| **FWLSE3103I** | *Iniciando com integração de servidor de autorização externa.* |

### Mensagens de Licença

**Prefixo:** FWLSE<br/>

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE0277I** | *Criando um registro ILMT no arquivo {0}.* |
| **FWLSE0278I** | *O diretório ILMT padrão {0} não pode ser usado.* |
| **FWLSE0279E** | *Falha ao criar um registro ILMT.* |
| **FWLSE0280I** | *Modo de Depuração ILMT ativado pela variável de ambiente {0}.* |
| **FWLSE0281E** | *Falha ao criar um criador de logs ILMT.* |
| **FWLSE0282I** | *Usando o diretório ILMT {0}.* |
| **FWLSE0283E** | *O diretório ILMT não é compatível. É possível configurar um diretório apropriado para uma propriedade denominada 'license.metric.logger.output.dir' no arquivo 'license_metric_logger.properties' e utilizar a propriedade JVM '-Dlicense_metric_logger_configuration=\<path to license_metric_logger.properties\>'.* |
| **FWLSE0284E** | *Falha ao recuperar o caminho no qual esta instância {0} está em execução. Isso não é compatível com ILMT.* |
| **FWLSE0286I** | *Exceção inesperada.* |
| **FWLSE0287E** | *Falha ao criar um registro ILMT porque o ILMT Logger não foi inicializado corretamente. Isso não é compatível com ILMT. Revise os arquivos de log para localizar a causa do erro de inicialização.* |
| **FWLSE0367E** | *Dados de Relatório de Licença ausentes. Falha ao criar um registro ILMT.* |

### Mensagens de limpeza

**Prefixo:** FWLSE<br/>
**Intervalo:** 0290-0292

| **FWLSE0290I** | *Concluída a exclusão de {0} registros em {1} ms.* |
| **FWLSE0291I** | *Concluída a exclusão de {0} lotes em {1} ms.* |
| **FWLSE0292I** | *A exclusão de dados persistentes recomendável é para registros com mais de {0} dias.* |

### Outras Mensagens

**Prefixo:** FWLSE<br/>

| **FWLSE0211W** | *Intervalo de desatribuição recomendado ({0}) é de 86400 segundos, que é 1 dia.* |
| **FWLSE0801E** | *O utilitário de decodificador de senha, com.ibm.websphere.crypto.PasswordUtil, não está disponível. Não é possível suportar senha criptografada para {0}.* |
| **FWLSE0802E** | *Não é possível decodificar a senha para {0}.* |
| **FWLSE0803E** | *Não é possível localizar a mensagem para o id {0} no pacote configurável {1} "+". Erro:{2}.* |
| **FWLSE0802E** | *Não é possível decodificar a senha para {0}.* |



## Mensagens de serviço de administração do Mobile Foundation
{: #admin-services-error-codes }
<!-- Messages taken from mfp-admin-services/mfp-admin-util/src/main/resources/com/ibm/worklight/admin/resources/messages.properties-->
**Prefixo:** FWLSE<br/>
**Intervalo:** 3000-3299

| **Código de Erro**  | **Descrição** |
|-----------------|-----------------|
| **FWLSE3000E** | **Um erro do servidor foi detectado.** |
| **FWLSE3001E** | **Um conflito foi detectado.** |
| **FWLSE3002E** | **O recurso não foi localizado.** |
| **FWLSE3003E** | **O tempo de execução não pode ser incluído uma vez que sua carga útil não contém nome.** |
| **FWLSE3010E** | **Um erro de banco de dados foi detectado.** <br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, desconfigure a base de dados. |
| **FWLSE3011E** | **O número da porta "{0}" da propriedade JNDI mfp.admin.proxy.port não é válido.** <br/><br/>{0} é o número da porta, por exemplo, 9080.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, configure a propriedade JNDI mfp.admin.proxy.port para um valor nonsense.  Em seguida, abra o Operations Console. Eventualmente, a mensagem aparecerá nos logs do servidor. |
| **FWLSE3012E** | **Erro de conexão JMX. Motivo: "{0}". Verifique os logs do servidor de aplicativos para obter detalhes.** <br/><br/>{0} é uma mensagem de erro proveniente do protocolo JMX do servidor da web.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, desconfigure o JMX de forma que ele lança exceções. |
| **FWLSE3013E** | **Tempo limite ao tentar obter o bloqueio de transação após {0} milissegundos.** <br/><br/>{0} é o número de milissegundos, por exemplo, 32000.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso acontece com uma base de dados conectada por meio de uma rede instável ou lenta. |
| **FWLSE3017E** | **Um erro de banco de dados foi detectado: {0}. Motivo: {1}** <br/><br/>{0} é a mensagem de erro do cloudant.<br/>{1} é a mensagem do motivo do cloudant.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, desconfigure o Cloudant. |
| **FWLSE3018E** | **A operação do Cloudant não foi concluída dentro de {0} milissegundos.** <br/><br/>{0} é o número de milissegundos, por exemplo, 32000.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, use
o Cloudant DB e configure a propriedade JNDI mfp.db.cloudant.documentOperation.timeout para 1. Se a conexão com o cloudant estiver lenta, abra o Operations Console. Eventualmente, a mensagem aparecerá nos logs do servidor. |
| **FWLSE3019E** | **Não é possível obter bloqueio de transação. Motivo: {0}** <br/><br/>{0} é alguma mensagem de exceção que foi retornada externamente. Pode ser qualquer sequência.  <br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, pode ser reproduzido quando você tiver um farm com o Cloudant e encerrar o mestre de bloqueio enquanto uma operação de bloqueio está em andamento. Em seguida, abra o Operations Console.  Eventualmente, a mensagem aparecerá nos logs do servidor. |
| **FWLSE3021E** | **Tempo limite ao tentar obter o bloqueio de transação após {0} milissegundos. Aumente a propriedade {1}.**<br/><br/>{0} é o número de milissegundos, por exemplo, 32000.<br/>{1} é o nome da propriedade JNDI a partir da qual o tempo limite é obtido.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso acontece com uma base de dados conectada por meio de uma rede instável ou lenta. |
| **FWLSE3030E** | **O tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.** <br/><br/>**Em que:** {0} é o nome do tempo de execução (qualquer sequência).<br/><br/>Esse erro ocorre quando o {{site.data.keys.mf_server }} não é capaz de carregar o tempo de execução armazenado no banco de dados.  O [APAR PI71317](http://www-01.ibm.com/support/docview.wss?uid=swg1PI71317) foi liberado para tratar algumas ocorrências desta mensagem.  Se o nível de correção do servidor for anterior a **iFix 8.0.0.0-IF20170125-0919**, faça upgrade para o [iFix mais recente](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all). |
| **FWLSE3031E** | **O tempo de execução "{0}" não pode ser incluído ou excluído desde que ele ainda esteja em execução.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência). |
| **FWLSE3032E** | **O tempo de execução "{0}" não pode ser incluído, pois ele já existe.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência). |
| **FWLSE3033E** | **O tempo de execução "{0}" não está vazio, mas você solicitou a exclusão do tempo de execução apenas quando ele estiver vazio.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência).<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, exclua um tempo de execução interrompido que ainda contém aplicativos. |
| **FWLSE3034E** | **O aplicativo "{1}" para o tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência).<br/>{1} é o nome do aplicativo (qualquer sequência). |
| **FWLSE30302E** | **A configuração de licença para o aplicativo "{1}" para o tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência).<br/>{1} é o nome do aplicativo (qualquer sequência). |
| **FWLSE30303E** | **A configuração de licença não pode ser excluída já que o aplicativo "{1}" para o tempo de execução "{0}" existe no banco de dados de administração do MobileFirst ou a configuração de licença não existe.** <br/>{0} é o nome do tempo de execução (qualquer sequência).<br/>{1} é o nome do aplicativo (qualquer sequência). |
| **FWLSE30035E** | **O aplicativo "{1}" não pode ser incluído, uma vez que ele já existe no tempo de execução "{0}".** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência).<br/>{1} é o nome do aplicativo (qualquer sequência).<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> ocorre apenas em testes de unidade |
| **FWLSE3035E** | **O aplicativo "{1}" com o ambiente "{2}" do tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência)<br/>{1} é o nome do aplicativo (qualquer sequência).<br/>{2} é o nome do ambiente: android, ios, ... |
| **FWLSE30304E** | **O AppAuthenticity Data para o aplicativo "{1}" com ambiente "{2}" e versão "{3}" do tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência)<br/>{1} é o nome do aplicativo (qualquer sequência).<br/>{2} é o nome do ambiente: android, ios, ... |
| **FWLSE3036E** | **O aplicativo "{1}" com o ambiente "{2}" e a versão "{3}" do tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência).<br/>{1} é o nome do aplicativo (qualquer sequência).<br/>{2} é o nome do ambiente: android, ios, ... <br/>{3} é a versão: 1,0, 2,0... |
| **FWLSE3037E** | **O ambiente "{1}" com a versão "{2}" não pode ser incluído, uma vez que ele já existe no aplicativo "{0}".** <br/><br/>{0} é o nome do aplicativo (qualquer sequência).<br/>{1} é o nome do ambiente: android, ios, ... <br/>{2} é a versão: 1,0, 2,0...<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> ocorre apenas em testes de unidade |
| **FWLSE3038E** | **O adaptador "{1}" do tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.** <br/><br/>{0} é o nome do tempo de execução (qualquer sequência).  {1} é o nome do adaptador (qualquer sequência). |
| **FWLSE3039E:** | **O adaptador "{0}" não pode ser incluído, uma vez que ele já existe no tempo de execução "{1}".** <br/>{0} é o nome do tempo de execução (qualquer sequência).  {1} é o nome do adaptador (qualquer sequência).<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> ocorre apenas em testes de unidade. |
| **FWLSE3040E** | **O perfil de configuração "{0}" não foi localizado para nenhum tempo de execução no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.** <br/><br/>{0} é o id do perfil de configuração (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, pode ocorrer no log de rastreio ao excluir um perfil de configuração do cliente não existente. |
| **FWLSE3045E** | **Nenhum MBean localizado para a administração do {0}.** <br/><br/>{0} é a palavra MobileFirst.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. |
| **FWLSE3041E** | **Nenhum MBean localizado para o projeto {0} ''{1}''. Possivelmente, o aplicativo da web de tempo de execução {0} para o projeto {0} ''{1}'' não está em execução. Se ele estiver em execução, use o JConsole para inspecionar os MBeans disponíveis. Se ele não estiver em execução, detalhes completos do erro estarão disponíveis nos arquivos de log do servidor.** <br/><br/>{0} é a palavra MobileFirst.  {1} é o nome do projeto/tempo de execução (qualquer sequência) |
| **FWLSE3042E** | **Erro de comunicação com o MBean ''{0}''. Verifique os logs do servidor de aplicativos.** <br/><br/>{0} é o ID canônico do bean gerenciado, que é uma sequência. <br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Pode ocorrer se instalarmos uma biblioteca worklight-jee 6.2 em um servidor MobileFirst 7.1. |
| **FWLSE3043E** | **O MBean denominado ''{0}'' não está mais presente. Verifique os logs do servidor de aplicativos.** <br/><br/>{0} é o ID canônico do bean gerenciado, que é uma sequência. <br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, ocorre no server farm durante o encerramento de um servidor enquanto uma operação de implementação está em andamento. |
| **FWLSE3044E** | **O MBean denominado ''{1}'' não suporta as operações esperadas. Verifique se a versão de tempo de execução {0} é a mesma do que os serviços de administração.** <br/><br/>{0} é a palavra MobileFirst. {1} é o ID canônico do bean gerenciado, que é uma sequência. <br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Pode ocorrer se instalarmos uma biblioteca worklight-jee 6.2 em um servidor MobileFirst 7.1. |
| **FWLSE3050E** | **A operação do MBean retorna um tipo desconhecido. Verifique se a versão de tempo de execução {0} é a mesma dos serviços de administração.** <br/><br/>{0} é a palavra MobileFirst.<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Pode ocorrer se instalarmos uma biblioteca worklight-jee 6.2 em um servidor MobileFirst 7.1. |
| **FWLSE3051E** | **Carga útil inválida. Consulte mensagens adicionais para obter detalhes.** |
| **FWLSE3052E** | **A carga útil a seguir não é reconhecida: "{0}".** <br/><br/>{0} é um extrato da carga útil na sintaxe JSON, por exemplo, "{ a : 0 }" |
| **FWLSE3053E** | **Parâmetros inválidos. Consulte mensagens adicionais para obter detalhes.** |
| **FWLSE3061E** | **O ambiente "{0}" referenciado no arquivo "{1}" do arquivo wlapp é desconhecido. Verifique
se o aplicativo foi construído corretamente.** <br/><br/>{0} é o ambiente: android, ios.  {1} é um nome de arquivo |
| **FWLSE3063E** | **O aplicativo não pode ser implementado desde que a pasta "{0}" esteja ausente no arquivo wlapp. Verifique
se o aplicativo foi construído corretamente.** <br/><br/>{0} é um nome de pasta, por exemplo "meta".<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Implemente uma wlapp que não contenha a meta pasta |
| **FWLSE3065E** | **O aplicativo não pode ser implementado desde que o campo "{0}" esteja ausente no arquivo wlapp. Verifique
se o aplicativo foi construído corretamente.** <br/><br/>{0} é um campo obrigatório, por exemplo, "app.id" |
| **FWLSE3066E** | **O aplicativo não pode ser implementado desde que a versão do aplicativo "{2}" seja diferente da versão do tempo de execução do {0} "{3}". \nUse {1} "{4}" para construir e implementar o aplicativo.** <br/><br/>{0} é a palavra MobileFirst, {1} é o nome do Studio, por exemplo, o MobileFirst Studio, {2} é uma versão do aplicativo: 1,0, 2,0,... {3} é a versão de tempo de execução, {4} é a versão do Studio necessária |
| **FWLSE3067E** | **O aplicativo não pode ser implementado uma vez que a versão do aplicativo é mais antiga do que a versão do tempo de execução {0} "{2}". \nUse {1} "{3}" para construir e implementar o aplicativo.** <br/><br/>{0} é a palavra MobileFirst, {1} é o nome do Studio, por exemplo, o MobileFirst Studio, {2} é a versão de tempo de execução, {3} é a versão do Studio necessária |
| **FWLSE3068E** | **O adaptador não pode ser implementado desde que a versão do adaptador "{2}" seja diferente da versão do tempo de execução do {0} "{3}". \nUse {1} "{4}" para construir e implementar o adaptador.** <br/><br/>{0} é a palavra MobileFirst, {1} é o nome do Studio, por exemplo, MobileFirst Studio, {2} é uma versão do adaptador: 1,0, 2,0,... {3} é a versão de tempo de execução, {4} é a versão do Studio necessária |
| **FWLSE3069E** | **O adaptador não pode ser implementado desde que a versão do adaptador seja mais antiga que a versão do tempo de execução {0} "{2}". \nUse {1} "{3}" para construir e implementar o adaptador.** <br/><br/>{0} é a palavra MobileFirst, {1} é o nome do Studio, por exemplo, o MobileFirst Studio, {2} é a versão de tempo de execução, {3} é a versão do Studio necessária |
| **FWLSE3070E** | **A atualização do aplicativo "{1}" com o ambiente "{2}" e a versão "{3}" falhou porque está bloqueada. Ela pode ser desbloqueada usando o Operations Console {0}.** <br/><br/>{0} é a palavra MobileFirst, {1} é o nome do aplicativo (qualquer sequência), {2} é o ambiente de aplicativo: android, ios... {3} é a versão do aplicativo: 1,0, 2,0, ... |
| **FWLSE3071E** | **Não é possível implementar o aplicativo híbrido "{0}" porque já existe um aplicativo nativo com o mesmo nome.** <br/><br/>{0} é o nome do aplicativo (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Crie um aplicativo nativo e um híbrido de mesmo nome e implemente-os no Operations Console. |
| **FWLSE3072E** | **Não é possível implementar o aplicativo nativo "{0}" porque já existe um aplicativo híbrido com o mesmo nome.** <br/><br/>{0} é o nome do aplicativo (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Crie um aplicativo nativo e um híbrido de mesmo nome e implemente-os no Operations Console. |
| **FWLSE3073E** | **Não é possível localizar o arquivo instalador do Adobe Air no aplicativo "{1}" versão "{2}". \nUse {0} para reconstruir e implementar o arquivo wlapp para este aplicativo.** <br/><br/>{0} é o nome do Studio, por exemplo, MobileFirst Studi, {1} é o nome do aplicativo (qualquer sequência), {2} é a versão do aplicativo: 1,0, 2,0, ...<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Ocorre quando o aplicativo de adobe está desorganizado |
| **FWLSE3074W** | **O bloqueio foi atualizado corretamente para o aplicativo "{0}" com o ambiente "{1}" e a versão "{2}", mas essa configuração não tem efeito sobre o ambiente "{1}" porque esse ambiente não suporta o Direct Update.** <br/><br/>{0} é o nome do aplicativo (qualquer sequência), {1} é o ambiente de aplicação: android, ios... {2} é a versão do aplicativo: 1,0, 2,0, ...<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. |
| **FWLSE3075W** | **A regra de autenticação do aplicativo foi devidamente atualizada para o aplicativo "{0}" com o ambiente "{1}" e a versão "{2}", mas essa configuração não tem efeito no ambiente "{0}" do aplicativo "{1}" porque esse ambiente não suporta a verificação de autenticidade do aplicativo. É possível ativar esse suporte para esse ambiente de aplicativo declarando no application-descriptor.xml uma configuração de segurança definida em authenticationConfig.xml.** <br/><br/>{0} é o nome do aplicativo (qualquer sequência), {1} é o ambiente de aplicação: android, ios... {2} é a versão do aplicativo: 1,0, 2,0, ...<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. |
| **FWLSE3076W** | **O aplicativo "{0}" com ambiente "{1}" e versão "{2}" não foi implementado porque ele não mudou desde a implementação anterior.** <br/><br/>{0} é o nome do aplicativo (qualquer sequência), {1} é o ambiente de aplicação: android, ios... {2} é a versão do aplicativo: 1,0, 2,0, ...<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, implemente exatamente o mesmo wlapp (legal) duas vezes com o Operations Console. |
| **FWLSE3077W** | **O adaptador "{0}" não foi implementado porque ele não foi alterado desde a implementação anterior.** <br/><br/>{0} é o nome do adaptador (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, implemente exatamente o mesmo adaptador (legal) duas vezes com o Operations Console. |
| **FWLSE3078W** | **O arquivo de miniatura está ausente no arquivo wlapp para o aplicativo "{0}" com o ambiente "{1}" e a versão "{2}".** <br/><br/>{0} é o nome do aplicativo (qualquer sequência), {1} é o ambiente de aplicação: android, ios... {2} é a versão do aplicativo: 1,0, 2,0, ... |
| **FWLSE3079W** | **Não é possível verificar se o aplicativo "{2}" com ambiente "{3}" e versão "{4}" foi construído com a mesma versão {1} que o tempo de execução {0}, pois as versões do aplicativo e tempo de execução são construídas com versões do Worklight Studio mais antigas que a versão 6.0. Assegure-se de que ambos tenham sido construídos com a mesma versão de {1}.** <br/><br/>{0} é a palavra MobileFirst {1}, é o nome do Studio, por exemplo, MobileFirst Studio, {2} é o nome do aplicativo (qualquer sequência), {3} é o ambiente
de aplicativo: android, ios... {4} é a versão do aplicativo: 1,0, 2,0, ...<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, implemente o wlapp desenvolvido com o Worklight Studio 5.0.6 ou mais antigo no MobileFirst Server 7.1. |
| **FWLSE3080W** | **Não é possível verificar se o adaptador "{2}" foi construído com a mesma versão {1} que o tempo de execução {0}, pois as versões do adaptador e tempo de execução são construídas com versões do Worklight Studio anteriores à 6.0. Assegure-se de que ambos tenham sido construídos com a mesma versão de {1}.** <br/><br/>{0} é a palavra MobileFirst, {1} é o nome do Studio, por exemplo, MobileFirst Studio, {2} é o nome do adaptador (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, implemente o adaptador desenvolvido com o Worklight Studio 5.0.6 ou mais antigo no MobileFirst Server 7.1. |
| **FWLSE3081E** | **A verificação de autenticidade do aplicativo não é suportada para o ambiente "{0}". Apenas os ambientes iOS e Android são suportados.** <br/><br/>{0} é o ambiente de aplicativo: android, ios, ...<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, edite o aplicativo android com a verificação de autenticidade ativada e modifique o ambiente. Em seguida, implemente. |
| **FWLSE3082E** | **O conteúdo do arquivo "{0}" está vazio e, portanto, não pode ser implementado.** <br/><br/>{0} é um nome de arquivo |
| **FWLSE3084E** | **O arquivo do adaptador não pode ser implementado, já que ele não contém o arquivo XML obrigatório do adaptador. Verifique se ele foi construído corretamente.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> implemente um adaptador que não contenha nenhum arquivo XML |
| **FWLSE3085E** | **O arquivo do aplicativo não pode ser implementado, pois ele não contém o arquivo "{0}" obrigatório. Verifique se ele foi construído corretamente.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> implemente um wlapp que não contenha nenhum arquivo meta/deployment.data |
| **FWLSE3090E** | **A transação nunca foi concluída. Verifique os logs do servidor de aplicativos.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, acontece quando uma transação fica paralisada por um motivo desconhecido por 30 min. |
| **FWLSE3091W** | **O processamento da transação {0} falhou. Verifique os logs do servidor de aplicativos.** <br/><br/>{0} é o id de transação, geralmente um número<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Talvez possa ser produzido encerrando um tempo de execução enquanto uma transação estiver em andamento. |
| **FWLSE3092W** | **A transação {0} foi cancelada antes de seu processamento ser iniciado. Verifique os logs do servidor de aplicativos.** <br/><br/>{0} é o id de transação, geralmente um número<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Isso ocorre se você criar várias transações de implementação, das quais pelo menos uma ainda não foi processada durante o encerramento do servidor. Na reinicialização do servidor, a transação não processada é cancelada. |
| **FWLSE3100W** | **O recurso binário {3} não pode ser acessado. Solicitação de Intervalo de HTTP {0}-{1} não pode ser satisfeita. O comprimento máximo do conteúdo é {2} bytes.** <br/><br/>{0} é o início da faixa de bytes, por exemplo, 0, {1} é o fim do intervalo de bytes, por exemplo, 6666, {2} é o número de bytes disponíveis, por exemplo, 25, {3} é o nome do recurso (como um nome de arquivo) |
| **FWLSE3101W** | **Aplicativo {1}, ambiente {2}, versão {3} construída com a versão {0}, versão {4} foi sobrescrita pelo ambiente construído com {0}, versão {5}** <br/><br/>{0} é o nome do Studio: o MobileFirst Studio, {1} é o nome do aplicativo (qualquer sequência), {2} é o ambiente de aplicativo: android, ios... {3} é a versão do aplicativo: 1.0, 2.0, ..... {4} é a versão do Studio,
por exemplo, 3.0 {5} é a outra versão do Studio, por exemplo, 4.0<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, é necessário ter uma construção de aplicativo com duas versões diferentes do Studio, mas o aplicativo deve ter o mesmo número da versão e o mesmo ambiente. Se você implementar ambos os aplicativos no mesmo servidor, a mensagem poderá ocorrer. Mas talvez a mensagem seja ocultada por outras mensagens. Eu nunca vi essa mensagem. |
| **FWLSE3102W** | **O aplicativo {0} não está ativado para notificação push.** <br/><br/>{0} é o nome do aplicativo (qualquer sequência) |
| **FWLSE3103E** | **Tag de notificação push {0} não localizada para o aplicativo {2} do tempo de execução {1}.** <br/><br/>{0} é a tag de notificação push (qualquer sequência), {1} é o nome do tempo de execução (qualquer sequência), {2} é o nome do aplicativo (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> ocorre apenas em testes de unidade |
| **FWLSE3104E** | **Tag de notificação push {0} já existe para o aplicativo {2} do tempo de execução {1}.** <br/><br/>{0} é a tag de notificação push (qualquer sequência), {1} é o nome do tempo de execução (qualquer sequência), {2} é o nome do aplicativo (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. |
| **FWLSE3105W** | **Certificado de notificação push para {0} expirado.** <br/><br/>{0} é o nome do mediador de push (qualquer sequência)<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. |
| **FWLSE3113E** | **Diversos erros ao sincronizar o tempo de execução {0}.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso ocorre em uma configuração de farm (configuração multinós) quando o servidor é iniciado, mas cada nó relata um erro diferente. |
| **FWLSE3199I** | **========= {0} versão {1} iniciada.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Isso sempre ocorre no log do servidor quando o servidor é iniciado. |
| **FWLSE3210W** | **Ambiente: {1} do aplicativo {0} versão {2} foi implantado com uma versão diferente do MobileFirst SDK nativo. Atualizações diretas não estarão mais disponíveis para clientes existentes com outras versões do SDK MobileFirst. Para continuar a usar as atualizações diretas, incremente a versão do aplicativo, publique-a no armazenamento de aplicativos públicos, implemente-a no servidor e
(opcionalmente) bloqueie versões mais antigas do aplicativo para fazer com que os clientes façam upgrade para a nova versão do armazenamento de aplicativos.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso pode ocorrer se um aplicativo foi criado por uma versão mais antiga do MobileFirst Studio com um MobileFirst SDK diferente mais antigo. Porém, não estou familiarizado com as versões nativas do MobileFirst SDK. |
| **FWLSE3119E** | **A validação do certificado APNS falhou. Consulte mensagens adicionais para obter detalhes.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Ocorre se o certificado Apple Push Notification for inválido. |
| **FWLSE3120E** | **Essa API pode ser usada somente depois de migrar o aplicativo para o MobileFirst Platform 6.3. A versão atual do aplicativo é {0}**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Ocorre com novas notificações push usadas com aplicativos antigos. |
| **FWLSE3121E** | **Esta API não está mais disponível no servidor. Consulte mensagens adicionais para obter detalhes.** |
| **FWLSE3122E** | **A regra de verificação de autenticidade de um aplicativo não pode mais ser modificada no interior do servidor. Você deve reconstruir seu aplicativo a fim de modificar a regra de verificação de autenticidade e implementá-la.** |
| **FWLSE3123W** | **Ambiente: {1} do aplicativo {0} versão {2} foi implementado com a autenticidade do aplicativo estendida desativada. É recomendável usar a autenticidade do aplicativo estendida para se proteger ainda mais contra aplicativos não autorizados usando o comando ativar autenticidade estendida da ferramenta mfpadm antes de implementar o aplicativo.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> No Operations Console, implemente um aplicativo com autenticidade básica. Nenhum dos aplicativos anteriores à 7.0 tem autenticidade estendida e deve mostrar este aviso ou o próximo. O aviso não ocorre se você usar o Operations Console que está integrado no Worklight Studio. |
| **FWLSE3124W** | **Ambiente: {1} do aplicativo {0} versão {2} foi implementado com a autenticidade do aplicativo desativada. Ative-a para se proteger ainda mais contra aplicativos não autorizados.** |

### Mensagens de Licença de Token

| **FWLSE3125E** | **A biblioteca nativa do Rational Common Licensing não foi localizada. Certifique-se de que a propriedade JVM (java.library.path) está definida com o caminho correto e a biblioteca nativa possa ser executada. Reinicie o IBM MobileFirst Platform
Server depois de executar a ação corretiva.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Não configure a propriedade JVM (java.library.path) apontando para a biblioteca nativa do RCL na configuração do servidor de aplicativos. Essa mensagem será então lançada na sincronização do tempo de execução. |
| **FWLSE3126E** | **A biblioteca compartilhada do Rational Common Licensing não foi localizada. Certifique-se de que a biblioteca compartilhada está configurada. Reinicie o IBM MobileFirst Platform
Server depois de executar a ação corretiva.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Não configure o caminho da biblioteca compartilhada apontando para a biblioteca java do RCL na configuração do servidor de aplicativos. Essa mensagem será então lançada na sincronização do tempo de execução. |
| **FWLSE3127E** | **A conexão do Rational License Key Server não está configurada. Certifique-se
de que as propriedades JNDI "{0}" e "{1}" do admin estão configuradas. Reinicie o IBM MobileFirst Platform
Server depois de executar a ação corretiva.** <br/><br/>{0} é o nome do host do servidor de licença, {1} é a porta do servidor de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Não configure as propriedades JNDI (relacionadas ao licenciamento de token) na configuração do servidor de aplicativos. Essa mensagem será então lançada na sincronização do tempo de execução. |
| **FWLSE3128E** | **O Rational License Key Server "{0}" não está acessível. Certifique-se
de que o servidor de licença está sendo executado e está acessível ao IBM MobileFirst Platform Server. Se esse erro ocorrer na inicialização
do tempo de execução, reinicie o IBM MobileFirst Platform Server depois de executar a ação
corretiva.** <br/><br/>{0} é o endereço completo do servidor de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Não inicie o servidor de licença. Essa mensagem será então lançada na sincronização do tempo de execução ou durante a implementação do aplicativo. |
| **FWLSE3129E** | **Licenças de token insuficientes para o recurso "{0}".** <br/><br/>{0} é o nome do recurso de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Esgote todas as licenças no servidor de licença. Essa mensagem será então lançada na sincronização do tempo de execução ou durante a implementação do aplicativo. |
| **FWLSE3130E** | **As licenças de token expiraram para o recurso "{0}".** <br/><br/>{0} é o nome do recurso de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Permita que as licenças de token expirem. Essa mensagem será então lançada na sincronização do tempo de execução ou durante a implementação do aplicativo. |
| **FWLSE3131E** | **O erro de licença foi detectado. Verifique os logs do servidor de aplicativos para obter mais detalhes.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. |
| **FWLSE3132E** | **A conexão com o Rational License Key Server está configurada com as propriedades JNDI do administrador "{0}" e "{1}", mas este IBM MobileFirst Platform Server não está ativado para o licenciamento de token.** <br/><br/>{0} é o nome do host do servidor de licença, {1} é a porta do servidor de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Não ative o licenciamento de token. Mas configure as propriedades JNDI (relacionadas ao licenciamento de token) na configuração do servidor de aplicativos. Essa mensagem será então lançada na sincronização do tempo de execução. |
| **FWLSE3133I** | **Este aplicativo está desativado. Entre em contato com o administrador para obter mais detalhes.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Permita que as licenças de token expirem. Em seguida, todos os aplicativos serão automaticamente desativados, e quando o aplicativo for acessado a partir do dispositivo, esta mensagem será vista. |
| **FWLSE3134E** | **A biblioteca nativa do Rational Common Licensing não foi localizada.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |
| **FWLSE3135E** | **A biblioteca compartilhada do Rational Common Licensing não foi localizada.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |
| **FWLSE3136E** | **Os detalhes do Rational License Key Server não estão configurados.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |
| **FWLSE3137E** | **O Rational License Key Server "{0}" não está acessível.** <br/><br/>{0} é o endereço completo do servidor de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |
| **FWLSE3138E** | **Licenças de token insuficientes para o recurso "{0}".** <br/><br/>{0} é o nome do recurso de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |
| **FWLSE3139E** | **As licenças de token expiraram para o recurso "{0}".** <br/><br/>{0} é o nome do recurso de licença<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |
| **FWLSE3140E** | **O erro de licença foi detectado.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |
| **FWLSE3141E** | **Os detalhes do Rational License Key Server estão configurados.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Internamente para ser armazenado em db. Difícil. |

### Mensagens de configuração de farm

| **FWLSE3200W** | **O servidor "{0}" não pode ser incluído como um novo membro do farm porque um servidor com o mesmo ID já está registrado para o tempo de execução "{1}". Isso pode acontecer se a propriedade JNDI mfp.admin.serverid tiver o mesmo valor em outro nó em execução, ou se o seu servidor não cancelou seu próprio registro corretamente ao ser encerrado pela última vez.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso acontece se você configurar um server farm incorretamente. Um server farm consiste em vários computadores (nós). Cada computador deve ter um id (propriedade JNDI mfp.admin.serverid).  Se usasse exatamente o mesmo id para dois nós diferentes, você veria esta mensagem no log do servidor. |
| **FWLSE3201E** | **Falha ao cancelar o registro do membro do farm "{0}" para o tempo de execução "{1}".**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, pode ocorrer nos logs do servidor se você tiver um server farm e encerrar um nó no farm e algo der errado durante o encerramento. |
| **FWLSE3202E** | **Falha ao recuperar a lista de membros do farm para o servidor "{0}".**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, pode ocorrer nos logs do servidor quando o serviço administrativo é encerrado em um server farm.  Depois, é feita uma tentativa de notificar os membros do farm e é necessário ter uma lista dos membros do farm para isso. |
| **FWLSE3203E** | **Nenhum nó farm é registrado com o ID do servidor "{0}" para o tempo de execução "{1}".** |
| **FWLSE3204W** | **Nó "{0}" parece inacessível; essa transação não foi executada neste nó.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso pode ocorrer em um server farm se você desconectar um nó farm da rede e esperar por tempo suficiente. Ele aparece no log do servidor. |
| **FWLSE3205W** | **Não é possível colocar o tempo de execução "{0}" no servidor "{1}" no modo de negação de serviço. É possível ignorar este aviso se o tempo de execução também estiver encerrando.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso pode ocorrer em um server farm se você desconectar um nó farm da rede e esperar tempo suficiente ou encerrar o servidor. Mas, adicionalmente, para o processamento normal, outra exceção deve acontecer (por exemplo, uma exceção OutOfMemory). |
| **FWLSE3206E** | **Não é permitido cancelar o registro do servidor "{0}" para o tempo de execução "{1}" porque o servidor ainda parece estar ativo.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso poderia ser reproduzido chamando a API de REST para remover um nó farm enquanto esse nó farm ainda estiver em execução. |
| **FWLSE3207E** | **O membro do farm com o id do servidor "{0}" não está acessível. Tente novamente mais tarde.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Em teoria, isso pode ocorrer em um server farm se você desconectar um nó farm da rede e, em seguida, tentar implementar um wlapp. A transação falhará e você poderá ver essa mensagem no log de erros (log de transação, acessível através da UI). |
| **FWLSE3208E** | **Um código de status inválido "{0}" foi retornado. O conteúdo de resposta é "{1}".**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Isso pode ocorrer sempre que um código de status inesperado é retornado de uma chamada REST de serviço de
configuração. |
| **FWLSE3209E** | **Ocorreu uma exceção durante a chamada do serviço de configuração. A mensagem de exceção é "{0}".**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Isso pode ocorrer sempre que houver problemas com operações CRUD que lidam com configurações no serviço de configuração. Esta execução é genérica e agrupa vários erros |
| **FWLSE3210E** | **Os recursos {0} que você está tentando exportar não foram localizados.** |
| **FWLSE3211E** | **O parâmetro resourceInfos {0} está especificado incorretamente. O parâmetro precisa ter um valor no formato resourceName\|\|resourceType.** |

## {{ site.data.keys.mf_console }} Mensagens

**Prefixo:** FWLSE<br/>
**Intervalo:** 3300-3399

| **FWLSE3301E** | **Problema com certificados SSL. Correções possíveis: coloque o certificado do servidor de aplicativos no armazenamento confiável. Ou defina a propriedade JNDI {0} para {1} (não em ambientes de produção).**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Difícil. Ocorre se você configurar o servidor com SSL, mas usar um certificado SSL errado. Também pode ocorrer com certificados autoassinados sob certas circunstâncias. |
| **FWLSE3302E** | **O keystore para o tempo de execução "{0}" não existe no banco de dados de administração do MobileFirst. O banco de dados pode estar corrompido.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> se o keystore não estiver presente |
| **FWLSE3303E** | **O nome do aplicativo "{0}", Ambiente "{1}" e Versão "{2}" dos dados do Recurso da Web/Autenticidade não corresponde ao aplicativo implementado.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Faça upload de um recurso da web gerado para um aplicativo diferente |
| **FWLSE3304E** | **A propriedade JNDI "{0}" não está configurada. O serviço de push não está ativado neste servidor.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Forneça a url do servidor de push incorreto |
| **FWLSE3305E** | **O alias do keystore não pode ser nulo.**<br/><br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> tente fazer upload de um keystore e ignore os campos de senha e alias |
| **FWLSE3306E** | **A senha do keystore não pode ser nula.** |
| **FWLSE3307E** | **Não é possível encontrar o alias "{0}" neste keystore.** |
| **FWLSE3308E** | **Incompatibilidade de senha do alias.** |
| **FWLSE3309E** | **A senha do alias não pode ser nula.** |
| **FWLSE3310W** | **O servidor permite que apenas aplicativos "{0}" sejam implementados.** <br/>{::nomarkdown}<i>Etapas para reproduzir:</i>{:/}<br/> Tente implementar aplicativos que cruzarão o limite configurado pela propriedade jndi mfp.admin.max.apps |
