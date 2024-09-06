# Desafio iOS, Cora
 - iOS 16+
## Características do aplicativo
 - UIKit (ViewCode)
 - SwiftUI
 - Arquitetura modular
 - MVVM-C
 - Testes unitários
 - XCTest

## Ambientes
O app possui 3 ambientes, DEV, HML e PROD
<br>
<br>

<img width="295" alt="Captura de Tela 2024-09-06 às 15 37 46" src="https://github.com/user-attachments/assets/db8583ba-b352-49ac-a765-9959ca32e1fa">
<br>
<br>

para o app conseguir buildar, é importante que sejam adicionados os arquivos de configurações para os ambientes, entre no modulo `Cora` e crie uma pasta chamada `Config`, exemplo:
<br>


![Captura de Tela 2024-09-06 às 15 42 36](https://github.com/user-attachments/assets/7608cd77-d20f-4027-8d55-d4ac2755e51c)

<br>

Crie um arquivo `XCConfig` para cada ambiente, dentro de cada arquivo adicione a baseURL e a apiKey, como mostrado abaixo:
<br>
<br>
![Captura de Tela 2024-09-06 às 15 45 34](https://github.com/user-attachments/assets/2acb6be6-36b7-42a5-a4fc-1238717e2bb0)
<br>
Depois disso, escolha o ambiente e rode o build

![Captura de Tela 2024-09-06 às 15 47 45](https://github.com/user-attachments/assets/8eccb523-3ce9-4af8-9209-bd6ea01bd58d)


## Pattern de apresentação e organização do modulo
O aplicativo utiliza o padrão de arquitetura MVVM-C (Model-View-ViewModel-Coordinator) nos módulos de interface para uma organização clara e desacoplada da lógica de apresentação. No padrão MVVM-C, o Model é responsável pela disposição dos dados, o ViewModel administra os useCases, e a View é responsável pela interface do usuário e a interação. O Coordinator é usado para gerenciar a navegação e o fluxo de telas de maneira centralizada, separando as responsabilidades de roteamento e evitando que as ViewControllers conheçam detalhes de navegação.

Além disso, a arquitetura adota um padrão de Remote Models e Business Models, Junto a um Mapper responsável por mapear um model para o outro, promovendo uma clara separação entre os modelos de dados usados pela camada de rede e os modelos de negócios utilizados pela lógica interna. Cada módulo é dividido em três camadas: Data, Domain e Presentation. A camada Data lida com a recuperação e o armazenamento de dados, a camada Domain gerencia a lógica de negócios/casos de uso, e a camada Presentation é responsável pela interface de usuário e o fluxo de apresentação. Essa abordagem combinada resulta em um código mais limpo, testável e fácil de manter, promovendo uma clara separação de responsabilidades e facilitando a evolução do aplicativo.
```
---/ExampleViewModule
   ---/Data
       ---/RemoteModels
       ---ExampleEndpoint
       ---ExampleService
   ---/Domain
       ---/BusinessModels
       ---/UseCases
           ---ExampleUseCase1
           ---ExampleUseCase2
   ---/Presentation
       ---ExampleView(swiftUI) or ExampleViewController(UIKit)
       ---ExampleViewModel
       ---ExampleCoordinator
       ---ExampleFactory
```

## Modulos
Este repositório contém um aplicativo iOS desenvolvido em um XCWorkspace que centraliza um projeto principal chamado Cora e nove módulos de frameworks iOS adicionais. O projeto Cora é o ponto de entrada do aplicativo. Cada módulo de framework é projetado para ser independente e modular, fornecendo funcionalidades específicas, como gerenciamento de rede, armazenamento local, autenticação, serviços de backend, e componentes de UI reutilizáveis. Essa arquitetura modular facilita a manutenção, a escalabilidade e o trabalho em equipe, promovendo a reutilização de código e testes isolados de cada componente. O uso de um XCWorkspace permite o gerenciamento eficiente de dependências entre os módulos e o projeto principal, melhorando o fluxo de desenvolvimento e integração contínua.

<img src="https://github.com/user-attachments/assets/4778da58-d125-4986-bbc5-b61e01a04da6" width=500>

<img src="https://github.com/user-attachments/assets/e39cb604-45ee-4fb6-af95-0f3289e5f741" width=500>

