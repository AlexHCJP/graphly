```dart
import 'package:flutter/material.dart';
import 'package:graphly/graphly.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: GraphPage());
  }
}

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nodes = [
      const GraphNode(
        id: 'A',
        position: Offset(100, 100),
        color: Color(0xFF2196F3),
      ),
      const GraphNode(
        id: 'B',
        position: Offset(250, 200),
        color: Color(0xFFE91E63),
      ),
      const GraphNode(
        id: 'C',
        position: Offset(150, 300),
        color: Color(0xFFFFC107),
      ),
    ];
    final edges = [
      const GraphEdge(from: 'A', to: 'B', color: Color(0xFF90CAF9)),
      const GraphEdge(from: 'B', to: 'C', color: Color(0xFFF48FB1)),
      const GraphEdge(from: 'A', to: 'C', color: Color(0xFFFFF59D)),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GraphRenderWidget(nodes: nodes, edges: edges),
      ),
    );
  }
}

```