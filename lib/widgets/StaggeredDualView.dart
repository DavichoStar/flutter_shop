import 'package:flutter/material.dart';

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 0.0,
    this.aspectRatio = 0.5,
    this.offsetPercent = 0.5,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;
  final double offsetPercent;

  // Función para calcular el ancho de la pantalla para la cantidad de columnas que se quieren mostrar
  int _calculateWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double itemWidth = (width - spacing) / 2;
    int column = 1;

    if (itemWidth > 650 * aspectRatio) {
      column = 5;
    } else if (itemWidth > 490 * aspectRatio) {
      column = 4;
    } else if (itemWidth > 340 * aspectRatio) {
      column = 3;
    } else if (itemWidth > 210 * aspectRatio) {
      column = 2;
    }

    return column;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final itemHeight = (width * 0.5) / aspectRatio;
        final height = constraints.maxHeight + itemHeight;
        final columns = _calculateWidth(context);

        return OverflowBox(
          maxWidth: width,
          minWidth: width,
          maxHeight: height,
          minHeight: height,
          child: GridView.builder(
            padding: EdgeInsets.only(
              top: columns == 1
                  ? 0
                  : columns == 3
                      ? itemHeight / 4
                      : columns == 5
                          ? itemHeight / 3
                          : itemHeight / 2,
              bottom: columns == 1
                  ? itemHeight * 1.1
                  : columns == 3
                      ? itemHeight * 1.1
                      : columns == 4
                          ? itemHeight * 0.65
                          : columns == 5
                              ? itemHeight * 0.72
                              : itemHeight * 0.8,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              bool isLastRow = false;

              if (columns % 2 == 1) isLastRow = ((index / columns).floor() % 2 == 1);

              return Transform.translate(
                offset: Offset(
                  0.0,
                  (isLastRow ? !index.isOdd : index.isOdd)
                      ? columns % 2 == 0
                          ? itemHeight / columns * offsetPercent
                          : (itemHeight) * offsetPercent
                      : columns % 2 == 0
                          ? 0.0
                          : itemHeight / (columns + 1),
                ),
                child: itemBuilder(context, index),
              );
            },
          ),
        );
      },
    );
  }
}
