import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/network/api_service.dart';  // Add http to pubspec.yaml

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({Key? key}) : super(key: key);

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();
  List<String> _imageUrls = [];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchBannerImages();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }


  Future<void> _fetchBannerImages() async {
    try {
      final api = ApiService();
      final response = await api.getBanner();
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          setState(() {
            _imageUrls = data
                .map<String>((item) => item['image'] as String)
                .toList();
          });
          _startAutoScroll();
        } else {
          print('API status false: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching banners: $e');
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_controller.hasClients && _imageUrls.isNotEmpty) {
        int nextPage = (_currentPage + 1) % _imageUrls.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageUrls.isEmpty
        ? const SizedBox(
      height: 200,
      child: Center(child: CircularProgressIndicator()),
    )
        : Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: _imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                _imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image));
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(_imageUrls.length, (index) {
        //     return AnimatedContainer(
        //       duration: const Duration(milliseconds: 300),
        //       margin: const EdgeInsets.symmetric(horizontal: 4),
        //       width: _currentPage == index ? 12 : 8,
        //       height: _currentPage == index ? 12 : 8,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: _currentPage == index ? Colors.blue : Colors.grey,
        //       ),
        //     );
        //   }),
        // ),
      ],
    );
  }
}
