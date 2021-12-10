# QuickDrawFlutterApp
 
Projeto para disciplina Big Data Analysis.

Reconhecimento de desenhos utilizando redes neurais de aprendizado profundo e o conjunto de dados [quickdraw-dataset](https://github.com/googlecreativelab/quickdraw-dataset).

### Modelos treinados:

- CNN
- RNN

### Desenhos reconhecidos:

- bee
- coffee cup 
- guitar 
- hamburger
- rabbit 
- truck
- umbrella 
- crab 
- banana
- airplane

### Como executar a API:

```console
\QuickDrawFlutterApp> cd .\api\
\QuickDrawFlutterApp\app> flask run -h seu_ip_local
```

### Como executar o aplicativo no emulador:

É necessario inserir o seu ip local no arquivo: ".\QuickDrawFlutterApp\quick_draw_flutter_app\lib\controller\api.dart"
```dart
...
var uri = Uri.parse('http://seu_ip_local:5000/classificar');
var request = http.MultipartRequest("POST", uri);
...
```

e rodar o comando:

```console
\QuickDrawFlutterApp> cd .\quick_draw_flutter_app\
\QuickDrawFlutterApp\quick_draw_flutter_app> flutter run
```

OBS: É necessario ter o flutter 2.0 e Python instalados na maquina.
