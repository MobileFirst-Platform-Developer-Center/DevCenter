---
layout: tutorial
title: Glossário
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->

<!-- START NON-TRANSLATABLE -->
{% comment %}
Do note use keywords in the keyword terms, as this presents issues with the glossary sort tool. (You can use keywords in the definitions.)
When the term should logically use a keyword, use the keyword text in the term, and add a no-translation comment.
For example, instead of using "{{site.data.keys.mf_console }}" for the console term, use "MobileFirst Operations Console" and add the following between the term and the definition (starting with the "START NON-TRANSLATABLE" comment):
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->

<br/>
Este glossário fornece termos e definições para o software e produtos do {{site.data.keys.product }}.
As referências cruzadas a seguir são utilizadas neste glossário:

* **Consulte** o encaminha de um termo não preferencial para um termo preferencial
ou de uma abreviação para o formato completo.
* **Consulte também** o leva a um termo relacionado ou contrastante.

Para obter outros termos e definições, consulte o [website de Terminologia IBM](http://www.ibm.com/software/globalization/terminology/).

## A {
{: #a }
}
### política de aquisição
{: #acquisition-policy }
Uma política que controla como os dados são coletados de um sensor de
um dispositivo móvel. A política é definida pelo código do aplicativo.

### adaptador
{: #adapter }
O código do lado do servidor de um aplicativo
{{site.data.keys.product_adj }}. Os adaptadores
conectam-se a aplicativos corporativos, entregam dados para os aplicativos remotos
e a partir deles, e executam qualquer lógica necessária do lado do servidor nos dados
enviados.

### banco de dados de administração
{: #administration-database }
O banco de dados do {{site.data.keys.mf_console }} e dos serviços de administração. As tabelas de banco de dados definem elementos, como aplicativos,
adaptadores, projetos com suas descrições e ordens de magnitude.

### Administration Services
{: #administration-services }
Um aplicativo que hospeda os serviços REST e as tarefas de
administração. O aplicativo Administration Services é compactado em seu
próprio arquivo WAR.

### alias
{: #alias }
Uma associação considerada ou real entre duas entidades de dados ou
entre uma entidade de dados e um ponteiro.

### Android
{: #android }
Um sistema operacional de dispositivo móvel criado pelo Google, maior parte do qual é
liberado sob as licenças de software livre Apache 2.0 e GPLv2. Consulte também dispositivo móvel.

### API / Interface de programação de aplicativos (API)
{: #api-application-programming-interfacae-api }
Uma interface que permite a um programa de aplicativo que foi escrito em uma linguagem de alto nível utilizar dados ou funções específicas do sistema operacional ou de outro programa.

### app
{: #app }
Um aplicativo de dispositivo móvel ou da web. Consulte também aplicativo da web.

### Centro de aplicativos
{: #application-center }
Um componente do {{site.data.keys.product_adj }} que pode ser usado para compartilhar aplicativos e facilitar a colaboração entre os membros da equipe em um único repositório de aplicativos móveis.

### Instalador do Application Center
{: #application-center-installer }
Um aplicativo que lista o catálogo de aplicativos disponíveis
no Application Center. O Application Center Installer deve estar
presente em um dispositivo para permitir a instalação de aplicativos do repositório de aplicativos privados.

### arquivo descritor de aplicativo
{: #application-descriptor-file }
Um arquivo de metadados que define vários aspectos de um aplicativo.

### authentication
{: #authentication }
Um serviço de segurança que fornece prova de que um usuário de um sistema de computador é genuinamente quem essa pessoa afirma ser. Os mecanismos comuns para implementação deste serviço são as senhas e as assinaturas digitais.

## B
{: #b }
### Base64
{: #base64 }
Um formato de texto simples que é usado para codificar dados binários. A codificação Base64
é geralmente usada em Autenticação de Certificado de Usuário para codificar certificados X.509, CSRs X.509 e CRLs X.509. Consulte também codificado por DER, codificado por PEM.

### binário
{: #binary }
Referente a algo que é compilado ou executável.

### block
{: #block }
Uma coleção de várias propriedades (como adaptador, procedimento
ou parâmetro).

### notificação de transmissão
{: #broadcast-notification }
Uma notificação que é destinada a todos os usuários de um aplicativo específico do {{site.data.keys.product_adj }}. Consulte também notificação baseada em tag.

### definição de construção
{: #build-definition }
Um objeto que define uma compilação, como uma compilação de integração de projeto
semanal.

## R
{: #c }

### CA / Autoridade de certificação (CA)
{: #ca--certificate-authority-ca }
Uma organização ou empresa terceirizada
confiável que emite os certificados digitais. A autoridade de certificação geralmente verifica a identidade dos indivíduos que possuem o certificado exclusivo. Consulte também [certificado](#certificate).

### função de retorno de chamada
{: #callback-function }
Código executável que permite que uma camada de software de nível inferior chame
uma função definida em uma camada de nível superior.

### catálogo
{: #catalog }
Uma coleção de aplicativos.

### Certificado
{: #certificate }
Na segurança do computador, um documento digital que vincula uma chave pública à identidade do proprietário do certificado, permitindo assim que o proprietário do certificado seja autenticado. Um certificado é emitido por uma autoridade de certificação e assinado digitalmente por essa autoridade. Consulte também [autoridade de certificação](#ca--certificate-authority-ca).

### aplicativo corporativo de autoridade de certificação
{: #certificate-authority-enterprise-application }
Um aplicativo da empresa que fornece certificados e chaves privadas para seus aplicativos clientes.

### desafio
{: #challenge }
Uma solicitação por determinadas informações a um sistema. As informações,
que são enviadas de volta ao servidor em resposta a essa solicitação, são necessárias
para autenticação do cliente.

### manipulador de desafios
{: #challenge-handler }
Um componente do lado do cliente que emite uma sequência de desafios do
lado do servidor e responde do lado do cliente.

### cliente
{: #client }
Um programa ou computador de software que atende os serviços a partir de um servidor.

### componente de autenticação do lado do cliente
{: #client-side-authentication-componnet }
Um componente que coleta informações do cliente e, em seguida, usa módulos
de login para verificar essas informações.

### clone
{: #clone }
Uma cópia idêntica da versão aprovada mais recente de um componente,
com um novo ID de componente exclusivo.

### grupo
{: #cluster }
Uma coleta de sistemas completos que trabalham juntos para fornecer uma única
capacidade unificada de computação.

### aplicativo da empresa
{: #company-application }
Um aplicativo que é projetado para uso interno dentro de uma empresa.

### Hub da Empresa
{: #company-hub }
Um aplicativo que pode distribuir outros aplicativos especificados a serem instalados em um dispositivo móvel. Por exemplo, o Application Center é um Hub da Empresa. Consulte também [Application
Center](#application-center).

### componente
{: #component }
Um objeto ou programa reutilizável que executa uma função específica e funciona com outros componentes e aplicativos.

### credencial
{: #credential }
Um conjunto de informações que é concedida a um usuário ou certos processos de direitos de acesso.

### CRL / Lista de revogação de certificado (CRL)
{: #crl-certificate-revocation-list-crl }
Uma lista de certificados que foram revogados antes de sua data
de expiração planejada. As listas de revogação de certificado são mantidas pela autoridade de certificação e usadas, durante um handshake de Secure Sockets Layer (SSL), para assegurar que os certificados envolvidos não tenham sido revogados.

## E
{: #d }

### origem
de dados
{: #data-source }
O meio pelo qual um aplicativo acessa dados de
um banco de dados.

### implementar
{: #deployment }
O processo de instalação e configuração de um aplicativo de software
e todos os seus componentes.

### DER codificado
{: #der-encoded }
Pertencente a um formulário binário de um certificado formatado em ASCII PEM. Consulte também Base64, codificado por PEM.

### dispositivo
{: #device }
Consulte [dispositivo móvel](#mobile-device)

### contexto do dispositivo
{: #device-context }
Dados usados para identificar o local de um dispositivo. Esses dados
podem incluir coordenadas geográficas, pontos de acesso de WiFi e detalhes de
registro de data e hora. Consulte também acionador.

### Inscrição de dispositivo
{: #device-enrollment }
O processo de um proprietário de dispositivo registrando seu dispositivo como confiável.

### documentify
{: #documentify }
Um comando JSONStore usado para criar um documento.

## A
{: #e }

### emulador
{: emulator }
Um aplicativo que pode ser usado para executar um aplicativo feito para uma plataforma que não a plataforma atual.

### encryption
{: #encryption }
Em segurança de computadores, o processo de transformar dados em um formato ininteligível, de forma que os dados
originais não possam ser obtidos ou possam ser obtidos somente com a utilização de um processo de decriptografia.

### aplicativo corporativo
{: #enterprise-application }
Consulte aplicativo da empresa.

### entity
{: #entity }
Um usuário, um grupo ou um recurso definido para um serviço de segurança.

### environment
{: #environment }
Uma instância específica de uma configuração de hardware e software.

### Evento
{: #event }
Uma ocorrência de importância para uma tarefa ou sistema. Os eventos podem incluir a conclusão ou falha de uma operação, uma ação do usuário ou mudança de estado de um processo.

### fonte de eventos
{: #event-source }
Um objeto que suporta um servidor de notificação assíncrona em uma única Java™ virtual machine. Utilizando uma fonte de eventos, o objeto do listener de evento pode
ser registrado e utilizado para implementar qualquer interface.

## r
{: #f }

### aspecto
{: #facet }
Uma entidade XML que restringe tipos de dados XML.

### nó farm
{: #farm-node }
Um servidor em rede hospedado em um server farm.

### fire
{: #fire }
Na programação orientada por objetos, causar
uma transição de estado.

## G
{: #g }
### gateway
{: #gateway }
Um dispositivo ou programa usado para conectar redes ou sistemas com diferentes arquiteturas de rede.

### geocoding
{: #geocoding }
O processo de identificar códigos geográficos de marcadores geográficos mais tradicionais (endereços,
códigos de endereçamento postal, etc.). Por exemplo, uma referência pode estar localizada no cruzamento de duas
ruas, mas o código geográfico dessa referência consiste em uma sequência numérica.

### localização geográfica
{: #geolocation }
O processo de apontar um local com base na avaliação
de vários tipos de sinais. Em computação remota, muitas vezes, pontos de acesso
e torres de células de WLAN são usados para aproximar um local. Consulte também geocodificação, serviços de localização.

## u
{: #h }

### server farm homogêneo
{: #homogeneous-server-farm }
Um server farm no qual todos os servidores de aplicativos são do mesmo tipo, nível e versão.

### aplicativo híbrido
{: #hybrid-application }
Um aplicativo gravado principalmente em linguagens orientadas pela web
(HTML5, CSS e JS), mas que é agrupado em um shell nativo para que o
aplicativo se comporte como um aplicativo nativo e forneça ao usuário
todos os recursos desse aplicativo.

## S
{: #i }

### aplicativo interno
{: #in-house-application }
Consulte [aplicativo da empresa](#company-application).

## J
{: #j }

### JMX / Java Management Extensions (JMX)
{: #jmx--java-management-extensions-jmx }
Um meio de executar gerenciamento da tecnologia Java e por meio dela. JMX é uma extensão universal aberta da linguagem de
programação Java para gerenciamento que pode ser implementada
entre todas as indústrias, onde o gerenciamento for necessário.

## B
{: #k }

### Chave
{: #key }
Um valor matemático criptográfico usado para assinar, verificar, criptografar ou decriptografar digitalmente uma mensagem. Consulte também chave privada, chave pública.
Um ou mais caracteres de um item de dados que são usados para
identificar exclusivamente um registro e estabelecer sua ordem com relação a
outros registros.

### cadeia de chaves
{: #keychain }
Um sistema de gerenciamento de senha para o software Apple. Uma cadeia de chaves age como um
contêiner de armazenamento seguro para senhas que são usadas por vários aplicativos e serviços.

### par de chaves
{: #key-pair }
In computer security, a public key and a private key. Quando o par de chaves é usado para criptografia, o emissor usa a chave pública do receptor para criptografar a mensagem e o receptor usa sua chave privada para decriptografar a mensagem. Quando o par de chaves é usado para assinatura, o assinante usa sua chave privada para criptografar uma representação da mensagem e o receptor usa a chave pública do emissor para decriptografar a representação da mensagem para verificação da assinatura.

## v
{: #l }

### biblioteca
{: #library }
Um objeto do sistema que serve como diretório para outros objetos. Uma
biblioteca agrupa objetos relacionados e permite que os usuários localizem objetos pelo
nome.
Uma coleção de elementos de modelo, incluindo itens de negócios, processos,
tarefas, recursos e organizações.

### balanceamento
de carga
{: #load-balancing }
Um método de rede de computador para distribuir cargas de trabalho por
vários computadores ou um cluster de computadores, links de rede, unidades centrais
de processamento, unidades de disco ou outros recursos. O balanceamento de carga bem-sucedido
otimiza o uso de recursos, maximiza o rendimento, minimiza o tempo de resposta
e evita sobrecarga.

### armazenamento local
{: #local-store }
Uma área em um dispositivo em que os aplicativos podem armazenar e recuperar dados
localmente sem a necessidade de uma conexão de rede.

## S
{: #m }

### MBean / Bean gerenciado (MBean)
{: #mbean--managed-bean-mbean}
Na especificação JMX (Java Management Extensions), os objetos Java
que implementam os recursos e suas instrumentações.

### remotos
{: #mobile }
Veja [dispositivo móvel](#mobile-device).

### cliente móvel
{: #mobile-client }
Consulte [Application Center installer](#application-center-installer).

### dispositivo móvel
{: #mobile-device }
Um telefone, um tablet ou um personal digital assistant que opera
em uma rede de rádio. Consulte também Android.

### Adaptador do MobileFirst
{: #mobilfirst-adapter }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Consulte [adaptador](#adapter)

### Proxy de dados do MobileFirst
{: #mobilefirst-data-proxy }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Um componente do lado do servidor para o IMFData SDK que pode ser usado para proteger as chamadas do aplicativo móvel para o Cloudant usando recursos de segurança OAuth do {{site.data.keys.product }}. O {{site.data.keys.product_adj }} Data Proxy requer uma autenticação por meio do Trust Association Interceptor.

### MobileFirst Operations Console
{: #mobilefirst-operations-console }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Uma interface baseada na Web que é usada para controlar e
gerenciar ambientes de tempo de execução do
{{site.data.keys.product_adj }}
que são implementados no
{{site.data.keys.mf_server }}
e para coletar e analisar estatísticas do usuário.

### Ambiente de tempo de execução do MobileFirst
{: #mobilefirts-runtime-environment }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Um componente móvel otimizado do lado do servidor que executa o lado do
servidor dos aplicativos móveis (integração de backend, gerenciamento de versão,
segurança, notificação push unificada). Cada ambiente de tempo de execução é
compactado como um aplicativo da web (arquivo WAR).

### Servidor MobileFirst
{: #mobilefirst-server }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Server" in the term above (site.data.keys.mf_server keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Um componente do {{site.data.keys.product_adj }} que manipula segurança, conexões de backend, notificações push, gerenciamento de aplicativo móvel e análise de dados. O {{site.data.keys.mf_server }} é uma coleção de aplicativos que são executados em um servidor de aplicativos e age como um contêiner de tempo de execução para ambientes de tempo de execução do {{site.data.keys.product_adj }}.

## N
{: #n }

### aplicativo nativo
{: #native-app }
Um aplicativo que é compilado em código binário para uso no sistema operacional de dispositivo móvel no dispositivo.

### Nó
{: #node }
Um grupo lógico de servidores gerenciados.

### notificação
{: #notification }
Uma ocorrência em um processo que pode acionar uma ação. As notificações podem ser usadas para modelar condições de interesse a serem transmitidas de um remetente para um conjunto (tipicamente desconhecido) de partes interessadas (os receptores).

## A
{: #o }

### OAuth
{: #oauth }
Um protocolo de autorização baseado em HTTP que fornece aos aplicativos acesso com escopo a um recurso protegido em nome do proprietário do recurso criando uma interação de aprovação entre o proprietário do recurso, o cliente e o servidor do recurso.

## c
{: #p }

### navegação pela página
{: #page-navigation }
Um recurso de navegador que permite aos usuários navegar para frente e
para trás em um navegador.

### PEM codificado
{: #pem-encoded }
Pertencente a um certificado codificado em Base64. Consulte também Base64, codificado por DER.

### PKI / Infraestrutura de chave pública (PKI)
{: #pki--public-key-infrastructure-pki }
Um sistema de certificados digitais, autoridades de certificação e outras autoridades de registro que verificam e autenticam a validade de cada parte envolvida em uma transação de rede.

### Ponte PKI
{: #pki-bridge }
Um conceito  {{site.data.keys.mf_server }} que permite que a estrutura de Autenticação de Certificado de Usuário se comunique com um PKI.

### poll
{: #poll }
Solicitar dados repetidamente de um servidor.

### chave
privada
{: #private-key }
Em comunicação segura, um padrão de algoritmo utilizado para criptografar mensagens que somente a chave pública correspondente pode decriptografar. A chave privada também é usada para decriptografar mensagens que foram criptografadas pela chave pública correspondente. A chave privada é mantida no sistema do usuário e protegida por uma senha. Consulte também chave, chave pública.

### projeto
{: #project }
O ambiente de desenvolvimento para vários componentes, como aplicativos,
adaptadores, arquivos de configuração, código Java customizado e bibliotecas.

### arquivo WAR do projeto
{: #project-war-file }
Um archive web (WAR) que contém as configurações para o ambiente de tempo de execução do {{site.data.keys.product_adj }} e é implementado em um servidor de aplicativos.

### provisão
{: #provisin }
Fornecer, implementar e controlar um serviço, componente, aplicativo
ou recurso.

### proxy
{: #proxy }
Um gateway do aplicativo de uma rede para outra para um aplicativo de rede específico como
 Telnet ou FTP, por exemplo, onde um servidor firewall
proxy Telnet executa autenticação do usuário e, em seguida, permite o fluxo de tráfego
através do proxy como se ele não estivesse lá. A função é desempenhada no firewall e não na estação de trabalho do cliente, gerando maior carga no firewall.

### chave pública
{: #public-key }
Em comunicação segura, um padrão
de algoritmo utilizado para decriptografar mensagens que foram criptografadas pela chave
privada correspondente. Uma chave pública também é
usada para criptografar as mensagens que podem ser decriptografadas apenas pela chave privada correspondente. Os usuários
divulgam suas chaves públicas para todos aqueles com os quais desejam trocar mensagens
criptografadas. Consulte também chave, chave privada.

### Push
{: #push }
Enviar informações de um servidor para um cliente. Quando um servidor envia conteúdo por push, é ele que inicia a transação, não uma solicitação do cliente.

### notificação push
{: #push-notification }
Um alerta indicando uma mudança ou uma atualização que aparece em um ícone de app móvel.

## D
{: #r }

### proxy reverso
{: #reverse-proxy }
Uma topologia de encaminhamento IP, em que o proxy está em nome do
servidor HTTP de back-end. É um proxy de aplicativo para servidores que utilizam HTTP.

### raiz
{: #root }
O diretório que contém todos os outros diretórios em um sistema.

## E
{: #s}

### salt
{: #salt }
Dados gerados aleatoriamente inseridos em um
hash de senha ou de passphrase, tornando essas senhas incomuns (e mais difícil de ser hackeada).

### SDK / Kit de desenvolvimento de software (SDK)
{: #sdk--software-development-kit-sdk }
Um conjunto de ferramentas, APIs e documentação para ajudar o desenvolvimento
de software em uma linguagem de computador específica ou para um determinado
ambiente operacional.

### Teste de segurança
{: #security-test }
Um conjunto ordenado de domínios de autenticação que é usado para proteger um recurso como um procedimento do adaptador, um aplicativo ou uma URL estática.

### server
farm
{: #server-farm }
Um grupo de servidores em rede.

### de interação
{: #service }
Um programa que executa uma função primária dentro de um servidor ou software relacionado.

### Sessão
{: #sessions }
Uma conexão lógica ou virtual entre duas estações, programas de software ou
dispositivos em uma rede que permite que dois elementos se comuniquem e troquem dados
durante a sessão.

### sign
{: #sign }
Anexar uma assinatura eletrônica exclusiva, derivada do ID de usuário
do emissor, a um documento ou campo quando um documento é enviado por email. A assinatura
de email assegura que, se um usuário não autorizado criar uma nova cópia de um
ID do usuário, o usuário desautorizado não possa falsificar assinaturas com ele. Além disso, a assinatura verifica se ninguém violou
os dados enquanto a mensagem estava em trânsito.

### simulador
{: #simulator }
Um ambiente para código de temporariedade que é gravado para uma plataforma diferente. Os simuladores são usados para desenvolver e testar código no mesmo IDE, mas implementam esse código em sua plataforma específica. Por exemplo, é possível desenvolver código para um dispositivo Android em um computador e depois testá-lo usando um simulador nesse computador.

### aparência
{: #skin }
Um elemento de uma interface gráfica com o usuário que pode ser alterado para
alterar a aparência da interface sem afetar sua funcionalidade.

### arrastar
{: #slide }
Mover um item da interface da régua de controle horizontalmente em um touchscreen. Geralmente, os aplicativos usam gestos de arrasto para bloquear e desbloquear telefones, ou alternar
opções.

### subelemento
{: #subelement }
Em padrões UN/EDIFACT EDI, um elemento de
dados do EDI que faz parte de um elemento de dados compostos do EDI. Por exemplo, um elemento de dados do EDI
e seu qualificador são subelementos de um elemento de dados compostos EDI.

### subscrição
{: #subscription }
Um registro que contém as informações que um assinante passa
para um broker ou servidor local para descrever as publicações que ele deseja
receber.

### syntax
{: #syntax }
As regras para a construção de um comando ou instrução.

### mensagem do sistema
{: #system-message }
Uma mensagem automatizada em um dispositivo móvel que fornece status operacional ou
alertas, por exemplo, se as conexões forem bem-sucedidas ou não.

## Ter
{: t}

### notificação baseada em tag
{: #tag-based-notification }
Uma notificação que é destinada aos dispositivos que são inscritos
para uma tag específica. Tags são usadas para representar tópicos que são de
interesse de um usuário. Consulte também notificação de transmissão.

### TAI / Trust Association Interceptor (TAI)
{: #tai--trust-association-interceptor-tai }
O mecanismo pelo qual a confiança é validada no ambiente do produto para cada
              solicitação recebida pelo servidor proxy. O método de validação é acordado pelo servidor proxy e o interceptor.

### dar um toque
{: #tap }
Tocar de leve um touchscreen. Geralmente, os aplicativos usam gestos de toque
para selecionar itens (semelhante a um clique do botão esquerdo do mouse).

### gabarito
{: #template }
Um grupo de elementos que compartilham propriedades comuns. Essas propriedades
podem ser definidas apenas uma vez, no nível do modelo, e são herdadas
por todos os elementos que usam o modelo.

### acionar
{: #trigger }
Um mecanismo que detecta uma ocorrência, podendo causar processamento
adicional em resposta. Os acionadores podem ser ativados quando ocorrem mudanças
no contexto do dispositivo. Consulte também contexto do dispositivo.

## 
{: #u }

## V
{: #v }

### exibição
{: #view }
Uma área de janela que está fora da área do editor que pode ser usada para
examinar ou trabalhar com os recursos no ambiente de trabalho.

## Qua
{: #w}

### aplicativo da web / aplicativo
{: #web-app--application }
Um aplicativo acessível por um navegador da web e que fornece alguma função além da exibição estática de informações, por exemplo, ao permitir que o usuário consulte um banco de dados. Os componentes comuns de um aplicativo da web incluem páginas HTML, páginas JSP e servlets. Consulte também [app](#A).

### servidor de aplicativos da Web
{: #web-application-server }
O ambiente de tempo de execução para aplicativos dinâmicos da web. Um servidor
de aplicativos da web Java EE implementa os serviços do padrão Java EE.

### recurso da web
{: #web-resource }
Qualquer um dos recursos criados durante o desenvolvimento de um aplicativo da web, por exemplo, projetos da web, páginas HTML, arquivos JavaServer Pages (JSP), servlets, bibliotecas de tags customizadas e archives.

### widget
{: #widget }
Um aplicativo móvel e reutilizável ou parte do conteúdo dinâmico que pode ser colocado em uma página da web, receber entrada e comunicar-se com um aplicativo ou com outro widget.

### Wrapper
{: #wrapper }
Um seção de código que contém código que poderia, de outra forma, não
ser interpretado pelo compilador. O agrupador age como uma interface entre
o compilador e o código agrupado.

## i
{: #x }

### Certificado X.509
{: #x509-certificate }
Um certificado que contém informações que são definidas pelo padrão X.509.
