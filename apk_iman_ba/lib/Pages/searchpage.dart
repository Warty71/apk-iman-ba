import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const RadialGradient(
                  center: Alignment(-1.538, -3.615),
                  radius: 4,
                  colors: <Color>[Color(0xff5959e4), Color(0xff140632)],
                  stops: <double>[0, 0.99],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Opacity(
                      opacity: 0.5,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.home_outlined),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SearchPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search_outlined),
                      color: Colors.white,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Opacity(
                      opacity: 0.5,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Opacity(
                      opacity: 0.5,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_2_outlined),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            fillColor: const Color(0xffeff2f8),
                            filled: true,
                            hintText: "Trazi pitanje...",
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_outlined,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1.5,
                                color: Color(0xffa6a6ad),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(255, 135, 196, 222),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: const Color(0xffeff2f8),
                            ),
                            height: 48,
                            child: Image.asset(
                              "lib/Images/close.png",
                              height: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.blue,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
