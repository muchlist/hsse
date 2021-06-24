import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/violation.dart';
import '../utils/utils.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ViolationProvider _violationProvider;

  // tidak menggunakan provider supaya misi menggunakan stateful terpenuhi
  bool _markWarning = false;

  void _togleMarkWarning() {
    setState(() {
      _markWarning = !_markWarning;
    });
  }

  @override
  void initState() {
    _violationProvider = context.read<ViolationProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detail = _violationProvider.detail!;
    var status = "Belum disetujui";
    if (detail.approved) {
      status = "Disetujui";
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Detail"),
          actions: [
            Center(
                child: const Text(
              "send warning",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )),
            (_markWarning)
                ? IconButton(
                    onPressed: _togleMarkWarning,
                    icon: const Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.red,
                    ))
                : IconButton(
                    onPressed: _togleMarkWarning,
                    icon: const Icon(
                      Icons.warning_amber_outlined,
                    )),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                if (detail.imgUrl.isNotEmpty) buildImage(detail.imgUrl),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.id,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          detail.location,
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            detail.detail,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Status : $status"),
                        Text("Approver : ${detail.approver}"),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              detail.date.toDisplay(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  ClipRRect buildImage(String imgUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Hero(
        tag: imgUrl,
        child: Image.asset(
          imgUrl,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
