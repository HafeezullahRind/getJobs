import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '/screens/JobApplication/JobApplicationScreen.dart';
import '../../Models/job_search.dart';
import '../homescreen/sidebar.dart';

class FieldModel {
  String? job_title;
  String? company_name;
  FieldModel(this.job_title, this.company_name);
}

class Search extends StatefulWidget {
  static const routename = "search";

  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchTitle = "All Jobs"; // Dynamic title
  String? searchQuery;
  bool isLoading = false; // Track loading state

  List<Job>? searchResults = [];

  Future<void> fetchAllJobs(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://www.jobportal.ai-teacher.org/api/jobs/search'),
      );
      if (response.statusCode == 200) {
        final jobSearch = JobSearch.fromJson(jsonDecode(response.body));
        setState(() {
          searchResults = jobSearch.data?.job ?? [];
        });
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      print('Error fetching jobs: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Sample lists for filtering
  static List<FieldModel> mainFieldList = [
    FieldModel("web development", "b2b technology"),
    FieldModel("react developer", "Via solution"),
    FieldModel("flutter developer", "Adore Addis"),
    FieldModel("project management", "Rakan Travel Solution"),
    FieldModel("back end developer", "Digital Addis"),
  ];
  List<FieldModel> displayList = List.from(mainFieldList);

  void updateList(String value) {
    // For filtering the list
    setState(() {
      displayList = mainFieldList
          .where((element) =>
              element.job_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    fetchAllJobs("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        iconTheme: const IconThemeData(
          color: Colors.orange,
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 180),
          child: Text(
            "getJOBS",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 40),
                  child: Text(
                    "Search For A Job",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    onChanged: (value) => setState(() {
                      searchQuery = value;
                    }),
                    style: TextStyle(color: yellow),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Flutter development",
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Color.fromRGBO(245, 186, 65, 1),
                      suffixIcon: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.all(22),
                        ),
                        onPressed: () {
                          if (searchQuery != null && searchQuery!.isNotEmpty) {
                            fetchAllJobs(
                                searchQuery!); // Fetch jobs with the entered query
                          }
                        },
                        child: const Icon(Icons.search),
                      ),
                      suffixIconColor: yellow,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults?.length,
                    itemBuilder: (context, index) {
                      final job = searchResults?[index];
                      return JobContainer(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobApplicationScreen(
                                jobTitle: job.jobTitle!,
                              ),
                            ),
                          );
                        },
                        jobtitle: job?.jobTitle ?? '',
                        isParttime: job?.jobType ?? '',
                        jobpay: job?.saleryPkg ?? '',
                        joblocation: job!.city ?? '',
                        lastDate: job?.closingDate != null
                            ? job!.closingDate!.toString()
                            : '',
                        postedDate: job!.createdAt != null
                            ? job.createdAt!.toString()
                            : '',
                      );
                    },
                  ),
                )
              ]),
        ),
        if (isLoading)
          Center(
            child:
                CircularProgressIndicator(), // Show circular progress indicator
          ),
      ]),
    );
  }
}

class JobContainer extends StatelessWidget {
  final String jobtitle;
  final String joblocation;
  final String jobpay;
  final String isParttime;
  final String postedDate;
  final String lastDate;
  final VoidCallback? onTap;

  JobContainer({
    Key? key,
    this.onTap,
    required this.jobtitle,
    required this.isParttime,
    required this.jobpay,
    required this.joblocation,
    required this.lastDate,
    required this.postedDate,
  }) : super(key: key);

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.asset(
                'assets/images/avatar-1299805_1920.png',
                height: 200,
              ),
              title: Text(
                jobtitle.toUpperCase(),
                style: TextStyle(
                    fontSize: 27,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        joblocation,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(Icons.timer_sharp, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(isParttime, style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(Icons.payment_outlined, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        jobpay,
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.date_range, color: Colors.blue),
                    SizedBox(width: 5),
                    Text("Posted Date : ${formatDate(postedDate)}"),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.date_range, color: Colors.blue),
                    SizedBox(width: 5),
                    Text("Last Date : ${formatDate(lastDate)}"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onTap,
              child: Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }
}
