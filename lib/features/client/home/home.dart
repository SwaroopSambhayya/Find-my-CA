import 'package:find_my_ca/shared/theme.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                height: 30,
                width: 30,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // LogoutButton()
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            const Text("Hi, Gunther",
                style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
            const Text("Let's Find the best CA to help you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 30),
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: "Search CA",
            //     isDense: true,
            //     filled: true,
            //     fillColor: secondaryColor,
            //     suffixIcon: const Icon(Icons.search, color: Colors.grey, size: 25),
            //     border:
            //         OutlineInputBorder(borderSide: BorderSide(color: backgroundColor, width: 1)),
            //     enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1)),
            //   ),
            // ),
            // const SizedBox(height: 30),
            const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const CategoryItems(),
            const Text("Top CA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            ...List.generate(5, (index) => const CaListItem())

          ],
        ),
      ),
    );
  }
}

class CategoryItems extends StatefulWidget {
  const CategoryItems({Key? key}) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  int selectedIndex = 0;

  final List<String> _choicesList = ['General', 'Criminal', 'Crime', "Tax Deduction"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            _choicesList.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Row(
                    children: [
                      Chip(
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   side: BorderSide(
                        //       color: Colors.transparent, width: 0),
                        // ),
                        labelPadding: const EdgeInsets.all(3),
                        padding: const EdgeInsets.all(5),
                        backgroundColor: getBackgroundColor(index),
                        label: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: backgroundColor, borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add_business, size: 18, color: getIconColor(index)),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _choicesList[index],
                              style: TextStyle(color: getFontColor(index), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                )),
      ),
    );
  }

  getBackgroundColor(index) {
    return selectedIndex == index ? primaryColor : secondaryColor;
  }

  getFontColor(index) {
    return selectedIndex == index ? secondaryColor : Colors.black45;
  }

  getIconColor(index) {
    return selectedIndex == index ? primaryColor : Colors.black45;
  }
}

class CaListItem extends StatelessWidget {
  const CaListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Richard Tea", style: TextStyle(fontSize: 12)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.greenAccent,
                            ),
                            child: const Text("General", style: TextStyle(fontSize: 12)),
                          )
                        ],
                      ),
                      const Text("Binghamton, New York",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const Row(
                        children: [
                          Icon(Icons.star_rate,color: Colors.yellow,size: 16),
                          SizedBox(width: 5),
                          Text("4.8",
                              style: TextStyle(fontSize: 10, color: Colors.grey))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
