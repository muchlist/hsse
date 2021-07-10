import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/viol_list_resp.dart';
import 'package:hsse/config/url.dart';
import 'package:hsse/screen/components/cached_image.dart';
import 'package:hsse/singleton/shared_pref.dart';
import '../../config/theme_color.dart';
import '../../utils/utils.dart';

class ViolationTile extends StatelessWidget {
  const ViolationTile({Key? key, required this.data}) : super(key: key);
  final ViolMinData data;

  @override
  Widget build(BuildContext context) {
    final bool _createdByCurrentAccountAndHaveNotBeeApproved =
        (data.state == 0 || data.state == 1) &&
            (data.createdBy == SharedPrefs().getName());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: _createdByCurrentAccountAndHaveNotBeeApproved
              ? Border.all(
                  color: Colors.blue.shade400.withOpacity(0.9), width: 2)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(data.detailViolation,
                      style: const TextStyle(
                          fontWeight: FontWeight.w100, color: Colors.grey))),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  getIcon(data.state),
                  const Spacer(),
                  Text(
                    data.timeViolation.getCompleteDateString(),
                    style: const TextStyle(
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
