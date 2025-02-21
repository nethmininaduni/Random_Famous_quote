import 'package:flutter/material.dart';

void main() {
  runApp(RandomQuoteApp());
}

class RandomQuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InspireMe',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Changed the primary color to purple
        scaffoldBackgroundColor: Colors.white, // Lighter background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple[700], // Purple shade for the app bar
          elevation: 5, // Added some elevation for better separation
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600, // Slightly lighter font weight
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22, // Larger font size for better readability
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      home: QuoteScreen(),
    );
  }
}

class Quote {
  final String text;
  final String author;
  final String category;
  final String details;

  Quote({
    required this.text,
    required this.author,
    required this.category,
    required this.details,
  });
}

final List<Quote> quotes = [
  Quote(
    text:
        "The only limit to our realization of tomorrow is our doubts of today.",
    author: "Franklin D. Roosevelt",
    category: "Motivational",
    details:
        "Franklin D. Roosevelt was the 32nd president of the United States.",
  ),
  Quote(
    text:
        "Money is only a tool. It will take you wherever you wish, but it will not replace you as the driver.",
    author: "Ayn Rand",
    category: "Finance",
    details: "Ayn Rand was a Russian-American writer and philosopher.",
  ),
  Quote(
    text: "Love is composed of a single soul inhabiting two bodies.",
    author: "Aristotle",
    category: "Romance",
    details: "Aristotle was a Greek philosopher and polymath.",
  ),
  Quote(
    text: "History will be kind to me for I intend to write it.",
    author: "Winston Churchill",
    category: "History",
    details: "Winston Churchill was a British statesman and Prime Minister.",
  ),
  Quote(
    text: "The best way to predict the future is to invent it.",
    author: "Alan Kay",
    category: "Technology",
    details:
        "Alan Kay is a computer scientist known for his work on object-oriented programming.",
  ),
  Quote(
    text: "The only true wisdom is in knowing you know nothing.",
    author: "Socrates",
    category: "Philosophy",
    details:
        "Socrates was a classical Greek philosopher credited as one of the founders of Western philosophy.",
  ),
  Quote(
    text: "In the middle of difficulty lies opportunity.",
    author: "Albert Einstein",
    category: "Inspirational",
    details:
        "Albert Einstein was a theoretical physicist who developed the theory of relativity.",
  ),
  Quote(
    text: "The journey of a thousand miles begins with one step.",
    author: "Lao Tzu",
    category: "Wisdom",
    details: "Lao Tzu was an ancient Chinese philosopher and writer.",
  ),
];

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String selectedCategory = "Motivational";
  Quote? currentQuote;

  Color getCategoryColor(String category) {
    switch (category) {
      case "Finance":
        return Colors.green[400]!;
      case "Romance":
        return Colors.pink[300]!;
      case "History":
        return Colors.brown[300]!;
      case "Technology":
        return Colors.orange[300]!;
      case "Philosophy":
        return Colors.indigo[300]!;
      case "Inspirational":
        return Colors.teal[300]!;
      case "Wisdom":
        return Colors.purple[300]!;
      default:
        return Colors.blue[300]!;
    }
  }

  void fetchRandomQuote() {
    setState(() {
      var filteredQuotes =
          quotes.where((quote) => quote.category == selectedCategory).toList();
      filteredQuotes.shuffle();
      currentQuote = filteredQuotes.first;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InspireMe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
            20.0), // Added more padding for a spacious layout
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centered alignment for better look
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  fetchRandomQuote();
                });
              },
              items: <String>[
                "Motivational",
                "Finance",
                "Romance",
                "History",
                "Technology",
                "Philosophy",
                "Inspirational",
                "Wisdom"
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            if (currentQuote != null)
              Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 20),
                color: getCategoryColor(
                    currentQuote!.category), // Color based on category
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15), // Rounded corners for a softer look
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        currentQuote!.text,
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "- ${currentQuote!.author}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuoteDetailScreen(quote: currentQuote!),
                            ),
                          );
                        },
                        child: Text(
                          "View Details",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              getCategoryColor(currentQuote!.category),
                          backgroundColor: Colors.white, // Button text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: fetchRandomQuote,
                child: Text(
                  "Get New Quote",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 210, 121, 248), // Changed button color to purple
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteDetailScreen extends StatelessWidget {
  final Quote quote;

  QuoteDetailScreen({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quote Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote.text,
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                color: Colors.purple[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Text(
              "- ${quote.author}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Category: ${quote.category}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Details: ${quote.details}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
