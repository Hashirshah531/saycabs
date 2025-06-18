import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'article.dart';
import 'articleDetailPage.dart';
import 'chatbot_widget.dart';
import 'hvoer.dart';
import 'location.dart';
final TextEditingController pickupLocationController = TextEditingController();
final TextEditingController destinationController = TextEditingController();
final TextEditingController pickupDateController = TextEditingController();
final TextEditingController pickupTimeController = TextEditingController();

class AlphaCarsDashboard extends StatefulWidget {
  const AlphaCarsDashboard({super.key});

  @override
  State<AlphaCarsDashboard> createState() => _AlphaCarsDashboardState();
}

class _AlphaCarsDashboardState extends State<AlphaCarsDashboard> {

  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _fleetKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _whyBookKey = GlobalKey();
  final GlobalKey _articlesKey = GlobalKey();


  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Rating logic at the top of your widget class
  int _selectedRating = 0;
  bool _isHuman = false;
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 20,

            floating: false,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Icon(Icons.ac_unit,color: Colors.amber,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem('Home', () => _scrollTo(_homeKey)),
                          _buildNavItem('Services', () => _scrollTo(_servicesKey)),
                          _buildNavItem('Fleet', () => _scrollTo(_fleetKey)),
                          _buildNavItem('About Us', () => _scrollTo(_aboutKey)),_buildNavItem('Why Book Us', () => _scrollTo(_whyBookKey)),
                          _buildNavItem('Contact', () => _scrollTo(_contactKey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            key: _homeKey,
            child: Container(
              height: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/hero-bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.6),
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'SayCabs Services',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Luxury travel at competitive prices',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 40),
                    BookingForm()
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            key: _servicesKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                children: [
                  const Text(
                    'OUR SERVICES',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'We offer a range of premium chauffeur services',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OnHover(
                          builder: (isHovered) => _buildServiceCard(
                            icon: Icons.airport_shuttle,
                            title: 'Airport Transfers',
                            description: 'Reliable transfers to all major airports',
                            isHovered: isHovered,
                          ),
                        ),
                      ),

                      Expanded(
                        child: OnHover(
                          builder: (isHovered) => _buildServiceCard(
                            icon: Icons.airport_shuttle,
                            title: 'Airport Transfers',
                            description: 'Reliable transfers to all major airports',
                            isHovered: isHovered,
                          ),
                        ),
                      ),

                      Expanded(
                        child: OnHover(
                          builder: (isHovered) => _buildServiceCard(
                            icon: Icons.airport_shuttle,
                            title: 'Airport Transfers',
                            description: 'Reliable transfers to all major airports',
                            isHovered: isHovered,
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            key: _fleetKey,
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                children: [
                  const Text(
                    'OUR FLEET',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Modern, luxury vehicles for every occasion',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OnHover(
                          builder: (isHovered) => _buildVehicleCard(
                            image: 'assets/2.png',
                            name: 'Mercedes S-Class',
                            capacity: '3 passengers',
                            isHovered: isHovered,
                          ),
                        ),
                        OnHover(
                          builder: (isHovered) => _buildVehicleCard(
                            image: 'assets/6.jpeg',
                            name: 'BMW 7 Series',
                            capacity: '3 passengers',
                            isHovered: isHovered,
                          ),
                        ),
                        OnHover(
                          builder: (isHovered) => _buildVehicleCard(
                            image: 'assets/10.jpeg',
                            name: 'Range Rover',
                            capacity: '4 passengers',
                            isHovered: isHovered,
                          ),
                        ),
                        OnHover(
                          builder: (isHovered) => _buildVehicleCard(
                            image: 'assets/3.jpeg',
                            name: 'Executive Minibus',
                            capacity: '8 passengers',
                            isHovered: isHovered,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            key: _whyBookKey,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title with gradient yellow text
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.amber.shade600, Colors.amber.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'WHY BOOK A TRANSFER WITH SAYCABS?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber.shade500, Colors.amber.shade900],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.shade700.withOpacity(0.7),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Subtitle / description
                  const Text(
                    'Experience the difference with SayCabs transfers — seamless, reliable, and tailored to your needs. Whether it’s airport pickups, corporate travel, or special occasions, we deliver excellence every mile of the way.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Feature cards row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFeatureCard(
                          icon: Icons.timer,
                          title: 'Punctual & Reliable',
                          description: 'Never worry about delays with our on-time guarantee.',
                        ),
                        _buildFeatureCard(
                          icon: Icons.security,
                          title: 'Safe & Secure',
                          description: 'Your safety is our top priority with trained chauffeurs.',
                        ),
                        _buildFeatureCard(
                          icon: Icons.local_taxi,
                          title: 'Wide Fleet',
                          description: 'Choose from luxury sedans to spacious minibuses.',
                        ),
                        _buildFeatureCard(
                          icon: Icons.smartphone,
                          title: 'Easy Booking',
                          description: 'Quick and hassle-free reservations via app or web.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            key: _articlesKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LATEST ARTICLES',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: articles.map((article) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ArticleDetailPage(article: article)),
                          );
                        },
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.amber, width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                child: Image.network(
                                  article.imageUrl,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      article.summary,
                                      style: const TextStyle(color: Colors.black87),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Read more...', style: TextStyle(color: Colors.amber)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              color: Colors.black,
              child: Column(
                children: [
                  // Section Title
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.amber.shade400, Colors.amber.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'WHAT OUR CUSTOMERS SAY',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Review Cards
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: List.generate(6, (index) {
                      final names = ['Ali Khan', 'Sophie Williams', 'Rajesh Mehta', 'Emily Chen', 'John Taylor', 'Zara Noor'];
                      final roles = ['Traveler', 'Event Manager', 'Entrepreneur', 'Consultant', 'Student', 'Photographer'];
                      final reviews = [
                        'SayCabs picked me up right on time and the ride was super smooth!',
                        'Our wedding guests were impressed with the luxury vans. Flawless coordination!',
                        'Drivers are polite and cars are always clean. I trust SayCabs every time.',
                        'Quick booking, reliable drivers and a safe ride every single time.',
                        'Perfect for airport runs! No stress, just comfort and efficiency.',
                        'Booked for a photo shoot crew. Driver was professional and very cooperative.',
                      ];
                      final rating = [5, 4, 5, 5, 4, 5];

                      return Container(
                        width: 300,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.amber.shade600, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rating Stars
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < rating[index] ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                );
                              }),
                            ),
                            const SizedBox(height: 12),

                            // Review Text
                            Text(
                              '“${reviews[index]}”',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Name and Role
                            Text(
                              names[index],
                              style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              roles[index],
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 60),

                  // Add Review Section
                  Container(
                    width: 600,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber.shade600, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Leave a Review',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            labelStyle: const TextStyle(color: Colors.amber),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller: _reviewController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Your Review',
                            labelStyle: const TextStyle(color: Colors.amber),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 20),

                        // Star Rating
                        Row(
                          children: [
                            const Text(
                              'Your Rating:',
                              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            ...List.generate(5, (index) {
                              return IconButton(
                                onPressed: () {
                                  _selectedRating = index + 1;
                                },
                                icon: Icon(
                                  index < _selectedRating ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                ),
                              );
                            }),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // I'm not a robot checkbox
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.amber,
                              value: _isHuman,
                              onChanged: (value) {
                                _isHuman = value ?? false;
                              },
                            ),
                            const Text(
                              "I'm not a robot",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Submit button
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_isHuman && _selectedRating > 0) {
                              // TODO: Handle review submission
                            } else {
                              // Show error if rating or robot check not selected
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          ),
                          icon: const Icon(Icons.send,color: Colors.black,),
                          label: const Text(
                            'Submit Review',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),



          SliverToBoxAdapter(
            key: _aboutKey,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title with gradient yellow text
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.amber.shade600, Colors.amber.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'ABOUT SAYCABS',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.white, // This color is masked by shader
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Decorative underline with glow
                  Container(
                    width: 80,
                    height: 5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber.shade500, Colors.amber.shade900],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.shade700.withOpacity(0.7),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Multi-style RichText for creativity
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.7,
                        letterSpacing: 0.5,
                        color: Colors.white70,
                      ),
                      children: [
                        const TextSpan(
                          text:
                          'At ',
                        ),
                        TextSpan(
                          text: 'SayCabs, ',
                          style: TextStyle(
                            color: Colors.amber.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                          'we don’t just provide rides — we deliver experiences. From the moment you book with us, you enter a world where ',
                        ),
                        TextSpan(
                          text: 'comfort, reliability, and luxury ',
                          style: TextStyle(
                            color: Colors.amber.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                          'are not just promises but guarantees.\n\nOur diverse fleet of modern vehicles is meticulously maintained, ensuring every journey is smooth and stylish. Whether it’s a quick city trip or a long-distance travel, our professional chauffeurs prioritize your safety and punctuality.\n\nWe’re passionate about redefining urban transportation — blending ',
                        ),
                        TextSpan(
                          text: 'technology ',
                          style: TextStyle(
                            color: Colors.amber.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                          'and ',
                        ),
                        TextSpan(
                          text: 'personalized service ',
                          style: TextStyle(
                            color: Colors.amber.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                          'to create seamless, stress-free rides tailored to your needs.\n\nChoose SayCabs — where every trip is more than just a ride; it’s a statement of quality and care.\n\nJoin thousands of satisfied customers who trust us daily for their travel needs, and discover the new standard in cab services.',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Call to action button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[600],
                      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 12,
                      shadowColor: Colors.amber.withOpacity(0.8),
                    ),
                    onPressed: () {
                      // Add booking or navigation logic here
                    },
                    child: const Text(
                      'BOOK YOUR RIDE NOW',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          SliverToBoxAdapter(
            key: _contactKey,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFooterColumn(
                        title: 'About AlphaCars',
                        items: [
                          'Our Company',
                          'Why Choose Us',
                          'Testimonials',
                          'Careers',
                        ],
                      ),
                      _buildFooterColumn(
                        title: 'Our Services',
                        items: [
                          'Airport Transfers',
                          'Corporate Travel',
                          'Special Events',
                          'Hourly Hire',
                        ],
                      ),
                      _buildFooterColumn(
                        title: 'Contact Us',
                        items: [
                          '+447417508077',
                          'support@saycabs.com',
                          '24/7 Customer Support',
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '© 2025 Saycaps. All Rights Reserved.',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating chatbot button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        onPressed: () => _showChatBotBottomSheet(context),
        child: const Icon(Icons.chat, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showChatBotBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ChatBotBottomSheet(),
    );
  }
}

  Widget _buildNavItem(String text, VoidCallback onTap, [bool isActive = false]) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.amber : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


Widget _buildFormField(String label, IconData icon, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    enabled: false,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      prefixIcon: Icon(icon),
    ),
  );
}

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isHovered,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: isHovered ? -10 : 0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHovered ? Colors.amber : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: Colors.amber),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard({
    required String image,
    required String name,
    required String capacity,
    bool isHovered = false,
  }) {
     return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: isHovered ? -10 : 0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHovered ? Colors.amber : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                image,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          ],
        ),
      ),
    );

  }

  Widget _buildFooterColumn({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(item, style: const TextStyle(color: Colors.white54)),
        )),
      ],
    );
  }
// Helper widget for the feature card
Widget _buildFeatureCard({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Container(
    width: 280,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.amber.shade700, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber.shade600.withOpacity(0.2),
          ),
          child: Icon(
            icon,
            size: 40,
            color: Colors.amber.shade600,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade400,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}