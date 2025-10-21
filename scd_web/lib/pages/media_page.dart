import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scd_web/data/models/gallery_item_model.dart';
import 'package:scd_web/data/services/firestore_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GalleryItemModel>>(
      future: FirestoreService.instance.getGalleryItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No media found.'));
        }

        final items = snapshot.data!;

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GalleryItemCard(item: items[index]);
          },
        );
      },
    );
  }
}

class GalleryItemCard extends StatelessWidget {
  final GalleryItemModel item;
  const GalleryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isVideo = item.type == 'video';
    // Use the video thumbnail if available, otherwise use the main URL for photos.
    final String displayUrl =
        (isVideo ? item.thumbnailUrl : item.url) ?? item.url;

    return InkWell(
      onTap: () => launchUrl(Uri.parse(item.url)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: displayUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade800),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            if (isVideo)
              const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 60,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
