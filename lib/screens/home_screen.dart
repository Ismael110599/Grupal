import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _counter = 0;
  bool _isAnimated = false;
  Color _backgroundColor = Colors.white;
  String _welcomeMessage = '¡Bienvenido a mi aplicación Flutter!';
  final List<String> _messages = [
    '¡Bienvenido a mi aplicación Flutter!',
    '¡Explora las funcionalidades!',
    '¡Disfruta de la experiencia!',
    '¡Aprende Flutter con nosotros!',
  ];
  int _currentMessageIndex = 0;

  final List<Color> _backgroundColors = [
    Colors.white,
    Colors.blue.shade50,
    Colors.purple.shade50,
    Colors.green.shade50,
    Colors.orange.shade50,
  ];
  int _currentColorIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _isAnimated = true;
    });

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    if (_counter % 5 == 0) {
      _changeWelcomeMessage();
    }

    if (_counter % 10 == 0) {
      _changeBackgroundColor();
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isAnimated = false;
        });
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _currentMessageIndex = 0;
      _currentColorIndex = 0;
      _welcomeMessage = _messages[0];
      _backgroundColor = _backgroundColors[0];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Contador reiniciado'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _changeWelcomeMessage() {
    setState(() {
      _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
      _welcomeMessage = _messages[_currentMessageIndex];
    });
  }

  void _changeBackgroundColor() {
    setState(() {
      _currentColorIndex = (_currentColorIndex + 1) % _backgroundColors.length;
      _backgroundColor = _backgroundColors[_currentColorIndex];
    });
  }

  Color _getCounterColor() {
    if (_counter == 0) return Colors.grey;
    if (_counter < 5) return Colors.blue;
    if (_counter < 10) return Colors.green;
    if (_counter < 20) return Colors.orange;
    return Colors.red;
  }

  String _getCounterMessage() {
    if (_counter == 0) return 'Comienza a hacer clic';
    if (_counter < 5) return 'Buen comienzo';
    if (_counter < 10) return '¡Vas bien!';
    if (_counter < 20) return '¡Increíble!';
    if (_counter < 50) return '¡Eres genial!';
    return '¡Eres un experto!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                kBottomNavigationBarHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Stack con imagen personalizada, ícono animado y texto
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade300, Colors.blue.shade800],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: _getCounterColor(),
                                  shape: BoxShape.circle,
                                  boxShadow:
                                      _isAnimated
                                          ? [
                                            BoxShadow(
                                              color: _getCounterColor()
                                                  .withOpacity(0.5),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                            ),
                                          ]
                                          : [],
                                ),
                                child: const Icon(
                                  Icons.home,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      child: Text(
                        '¡Disfruta y aprende Flutter!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 2,
                              color: Colors.black45,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Texto dinámico de bienvenida
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _welcomeMessage,
                    key: ValueKey(_welcomeMessage),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getCounterColor(),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Esta aplicación demuestra navegación y estados dinámicos en Flutter.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Contenedor animado del contador
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getCounterColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _getCounterColor(), width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getCounterMessage(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getCounterColor(),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Contador: ',
                            style: TextStyle(fontSize: 14),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              '$_counter',
                              key: ValueKey(_counter),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _getCounterColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: (_counter % 50) / 50,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getCounterColor(),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Progreso: ${(_counter % 50)}/50',
                        style: TextStyle(
                          fontSize: 10,
                          color: _getCounterColor(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Fila informativa de íconos
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn(Icons.touch_app, 'Tap', Colors.blue),
                      _buildInfoColumn(Icons.explore, 'Explora', Colors.green),
                      _buildInfoColumn(Icons.school, 'Aprende', Colors.purple),
                    ],
                  ),
                ),

                // Botones principales
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: CustomButton(
                          text: _counter == 0 ? 'Comenzar' : 'Incrementar',
                          onPressed: _incrementCounter,
                          backgroundColor: _getCounterColor(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: CustomButton(
                          text: 'Reiniciar',
                          onPressed: _counter > 0 ? _resetCounter : null,
                          backgroundColor:
                              _counter > 0 ? Colors.orange : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: _getCounterColor(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// Componente auxiliar reutilizable para mostrar un ícono con texto debajo.
  /// Ideal para usarse dentro de una Row como elemento informativo compacto.
  Widget _buildInfoColumn(IconData icon, String text, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(height: 2),
        Text(
          text,
          style: const TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
