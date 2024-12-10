import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:post_recipe/service/auth_service.dart';
import 'package:post_recipe/view/home_page.dart';

class RecipeServices {
  final Dio _dio = Dio();

  Future<List> getAllRecipe() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get(
        'https://recipe.incube.id/api/recipes',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data['data'] != null &&
          response.data['data']['data'] != null) {
        return response.data['data']['data']; // Mengembalikan daftar resep
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getRecipeById(String id) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get(
        'https://recipe.incube.id/api/recipes/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return response.data['data']; // Mengembalikan data resep
      } else {
        print("Failed to get recipe: ${response.data['message']}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<bool> addRecipe(String title, String cookingMethod, String description,
      String ingredients, File photo) async {
    final token = await AuthService().getToken();

    try {
      String fileName = photo.path.split('/').last;

      FormData formData = FormData.fromMap({
        "title": title,
        "cooking_method": cookingMethod,
        "ingredients": ingredients,
        "description": description,
        "photo": await MultipartFile.fromFile(photo.path, filename: fileName),
      });

      final response = await _dio.post(
        'https://recipe.incube.id/api/recipes', // Endpoint untuk menambah resep baru
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 201) {
        print("Recipe added successfully");

        return true; // Mengembalikan true jika berhasil
      } else {
        print("Failed to add recipe: ${response.data['message']}");
        return false; // Jika gagal
      }
    } catch (e) {
      print("Error: $e");
      return false; // Menangani error
    }
  }

  Future<void> deleteRecipe(int recipeId) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.delete(
        'https://recipe.incube.id/api/recipes/$recipeId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        print("Recipe deleted successfully");
      } else {
        print("Failed to delete recipe: ${response.data['message']}");
        throw Exception("Failed to delete recipe");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to delete recipe");
    }
  }

  Future<bool> updateRecipe(int recipeId, String title, String cookingMethod,
      String description, String ingredients, File? photo) async {
    final token = await AuthService().getToken();

    try {
      FormData formData = FormData.fromMap({
        "title": title,
        "cooking_method": cookingMethod,
        "ingredients": ingredients,
        "description": description,
      });

      if (photo != null) {
        String fileName = photo.path.split('/').last;
        formData.files.add(MapEntry(
          "photo",
          await MultipartFile.fromFile(photo.path, filename: fileName),
        ));
      }

      final response = await _dio.put(
        'https://recipe.incube.id/api/recipes/$recipeId',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        print("Recipe updated successfully");
        return true;
      } else {
        print("Failed to update recipe: ${response.data['message']}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
