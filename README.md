# Hack Infra Core

## 📌 O que é o projeto
O `hack-infra-core` é o repositório responsável pelo provisionamento e gerenciamento da infraestrutura base na nuvem da AWS para o projeto Hackathon. Ele utiliza Infrastructure as Code (IaC) para de forma automatizada, reproduzível e segura criar e gerenciar os recursos fundamentais que suportam os microserviços e a arquitetura do sistema.

## 🚀 Principais Tecnologias Utilizadas
- **Terraform**: Ferramenta principal para gerenciamento e provisionamento da Infraestrutura como Código (IaC).
- **Amazon Web Services (AWS)**: Provedor de nuvem utilizado. Principais serviços provisionados:
  - **Amazon EKS**: Orquestração de contêineres e Kubernetes.
  - **Amazon ECR**: Registro de imagens de contêiner.
  - **Amazon S3**: Armazenamento de objetos.
  - **Amazon SQS**: Serviço de fila de mensagens.
  - **Amazon DynamoDB**: Banco de dados NoSQL rápido e flexível.
- **GitHub Actions**: Automação do pipeline CI/CD.

## 🛠️ Pré-requisitos / Variáveis de Ambiente

### Pré-requisitos Locais
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (>= 1.x)
- [AWS CLI](https://aws.amazon.com/cli/) configurado com credenciais adequadas

### Variáveis de Ambiente e Secrets
Para o pleno funcionamento local ou via esteira de CI/CD, as seguintes variáveis/secrets são necessárias:
- `AWS_ACCESS_KEY_ID`: Chave de acesso do usuário AWS.
- `AWS_SECRET_ACCESS_KEY`: Chave de acesso secreta do usuário AWS.
- `AWS_SESSION_TOKEN`: Token de sessão da AWS (caso utilize credenciais temporárias do AWS Academy/SSO).
- `AWS_REGION`: Região padrão da AWS (configurada como `us-west-2`).

## 🧪 Testes e Qualidade
Para garantir a integridade da infraestrutura, os seguintes processos de qualidade são aplicados:
- **`terraform fmt`**: Padronização da formatação e estilização de todo o código Terraform.
- **`terraform validate`**: Validação estática da sintaxe do código, conferindo a consistência das referências e estruturas antes de comunicar com o provedor em nuvem.
- **Dry Run/Planning**: Geração do plano de execução (`terraform plan`) que atua como um teste visual prevendo exatamente quais recursos serão criados, modificados ou destruídos.

## 🔀 Pipeline CI/CD
A esteira automatizada (`Esteira CI/CD`) é disparada via **GitHub Actions** em `push` para a branch `main` ou de forma manual (`workflow_dispatch`). Ela é dividida em três fases principais:
1. **Validate**: Etapa inicial que valida o código baixado com comandos de inicialização, formatação e verificação de sintaxe (`terraform validate`, `terraform fmt`).
2. **Plan**: Realiza um `terraform plan` detalhado demonstrando os impactos da mudança na infraestrutura real.
3. **Apply**: Executa automaticamente (`terraform apply -auto-approve`) as mudanças planejadas diretamente no ambiente da AWS. Esta etapa ocorre de forma restrita quando o pipeline roda a partir da branch principal (`main`).

## 🏆 Melhores Práticas Implementadas
- **Infrastructure as Code (IaC)**: Total gerência e versionamento da infraestrutura como código, evitando alterações manuais inseguras (ClickOps).
- **Modularização Extensiva**: Adoção de uma estrutura limpa e dividida por módulos (DynamoDB, ECR, EKS, S3, SQS). Facilita o reuso, os testes isolados e a manutenção.
- **Separação de Ambientes Contextuais**: Estrutura orientada a isolamento de cenários dentro do diretório de ambientes (`envs/dev/`), protegendo o escopo das alterações.
- **Validação Antecipada**: A esteira de integração sempre valida e planeja (Shift-Left validation) para evitar problemas no provisionamento ou destruições acidentais de estado na nuvem.
- **Pipeline Segregado**: Separação clara e segura entre as etapas de avaliação de impacto (Plan) e execução irreversível (Apply) no pipeline CI/CD.