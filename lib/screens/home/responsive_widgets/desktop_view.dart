import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/core/widgets/custom_textfiled.dart';
import 'package:my_portfolio/screens/home/widgets/custom_button.dart';
import 'package:my_portfolio/screens/home/widgets/project_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  final ScrollController _scrollController = ScrollController();
  String _selectedTab = 'Home';
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double scrollPosition = _scrollController.position.pixels;

    final double aboutOffset = MediaQuery.of(context).size.height * 0.6;
    final double projectsOffset = MediaQuery.of(context).size.height * 1.5;
    final double contactOffset = MediaQuery.of(context).size.height * 2.0;
    if (scrollPosition >= contactOffset) {
      setState(() => _selectedTab = 'Contact');
    } else if (scrollPosition >= projectsOffset) {
      setState(() => _selectedTab = 'Projects');
    } else if (scrollPosition >= aboutOffset) {
      setState(() => _selectedTab = 'About me');
    } else {
      setState(() => _selectedTab = 'Home');
    }
  }

  void _scrollToSection(String section) {
    setState(() {
      _selectedTab = section;
    });

    // Calculate the offset for each section
    double offset = 0;
    switch (section) {
      case 'Home':
        offset = 0;
        break;
      case 'About me':
        offset = MediaQuery.of(context).size.height * 0.7;
        break;
      case 'Projects':
        offset = MediaQuery.of(context).size.height * 1.5;
        break;
      case 'Contact':
        offset = MediaQuery.of(context).size.height * 2.5;
        break;
    }

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://formspree.io/f/mzzerbne'),
        body: {
          'name': _nameController.text,
          'email': _emailController.text,
          'subject': _subjectController.text,
          'message': _messageController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error submitting form. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double headerPadding = screenSize.width * 0.1;
    final double contentPadding = screenSize.width * 0.1;

    final double titleFontSize = screenSize.width * 0.018;
    final double headingFontSize = screenSize.width * 0.016;
    final double largeFontSize = screenSize.width * 0.028;
    final double bodyFontSize = screenSize.width * 0.012;
    final double smallFontSize = screenSize.width * 0.010;

    final double sectionSpacing = screenSize.height * 0.025;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(100, 100),
        child: Container(
          key: const Key('Home'),
          padding: EdgeInsets.symmetric(
            horizontal: headerPadding,
            vertical: screenSize.height * 0.02,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF181824),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SUDALAI GANESH M',
                style: TextStyle(
                  color: const Color(0xFF6859c7),
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  tabText('Home', smallFontSize),
                  tabText('About me', smallFontSize),
                  tabText('Projects', smallFontSize),
                  tabText('Contact', smallFontSize),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Header Section

            // Main Content
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: contentPadding,
                vertical: screenSize.height * 0.06,
              ),
              decoration: const BoxDecoration(color: Color(0xFF1b1a28)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left text content
                      SizedBox(
                        width: screenSize.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, i'm",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: headingFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: sectionSpacing * 0.5),
                            Text(
                              "Sudalai Ganesh M",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: largeFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: sectionSpacing * 0.5),
                            Text(
                              "Flutter developer with 2 years of experience. I have completed many projects that prove my ability to provide creative and high-quality solutions.",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: bodyFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            Row(
                              children: [
                                CustomButton(
                                  onTap: () {
                                    _scrollToSection('About me');
                                  },
                                  text: 'About me',
                                  icon: Icons.person,
                                ),
                                SizedBox(width: screenSize.width * 0.02),
                                CustomButton(
                                  onTap: () {
                                    _scrollToSection('Projects');
                                  },
                                  text: 'Projects',
                                  icon: Icons.remove_red_eye,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Profile image with circle
                      Stack(
                        children: [
                          Container(
                            height: screenSize.width * 0.35,
                            width: screenSize.width * 0.25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF6859c7),
                            ),
                          ),
                          Positioned(
                            top: -screenSize.width * 0.001,
                            left: screenSize.width * 0.035,
                            right: screenSize.width * 0.030,
                            bottom: screenSize.width * 0.06,
                            child: Image.asset('assets/images/me.png'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // About Me Section
                  SizedBox(height: sectionSpacing * 1.5),
                  Text(
                    'About me',
                    key: const Key('About me'),
                    style: TextStyle(
                      color: const Color(0xFF6859c7),
                      fontSize: headingFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
                  Text(
                    "I'm a Flutter Developer with a good understanding of the Flutter Framework, I have experience in API integration, clean code writing, and knowledge of solid principles and clean architecture. I have completed many projects that prove my ability to provide creative and high-quality solutions and finish them in an almost complete way with a great user experience without any problems facing users",
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: bodyFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Divider
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: sectionSpacing),
                      height: 2,
                      width: screenSize.width * 0.25,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),

                  // Experience
                  Row(
                    children: [
                      Text(
                        '2+',
                        style: TextStyle(
                          color: const Color(0xFF6859c7),
                          fontSize: largeFontSize * 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      Expanded(
                        child: Text(
                          "Years of experience, Specialized in building apps, while ensuring a seamless web experience for end users.",
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: bodyFontSize * 1.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: sectionSpacing * 1.5),

                  // Mobile Development Box
                  Center(
                    child: Container(
                      height: screenSize.height * 0.35,
                      width: screenSize.width * 0.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color(0xFF6859c7),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/android.svg',
                                color: const Color(0xFFFFFFFF),
                                height: screenSize.width * 0.03,
                              ),
                              SizedBox(width: screenSize.width * 0.015),
                              SvgPicture.asset(
                                'assets/images/ios.svg',
                                color: const Color(0xFFFFFFFF),
                                height: screenSize.width * 0.03,
                              ),
                            ],
                          ),
                          SizedBox(height: sectionSpacing * 0.5),
                          Text(
                            'MOBILE DEVELOPMENT',
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: bodyFontSize * 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: sectionSpacing * 0.5),
                          Text(
                            "I am a junior mobile developer. I have experience using \nDart and Flutter Framework.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: bodyFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Featured Projects Section
                  SizedBox(height: sectionSpacing * 1.5),
                  Text(
                    'Featured projects',
                    key: const Key('Projects'),
                    style: TextStyle(
                      color: const Color(0xFF6859c7),
                      fontSize: headingFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
                  Text(
                    "I have completed many projects that my ability to provide creative and high-quality solutions and finish them in an almost complete way with a great user experience without any problems facing users.",
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: bodyFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),

                  // Project Grid
                  SizedBox(
                    // Responsive height based on number of rows needed (5 projects / 3 columns = 2 rows)
                    height: screenSize.width * 0.50,
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: screenSize.width * 0.01,
                      mainAxisSpacing: screenSize.width * 0.01,
                      children: const [
                        ProjectCard(
                          title: 'The Movers',
                          description:
                              'A convenient solution for shifting home appliances from one place to another. It offers easy booking.',
                          iconText: 'TM',
                          isPlayStore: true,
                        ),
                        ProjectCard(
                          title: 'Meditation App',
                          description:
                              'Users schedule and start meditation sessions with a built-in timer. It allows task-based meditation tracking for a focused and relaxing experience.',
                          iconText: 'M',
                          isPlayStore: false,
                        ),
                        ProjectCard(
                          title: 'Clinical Assesment App',
                          description:
                              'Users to register students and manually upload their images. It enables selecting descriptions to predict scores using the SQFlite database. Easily manage student data and track performance efficiently!',
                          iconText: 'CA',
                          isPlayStore: false,
                        ),
                        ProjectCard(
                          title: 'Kings Chic Signature',
                          description:
                              'Users browse and order delicious meals with ease. It features real-time tracking, allowing customers to monitor their orders live. Enjoy a seamless and convenient food delivery experience!',
                          iconText: 'KCS',
                          isPlayStore: true,
                        ),
                        ProjectCard(
                          title: 'Attendance App',
                          description:
                              'Simplifies check-ins using a barcode scanner for quick and accurate tracking. Users can scan barcodes to mark attendance efficiently. Ideal for schools.',
                          iconText: 'A',
                          isPlayStore: false,
                        ),
                      ],
                    ),
                  ),
                  // Contact Section
                  SizedBox(height: sectionSpacing * 1.5),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side text content
                      SizedBox(
                        width: screenSize.width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact with me',
                              key: const Key('Contact'),
                              style: TextStyle(
                                color: const Color(0xFF6859c7),
                                fontSize: headingFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            Text(
                              "For any service and work you can contact with me by send an email or by our social media accounts.",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: bodyFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            // Social media icons row
                            Row(
                              children: [
                                socialMediaButton(
                                  icon: 'assets/images/facebook.svg',
                                  color: const Color(0xFF6859c7),
                                  url:
                                      'https://www.facebook.com/sudalai.ganesh.35/',
                                ),
                                SizedBox(width: screenSize.width * 0.01),
                                socialMediaButton(
                                  icon:
                                      'assets/images/instagram.svg', // For Instagram
                                  color: const Color(0xFF6859c7),
                                  url: 'https://www.instagram.com/mr.tuty_boy/',
                                ),
                                SizedBox(width: screenSize.width * 0.01),
                                socialMediaButton(
                                  icon:
                                      'assets/images/linkedin.svg', // For LinkedIn
                                  color: const Color(0xFF6859c7),
                                  url:
                                      'https://www.linkedin.com/in/sudalai-ganesh-m',
                                ),
                                SizedBox(width: screenSize.width * 0.01),
                                socialMediaButton(
                                  icon:
                                      'assets/images/twitter.svg', // For Twitter/X
                                  color: const Color(0xFF6859c7),
                                  url: 'https://x.com/ganesh_dev_0610',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Right side contact form
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          width: screenSize.width * 0.45,
                          child: Column(
                            children: [
                              // Name field
                              CustomTextField(
                                  hintText: 'Name',
                                  controller: _nameController),
                              CustomTextField(
                                  hintText: 'E-mail',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController),
                              CustomTextField(
                                  hintText: 'Subject',
                                  controller: _subjectController),
                              CustomTextField(
                                  hintText: 'Type a message here...',
                                  maxLines: 5,
                                  controller: _messageController),

                              // Submit button
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xFF6859c7),
                                ),
                                child: TextButton(
                                  onPressed: _submitForm,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: bodyFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabText(String text, double fontSize) {
    return TextButton(
      onPressed: () => _scrollToSection(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          text,
          style: TextStyle(
            color:
                _selectedTab == text ? Colors.white : const Color(0xFF6859c7),
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget socialMediaButton(
      {required String icon, required Color color, required String url}) {
    return TextButton(
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
