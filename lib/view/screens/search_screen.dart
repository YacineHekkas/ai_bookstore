// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../controller/search_provider.dart';
//
// class SearchScreen extends StatelessWidget {
//   const SearchScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.white
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     hintStyle: TextStyle(color: Colors.grey), // Optional: Style the hint text
//                     prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.tune, color: Colors.grey),
//                       onPressed: () {
//                         // TODO: Implement filters
//                       },
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Adjust vertical padding
//                   ),
//                   onSubmitted: (query) {
//                     if (query.isNotEmpty) {
//                       context.read<SearchProvider>().searchBooks(query);
//                     }
//                   },
//                 ),
//               ),
//             ),
//             // Content
//             Expanded(
//               child: Consumer<SearchProvider>(
//                 builder: (context, searchProvider, child) {
//                   return searchProvider.isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Recent Searches
//                         if (searchProvider.recentSearches.isNotEmpty) ...[
//                           const Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             child: Text(
//                               'Recent Search',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: searchProvider.recentSearches.length,
//                             itemBuilder: (context, index) {
//                               final search = searchProvider.recentSearches[index];
//                               return ListTile(
//                                 leading: const Icon(Icons.history),
//                                 title: Text(search.query),
//                                 trailing: IconButton(
//                                   icon: const Icon(Icons.close),
//                                   onPressed: () {
//                                     searchProvider.removeSearch(search.query);
//                                   },
//                                 ),
//                                 onTap: () {
//                                   searchProvider.searchBooks(search.query);
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                         // Recommended Books
//                         Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'Recommended books',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 0.5,
//                             crossAxisSpacing: 16,
//                             mainAxisSpacing: 16,
//                           ),
//                           itemCount: searchProvider.recommendedBooks.length,
//                           itemBuilder: (context, index) {
//                             final book = searchProvider.recommendedBooks[index];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.asset(
//                                       "assets/images/img_3.png",
//                                       fit: BoxFit.cover,
//                                       width: double.infinity,
//                                       height: 120,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'By ${book.author}',
//                                   style: const TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   book.title,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       '\$${book.price.toStringAsFixed(2)}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//
//                                   ],
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.tune, color: Colors.grey),
                      onPressed: () {
                        // TODO: Implement filters
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  ),
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      context.read<SearchProvider>().searchBooks(query);
                    }
                  },
                ),
              ),
            ),
            // Content
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, searchProvider, child) {
                  if (searchProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!searchProvider.hasSearched) {
                    return _buildRecentSearches(searchProvider);
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recommended Books
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Search Results',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: searchProvider.searchResults.length,
                          itemBuilder: (context, index) {
                            final book = searchProvider.searchResults[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      "assets/images/img_3.png",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 120,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'By ${book.author}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${book.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(SearchProvider searchProvider) {
    if (searchProvider.recentSearches.isEmpty) {
      return const Center(child: Text('No recent searches'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchProvider.recentSearches.length,
      itemBuilder: (context, index) {
        final search = searchProvider.recentSearches[index];
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text(search.query),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              searchProvider.removeSearch(search.query);
            },
          ),
          onTap: () {
            searchProvider.searchBooks(search.query);
          },
        );
      },
    );
  }
}