import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/viol_list_resp.dart';
import 'package:hsse/config/url.dart';
import 'package:hsse/screen/components/cached_image.dart';
import '../../config/theme_color.dart';
import '../../utils/utils.dart';

class ViolationTile extends StatelessWidget {
  final ViolMinData data;

  const ViolationTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.images.isNotEmpty)
                Hero(
                    tag: data.images[0],
                    child: CachedImage(
                      urlPath: "${ConstUrl.baseUrl}${data.images[0]}",
                      width: double.infinity,
                    )),
              const SizedBox(
                height: 5,
              ),
              Text(data.noIdentity,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(data.detailViolation,
                      style: TextStyle(
                          fontWeight: FontWeight.w100, color: Colors.grey))),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  if (data.approvedAt != 0)
                    const Icon(
                      Icons.check_circle_outline,
                      color: TColor.primary,
                    ),
                  const Spacer(),
                  Text(
                    data.timeViolation.getCompleteDateString(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
