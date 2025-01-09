import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:question_nswer/core/features/categories/controllers/categories_provider.dart';
import 'package:question_nswer/core/features/questions/controllers/questions_provider.dart';

class AskNowScreen extends StatefulWidget {
  const AskNowScreen({Key? key}) : super(key: key);

  @override
  _AskNowScreenState createState() => _AskNowScreenState();
}

class _AskNowScreenState extends State<AskNowScreen> {
  String? _selectedCategory;
  int? _selectedCategoryId;
  final TextEditingController _questionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    await categoriesProvider.fetchCategories();
  }

  Future<void> _submitQuestion() async {
    final questionContent = _questionController.text.trim();

    if (_selectedCategoryId == null || questionContent.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please select a category and enter a question.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final questionsProvider =
        Provider.of<QuestionsProvider>(context, listen: false);
    final success = await questionsProvider.addQuestion(
        questionContent, _selectedCategoryId!);

    if (success) {
      Fluttertoast.showToast(
        msg: "Question submitted successfully!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      _questionController.clear();
      setState(() {
        _selectedCategory = null;
        _selectedCategoryId = null;
      });
    } else {
      Fluttertoast.showToast(
        msg: "Failed to submit question.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final isSubmitting = Provider.of<QuestionsProvider>(context).isLoading;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose a Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (categoriesProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (categoriesProvider.categories.isNotEmpty)
              DropdownButton<String>(
                value: _selectedCategory,
                hint: const Text("Select a category"),
                isExpanded: true,
                items: categoriesProvider.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['name'],
                    child: Text(category['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                    _selectedCategoryId = categoriesProvider.categories
                        .firstWhere(
                            (category) => category['name'] == value)['id'];
                  });
                },
              )
            else
              const Text("No categories available."),
            const SizedBox(height: 16),
            const Text(
              "Ask Your Question",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _questionController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Type your question here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : _submitQuestion,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: isSubmitting ? Colors.grey : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isSubmitting
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        "Submit Question",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
