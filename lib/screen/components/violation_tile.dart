import 'package:flutter/material.dart';
import '../../config/theme_color.dart';
import '../../models/violation.dart';
import '../../utils/utils.dart';

class ViolationTile extends StatelessWidget {
  final Violation data;

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
              if (data.imgUrl.isNotEmpty)
                Hero(
                  tag: data.imgUrl,
                  child: Image.asset(
                    data.imgUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              Text(data.id, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(data.detail,
                      style: TextStyle(
                          fontWeight: FontWeight.w100, color: Colors.grey))),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  if (data.approved)
                    const Icon(
                      Icons.check_circle_outline,
                      color: TColor.primary,
                    ),
                  const Spacer(),
                  Text(data.date.toDisplay())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
