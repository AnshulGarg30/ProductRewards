import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ProductCard extends StatefulWidget {
  final dynamic data;
  final String type; // 'product' or 'catalog'

  const ProductCard({
    super.key,
    required this.data,
    required this.type,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isDownloading = false;
  double _progress = 0.0;

  Future<void> downloadAndOpenPdf(
      BuildContext context, String url, String fileName) async {
    try {
      setState(() {
        _isDownloading = true;
        _progress = 0.0;
      });

      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      final dio = Dio();

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            setState(() {
              _progress = progress;
            });
            debugPrint("Downloading: ${(progress * 100).toStringAsFixed(0)}%");
          }
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Download completed")),
      );

      OpenFile.open(filePath);
    } catch (e) {
      debugPrint("Download error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading PDF: $e")),
      );
    } finally {
      setState(() {
        _isDownloading = false;
        _progress = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final type = widget.type;
    final String name = data.name ?? 'No Name';
    final String imageUrl = data.imageUrl ?? '';
    final String points = data.point ?? "0";

    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 60),
            ),
          ),

          // Name and Points with Download
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$points Points',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    if (type == 'catalog') ...[
                      _isDownloading
                          ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: _progress,
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
                          downloadAndOpenPdf(
                            context,
                            data.pdf,
                            '${data.name}_${data.id}.pdf',
                          );
                        },
                        child: const Icon(Icons.download,
                            size: 16, color: Colors.blue),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
