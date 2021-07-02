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
                  getIcon(data.state),
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

  Icon getIcon(int state) {
    switch (state) {
      case 0: //draft
        return const Icon(
          Icons.drive_file_rename_outline_outlined,
          color: Colors.grey,
        );
      case 1: // ready
        return const Icon(
          Icons.send_and_archive_sharp,
          color: Colors.grey,
        );
      default: // approved
        return const Icon(
          Icons.check_box,
          color: TColor.primary,
        );
    }
  }
}
