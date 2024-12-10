import 'package:flutter/material.dart';
import 'package:post_recipe/provider/home_notifier.dart';
import 'package:post_recipe/view/edit_recipe_page.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.recipe});
  final Map<String, dynamic> recipe;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(recipe['title'] ?? 'No Title'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar Resep
                  recipe['photo_url'] != null
                      ? Image.network(
                          recipe['photo_url'],
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.broken_image,
                            size: 120,
                            color: Colors.grey,
                          ),
                        )
                      : const Icon(
                          Icons.broken_image,
                          size: 120,
                          color: Colors.grey,
                        ),
                  const SizedBox(height: 16),
                  // Judul Resep
                  Text(
                    recipe['title'] ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Deskripsi Resep
                  Text(
                    recipe['description'] ?? 'No Description',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // Tambahkan elemen lain sesuai kebutuhan
                  const SizedBox(height: 16),
                  // Tombol Edit Resep
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditRecipePage(recipe: recipe)));
                    },
                    child: const Text('Edit Recipe'),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Hapus Resep
                  ElevatedButton(
                    onPressed: value.isDeleting
                        ? null
                        : () {
                            value.deleteRecipe(recipe['id']);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: value.isDeleting
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Delete Recipe',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
