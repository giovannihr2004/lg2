// -----------------------------------------------------------------------------
// 📄 Archivo: lazy_loading_demo.dart
// 📍 Ubicación: lib/screens/testing/lazy_loading_demo.dart
// 📝 Descripción: Demostración de lazy loading con ListView y FadeInImage
// 📅 Última actualización: 23/05/2025 - 18:25 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class LazyLoadingDemo extends StatelessWidget {
  const LazyLoadingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Simula 100 imágenes de red
    final List<String> imageUrls = List.generate(
      100,
      (index) => 'https://picsum.photos/seed/$index/400/200',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Loading Demo'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Imagen #${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // Lazy loading con FadeInImage y placeholder
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/logo_login.webp',
                  image: imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  fadeInDuration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
