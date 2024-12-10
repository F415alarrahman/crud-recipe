import 'package:flutter/material.dart';
import 'package:post_recipe/provider/home_notifier.dart';
import 'package:post_recipe/service/auth_service.dart';
import 'package:post_recipe/view/add_recipe_page.dart';
import 'package:post_recipe/view/detail_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddRecipePage(),
                        ),
                      );
                      if (result == true) {
                        value.fetchRecipes();
                      }
                    },
                    child: const Text("Tambah Resep"),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi Keluar'),
                            content: const Text(
                                'Apakah Anda yakin ingin keluar dari aplikasi agrolyn?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog
                                },
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await AuthService().logout(context);
                                },
                                child: const Text('Keluar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: value.recipes.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  ) // Loading jika data kosong
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dua kolom untuk menampilkan data
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio:
                          3 / 4, // Rasio ukuran grid (lebar vs tinggi)
                    ),
                    itemCount: value.recipes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final recipe = value.recipes[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                recipe: value.recipes[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueAccent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Gambar Resep
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ), // Sudut membulat pada gambar
                                child: Image.network(
                                  recipe['photo_url'], // URL gambar
                                  height: 120, // Tinggi gambar
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.broken_image,
                                    size: 120,
                                    color: Colors.grey,
                                  ), // Placeholder jika gagal memuat gambar
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Judul Resep
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  recipe['title'] ?? 'No Title',
                                  maxLines: 1,
                                  overflow: TextOverflow
                                      .ellipsis, // Potong teks jika terlalu panjang
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Deskripsi Resep
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  recipe['description'] ?? 'No Description',
                                  maxLines: 2,
                                  overflow: TextOverflow
                                      .ellipsis, // Potong teks jika terlalu panjang
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Informasi Tambahan (Like Count)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            size: 16, color: Colors.yellow),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${recipe['likes_count'] ?? 0} Likes",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.comment,
                                            size: 16, color: Colors.white),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${recipe['comments_count'] ?? 0} Comments",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
