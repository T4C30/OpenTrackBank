import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:llamadart/llamadart.dart';
import 'package:open_track_bank/biblioteca.dart';
import 'package:path_provider/path_provider.dart';



// 1. Modelo de datos para los mensajes
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

// 2. Nuestro "Fragment" reutilizable
class LlamaChatWidget extends StatefulWidget {
  const LlamaChatWidget({super.key});

  @override
  State<LlamaChatWidget> createState() => _LlamaChatWidgetState();
}

class _LlamaChatWidgetState extends State<LlamaChatWidget> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final engine = LlamaEngine(LlamaBackend());
  bool _isTyping = false; // Muestra un indicador mientras la IA "piensa"
  List<Map<String, String>> historial = [];
  final ValueNotifier<String> loadingText = ValueNotifier("Preparando...");
  
  
  @override
  void initState() {
    super.initState();
    // Añadimos un mensaje de placeholder inicial para probar el diseño
    
    _messages.add(
      ChatMessage(
        text: "¡Hola! Soy tu IA local (Gema). ¿En qué puedo ayudarte hoy?",
        isUser: false,
      ),
    );


    WidgetsBinding.instance.addPostFrameCallback((_) {
      cargarModelo();
    });
  }

  void mostrarDialogoCarga() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: const Text("Cargando IA"),
        content: ValueListenableBuilder<String>(
          valueListenable: loadingText,
          builder: (_, value, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(value),
              ],
            );
          },
        ),
      );
    },
  );
}

  Future<void> cargarModelo() async {
    mostrarDialogoCarga();
    try {
      // Carpeta app
      final dir = await getApplicationSupportDirectory();

      final modelsDir = Directory("${dir.path}/models");

      if (!await modelsDir.exists()) {
        await modelsDir.create(recursive: true);
      }

      final modelPath =
          "${modelsDir.path}/llama.gguf";

      final file = File(modelPath);

      // Descargar si no existe
      if (!await file.exists()) {

        loadingText.value = "Descargando modelo...";


        await Dio().download(
          "http://huggingface.co/unsloth/gemma-4-E2B-it-GGUF/resolve/main/gemma-4-E2B-it-Q4_K_M.gguf",
          modelPath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              final progress =
                  ((received / total) * 100).toStringAsFixed(0);

              
                loadingText.value = "Descargando... $progress%";
              
            }
          },
        );
      }

      // Cargar modelo

        loadingText.value = "Cargando modelo...";
  

      await engine.loadModel(modelPath);

        loadingText.value = "Modelo cargado correctamente";
  

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      loadingText.value = "Error: $e";
    }
  }

  Future<void> enviarMensaje(String text) async {
    String response = "";

    // Insertar mensaje vacío IA
    _messages.insert(
      0,
      ChatMessage(
        text: "",
        isUser: false,
      ),
    );

    final aiMessageIndex = 0;

    try {
      await for (final token in engine.generate(text)) {

        if (token.contains("<end_of_turn>")) {
          break;
        }

        response += token;

        if (!mounted) return;

        setState(() {
          _messages[aiMessageIndex] = ChatMessage(
            text: response,
            isUser: false,
          );
        });
      }
    } catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _isTyping = false;
    });
  }

  // Lógica para enviar el mensaje y simular la respuesta
  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    
    // 1. Añadir el mensaje del usuario
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });



    enviarMensaje(buildPrompt(text, historial));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Chat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 40),

        const Divider(),

        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return _buildMessageBubble(message);
            },
          ),
        ),

        if (_isTyping)
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Llama está pensando...",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

        _buildTextComposer(),
      ],
    );
  }

  @override
  void dispose() {
    engine.dispose();
    super.dispose();
  }
  // Diseño de las burbujas de chat
  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blueAccent : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 0),
            bottomRight: Radius.circular(message.isUser ? 0 : 16),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color:  Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Diseño de la barra inferior para escribir
  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 4,
            color: Colors.black12,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: "Escribe un mensaje para Llama...",
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.blueAccent,
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}