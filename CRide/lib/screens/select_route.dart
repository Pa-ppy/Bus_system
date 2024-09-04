import 'package:flutter/material.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, // This removes the back button
        title: const Text(
          'Routes',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on_outlined, color: Colors.black),
            onPressed: () {
              // Handle location button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search routes',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Popular routes
              const Text(
                'Popular routes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              buildRouteItem('Brunei to KSB', '2 stops • 20min'),
              buildRouteItem('Commercial Area to Brunei', '4 stops • 15min'),
              buildRouteItem('Hall 7 to Brunei', '4 stops • 35min'),
              const SizedBox(height: 32),

              // All routes
              const Text(
                'All routes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              buildRouteItem('Casely Hayford to Brunei', '2 stops • 10min'),
              buildRouteItem('Library to KSB', '3 stops • 10min'),
              buildRouteItem('Brunei to KSB', '2 stops • 20min'),
              buildRouteItem('Commercial Area to Brunei', '4 stops • 15min'),
              buildRouteItem('Hall 7 to Brunei', '4 stops • 35min'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRouteItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Route info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Favorite icon
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {
              // Handle favorite action
            },
          ),
        ],
      ),
    );
  }
}
