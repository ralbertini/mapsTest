# mapsTest

Aplicativo iOS que lista estabelecimentos com marcadores no google maps. Criado com XCode e command line tools na versão do XCode 11.3.1. 
Devido há um bug no XCode 11.4 não é garantida a execução no mesmo.

## Instalação

Ferramentas necessárias para rodar a aplicação:

- [Homebrew](https://brew.sh/)
```
/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

- [Carthage](https://github.com/Carthage/Carthage)
```
brew install carthage
```

- [Bundler](https://bundler.io/)
```
sudo gem install bundler
```

Para instalar/atualizar as dependências (na pasta onde está o arquivo *.xcodeproj):

```
bundle install
bundle exec fastlane setup
```

## Testes
Para rodar todos os testes (Unitários e Snapshot)
```
bundle exec fastlane ios run_all_tests
```
