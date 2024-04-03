# Onfly - Aplicativo de Gestão de Despesas de Viagens Corporativas

Este é um aplicativo móvel desenvolvido para ajudar os viajantes corporativos a gerenciar suas despesas de viagem de forma eficiente. O aplicativo é "offline first", o que significa que funciona perfeitamente mesmo quando o dispositivo está sem conexão com a internet, sincronizando os dados quando a conexão é restabelecida.

## Instalação

Para usar este projeto, siga estas etapas:

1. Clone este repositório.
2. Certifique-se de ter o Flutter instalado em sua máquina.
3. Execute `flutter pub get` para instalar as dependências do projeto.

## Funcionalidades

1. **Login Seguro:**
   - Permite que os usuários façam login de forma segura usando e-mail e senha.

2. **Lista de Despesas de Viagem:**
   - Exibe uma lista de despesas de viagem, permitindo que os usuários visualizem, adicionem e editem suas despesas.

3. **Dados do Cartão Corporativo:**
   - Apresenta informações importantes sobre o cartão corporativo do usuário, incluindo saldo, bandeira e extrato.

4. **Status das Viagens Agendadas:**
   - Mostra o status das viagens agendadas do usuário, incluindo detalhes como cartão de embarque, horário de voo, companhia aérea e aeroporto.

5. **Funcionalidade Offline First:**
   - As despesas de viagem são armazenadas localmente no dispositivo e sincronizadas com o servidor quando a conexão está disponível, garantindo que o aplicativo funcione perfeitamente mesmo sem conexão com a internet.

6. **Captura de Despesas:**
   - Permite aos usuários capturar novas despesas de viagem, incluindo campos como data, valor, categoria e descrição. Os dados são armazenados localmente e sincronizados conforme especificado na funcionalidade offline first.

7. **Relatórios de Despesas:**
   - Gera relatórios detalhados com base nos dados registrados, fornecendo gráficos e filtros para diferentes períodos de tempo.

## Como Usar

1. Faça login na sua conta usando seu e-mail e senha.
2. Explore a lista de despesas de viagem para visualizar, adicionar ou editar suas despesas.
3. Verifique os dados do seu cartão corporativo para obter informações atualizadas sobre saldo e extrato.
4. Confira o status das suas viagens agendadas para estar sempre preparado para sua próxima viagem.

## Dependências

Este projeto depende das seguintes bibliotecas Flutter:

- `cupertino_icons: ^1.0.6`
- `go_router: ^13.2.2`
- `firebase_core: ^2.28.0`
- `firebase_auth: ^4.19.0`

Certifique-se de que estas dependências estão corretamente configuradas em seu `pubspec.yaml`.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir um pull request ou uma issue para discutir mudanças que você gostaria de fazer.

## Licença

Este projeto é licenciado sob a [Licença MIT](LICENSE).

Se precisar de mais informações ou assistência, não hesite em entrar em contato. Obrigado por usar o Onfly!
