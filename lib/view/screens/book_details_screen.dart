import 'package:ai_bookstore/view/screens/pdf_book_reader_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/book_provider.dart';

class BookDetailsScreen extends StatelessWidget {
  final String bookId;

  const BookDetailsScreen({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(
      builder: (context, booksProvider, child) {
        final book = booksProvider.findById(bookId);
        return Scaffold(
          body: Column(
            children: [
              // Header with back button and favorite
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: Icon(
                          book.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: book.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () => booksProvider.toggleFavorite(book.id),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      SizedBox(height: 60,),
                      // Book Cover
                      Stack(
                        clipBehavior: Clip.none, // Allows elements to go outside the Stack
                        children: [
                          // Book Details Card (Background Container)
                          Container(

                            margin: const EdgeInsets.fromLTRB(10, 100,10,20), // Push down to allow image overlap
                            decoration: BoxDecoration(

                              color: const Color(0xFFFFE4E6),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 240), // Space for the image overlap
                                  // Title
                                  Text(
                                    book.title,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  // Author
                                  Text(
                                    'By ${book.author}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  // Book Info Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildInfoColumn('Pages', book.pages.toString()),
                                      _buildInfoColumn('Language', book.language ),
                                      _buildInfoColumn('Price', '\$${book.price.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  // Rating Row (Stars)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (index) {
                                      return const Icon(Icons.star, color: Colors.black, size: 20);
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Book Cover Image (Overlapping)
                          Positioned(
                            left: 40,
                            right: 40,
                            top: -50, // Move up to overlap the container
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  book.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Description
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           SizedBox(width: 10,),
                           Text(
                             'Descriptions',
                             style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,


                             ),
                             textAlign: TextAlign.start,
                           ),
                         ],
                       ),
                      const SizedBox(height: 12),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0,10,0),
                        child:Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\'...',
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1.5,
                          ),

                        ),
                      ),

                      TextButton(
                        onPressed: () {},
                        child: const Text('Read More'),
                      ),
                      const SizedBox(height: 20),
                      // Author Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      const Text(
                        'Author',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
      ]),
                      const SizedBox(height: 12),
                      Row(

                        children: [
                          SizedBox(width: 10,),
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-EOUo8IIBz98lWEv8oP4UiWBYrQZN7o.png'),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.author,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Author',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Read Button
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.8,
                        child: ElevatedButton(
                          onPressed: () {

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PDFReaderScreen(pdfAssetPath: 'assets/book/sample.pdf',)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD87D7E),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Read the book',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}