import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget churchListCustom({
  required String name,
  required String pastorName,
  required String logo_url,
  onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            imageUrl: logo_url,
            fit: BoxFit.fill,
            placeholder: (context, url) => FadeShimmer.round(
              size: 60,
              fadeTheme: Get.isDarkMode ? FadeTheme.dark : FadeTheme.dark,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.length > 20 ? '${name.substring(0, 20)}...' : name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                pastorName,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
