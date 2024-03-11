import 'dart:convert';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import "package:flutter/material.dart";
import 'package:freelance_app/screens/homescreen/components/categories.dart';
import 'package:freelance_app/screens/homescreen/sidebar.dart';
import 'package:freelance_app/screens/profile/profile.dart';
import 'package:freelance_app/screens/search/search_screen.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:http/http.dart' as http;

import '../../config/SharedPreferencesManager.dart';
import '../JobApplication/JobApplicationScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationPage(
        title: "getJOBS",
      ),
    );
  }
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late int currentIndex;

  bool isLoading = false;
  List<Job>? searchResults = [];

  String? token;
  String? userID;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    fetchJobs('network engineer');
    _loadToken();
  }

  Future<void> fetchJobs(String query) async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://www.jobportal.ai-teacher.org/api/jobs/search/?query=$query',
        ),
      );

      if (response.statusCode == 200) {
        final jobSearch = JobSearch.fromJson(jsonDecode(response.body));
        setState(() {
          searchResults = jobSearch.data?.job;
        });
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        isLoading =
            false; // Set loading state to false after search is completed
      });
    }
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  Future<void> _loadToken() async {
    final loadedToken =
        await SharedPreferencesManager.getToken(); // load token here
    final loadedid = await SharedPreferencesManager.getUserID();
    setState(() {
      token = loadedToken;
      userID = loadedid;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Token is");
    String? _uid = ''; // load user id here
    print("User id is ${userID}}");
    print(_uid);
    return Scaffold(
      body: <Widget>[
        const Homepage(),
        const Search(),
        ProfilePage(),
      ][currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Colors.white,
        hasNotch: false,
        opacity: 0.5,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(0),
        ),
        tilesPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        items: const <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.blueGrey,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.blueGrey,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            title: Text(
              "Search",
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.blueGrey,
            icon: Icon(
              Icons.library_books,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.library_books,
              color: Colors.white,
            ),
            title: Text(
              "Profile",
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
        ],
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                "Find Your Perfect ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Text(
                "Job",
                style: TextStyle(
                  color: yellow,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            Category(),
            SizedBox(
              height: 10,
            ),
            AllJobs(),
          ],
        ),
      ),
    );
  }
}

class AllJobs extends StatefulWidget {
  const AllJobs({Key? key}) : super(key: key);

  @override
  State<AllJobs> createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  List<Job> jobs = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllJobs("");
  }

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
          jobs = jobSearch.data?.job ?? [];
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : jobs.isEmpty
            ? Center(
                child: Text('No jobs found'),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
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
                      jobtitle: job.jobTitle ?? '',
                      isParttime: job.jobType ?? '',
                      jobpay: job.saleryPkg ?? '',
                      joblocation: job.city ?? '',
                      lastDate: job.closingDate != null
                          ? job.closingDate!.toString()
                          : '',
                      postedDate: job.createdAt != null
                          ? job.createdAt!.toString()
                          : '',
                    );
                  },
                ),
              );
  }
}

class JobSearch {
  int? status;
  bool? success;
  String? message;
  Data? data;

  JobSearch({this.status, this.success, this.message, this.data});

  JobSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Job>? job;

  Data({this.job});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['job'] != null) {
      job = <Job>[];
      json['job'].forEach((v) {
        job!.add(Job.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (job != null) {
      data['job'] = job!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Job {
  int? id;
  String? applicantsId;
  int? companyId;
  String? status;
  String? city;
  String? jobTitle;
  String? jobType;
  int? vacancy;
  String? closingDate;
  String? saleryPkg;
  String? jobFilter;
  String? experience;
  String? education;
  String? description;
  String? responsibility;
  String? benefits;
  String? createdAt;
  String? updatedAt;

  Job({
    this.id,
    this.applicantsId,
    this.companyId,
    this.status,
    this.city,
    this.jobTitle,
    this.jobType,
    this.vacancy,
    this.closingDate,
    this.saleryPkg,
    this.jobFilter,
    this.experience,
    this.education,
    this.description,
    this.responsibility,
    this.benefits,
    this.createdAt,
    this.updatedAt,
  });

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    applicantsId = json['applicants_id'] as String?;
    companyId = json['company_id'] as int?;
    status = json['status'] as String?;
    city = json['city'] as String?;
    jobTitle = json['job_title'] as String?;
    jobType = json['job_type'] as String?;
    vacancy = json['vacancy'] as int?;
    closingDate = json['closing_date'] as String?;
    saleryPkg = json['salery_pkg'] as String?;
    jobFilter = json['job_filter'] as String?;
    experience = json['experience'] as String?;
    education = json['education'] as String?;
    description = json['description'] as String?;
    responsibility = json['responsibility'] as String?;
    benefits = json['benefits'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicants_id'] = applicantsId;
    data['company_id'] = companyId;
    data['status'] = status;
    data['city'] = city;
    data['job_title'] = jobTitle;
    data['job_type'] = jobType;
    data['vacancy'] = vacancy;
    data['closing_date'] = closingDate;
    data['salery_pkg'] = saleryPkg;
    data['job_filter'] = jobFilter;
    data['experience'] = experience;
    data['education'] = education;
    data['description'] = description;
    data['responsibility'] = responsibility;
    data['benefits'] = benefits;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
