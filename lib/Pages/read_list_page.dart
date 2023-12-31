import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:kitap_sarayi_app/Pages/book_page.dart';
import 'package:kitap_sarayi_app/Tools/Provider/readlist_provider.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';

class ReadListPage extends ConsumerStatefulWidget {
  const ReadListPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadListPageState();
}

class _ReadListPageState extends ConsumerState<ReadListPage> {
  List<Books>? books;
  @override
  Widget build(BuildContext context) {
    books = ref.watch(readlistProvider).readlistBooks;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Okuma Listem"),
        leading: const SizedBox(),
      ),
      body: books!.isEmpty
          ? const Center(child: Text("Okuma Listesi Boş"))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: List.generate(books!.length, (index) {
                        final book = books![index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            // ignore: inference_failure_on_instance_creation
                            MaterialPageRoute(
                              builder: (context) => BookPage(book: book),
                            ),
                          ),
                          child: ReadListCard(book: book),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class ReadListCard extends StatelessWidget {
  const ReadListCard({
    required this.book,
    super.key,
  });

  final Books book;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ImageReadListGet(
              url: book.book_img!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name!,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(fontSize: 20),
                  ),
                  Text(
                    book.author!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    book.explanation!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ImageReadListGet extends StatelessWidget {
  const ImageReadListGet({
    required this.url,
    super.key,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.contain,
      height: 130,
    );
  }
}
