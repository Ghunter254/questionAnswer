import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:question_nswer/core/services/api_service.dart';

class ExpertsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  Future<String?> get authToken => _apiService.getAuthToken(); // Expose the user token

  Map<String, dynamic> _currentUser = {}; // Store current user data
  Map<String, dynamic> get currentUser => _currentUser; // Getter for current user data
  
  List<Map<String, dynamic>> _experts = [];
  List<Map<String, dynamic>> get experts => _experts;

  // Fetch the current user data
  Future<void> fetchCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get('/user');
      if (response.statusCode == 200) {
        _currentUser = response.data;
        notifyListeners();
        Fluttertoast.showToast(msg: "Current user data fetched successfully!");
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch current user: ${response.statusMessage}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching current user: ${e.toString()}");
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch all experts
  Future<void> fetchExperts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get('/experts');
      if (response.statusCode == 200) {
        _experts = List<Map<String, dynamic>>.from(response.data);
        notifyListeners();
        Fluttertoast.showToast(msg: "Experts fetched successfully!");
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch experts: ${response.statusMessage}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching experts: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new expert
  Future<bool> addExpert(String name, String expertise, String bio) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post('/experts', {
        'name': name,
        'expertise': expertise,
        'bio': bio,
      });

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Expert added successfully!");
        await fetchExperts(); // Refresh the experts list
        return true;
      } else {
        Fluttertoast.showToast(msg: "Failed to add expert: ${response.data}");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error adding expert: ${e.toString()}");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update an existing expert
  Future<bool> updateExpert(int expertId, String name, String expertise, String bio) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.put('/experts/$expertId', {
        'name': name,
        'expertise': expertise,
        'bio': bio,
      });

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Expert updated successfully!");
        await fetchExperts(); // Refresh the experts list
        return true;
      } else {
        Fluttertoast.showToast(msg: "Failed to update expert: ${response.data}");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating expert: ${e.toString()}");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete an expert
  Future<bool> deleteExpert(int expertId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.delete('/experts/$expertId');

      if (response.statusCode == 204) {
        Fluttertoast.showToast(msg: "Expert deleted successfully!");
        await fetchExperts(); // Refresh the experts list
        return true;
      } else {
        Fluttertoast.showToast(msg: "Failed to delete expert: ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error deleting expert: ${e.toString()}");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
