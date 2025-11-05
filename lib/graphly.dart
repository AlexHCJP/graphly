
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart' ;


class GraphNode {
  final String id;
  final Offset position;
  final Color color;
  final double radius;
  const GraphNode({
    required this.id,
    required this.position,
    this.color = const Color(0xFF2196F3),
    this.radius = 20,
  });
}

class GraphEdge {
  final String from;
  final String to;
  final Color color;
  final double width;
  const GraphEdge({
    required this.from,
    required this.to,
    this.color = Colors.grey,
    this.width = 1,
  });
}

class GraphRenderWidget extends LeafRenderObjectWidget {
  final List<GraphNode> nodes;
  final List<GraphEdge> edges;

  const GraphRenderWidget({
    required this.nodes,
    required this.edges,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGraph(nodes, edges);
  }

  @override
  void updateRenderObject(BuildContext context, RenderGraph renderObject) {
    renderObject
      ..nodes = nodes
      ..edges = edges;
  }
}

class RenderGraph extends RenderBox {
  List<GraphNode> _nodes;
  List<GraphEdge> _edges;

  RenderGraph(this._nodes, this._edges);

  set nodes(List<GraphNode> value) {
    if (_nodes != value) {
      _nodes = value;
      markNeedsPaint();
    }
  }

  set edges(List<GraphEdge> value) {
    if (_edges != value) {
      _edges = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest.isFinite
        ? constraints.biggest
        : const Size(300, 300);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    // Смещаем координаты, чтобы рисовать относительно offset
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final edgePaint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Рисуем рёбра
    for (final edge in _edges) {
      final from = _nodes.firstWhere((n) => n.id == edge.from);
      final to = _nodes.firstWhere((n) => n.id == edge.to);
      edgePaint.color = edge.color;
      canvas.drawLine(from.position, to.position, edgePaint);
    }

    // Рисуем узлы
    final nodePaint = Paint()..style = PaintingStyle.fill;
    for (final node in _nodes) {
      nodePaint.color = Colors.blue;
      canvas.drawCircle(node.position, 10, nodePaint);
    }

    canvas.restore();
  }
}