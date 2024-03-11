import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelance_app/screens/homescreen/components/job_details.dart';
import 'package:freelance_app/utils/global_methods.dart';

import '../Models/job_search.dart';
import '../utils/clr.dart';
import '../utils/layout.dart';
import "../utils/txt.dart";

class JobTile extends StatelessWidget {
  final Job job;

  const JobTile({required this.job});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: layout.padding / 2),
      child: Card(
        elevation: layout.elevation,
        color: clr.card,
        child: ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailsScreen(
                  id: job.updatedAt!,
                  job_id: job.id.toString(),
                ),
              ),
            );
          },
          onLongPress: () {
            _deleteDialog(context);
          },
          contentPadding: const EdgeInsets.all(layout.padding / 2),
          leading: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1),
              ),
            ),
            //child: Image.network(job.),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: layout.padding / 4),
            child: Text(
              job.jobTitle!,
              style: txt.subTitleDark,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: layout.padding / 4),
                child: Text(
                  job.jobTitle!,
                  style: txt.body2Dark,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: layout.padding / 4),
                child: Text(
                  job.jobType!,
                  style: txt.body1Dark,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: clr.dark,
            size: layout.iconMedium,
          ),
        ),
      ),
    );
  }

  void _deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.all(layout.padding),
              child: Column(
                children: [
                  const Text(
                    'Are you sure you want to delete this job?',
                    style: txt.subTitleDark,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _textButtonDelete(context),
                      _textButtonCancel(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _textButtonDelete(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          // You can add your delete logic here using the job id
          Navigator.pop(context);
          Navigator.pop(context);
          await Fluttertoast.showToast(
            msg: 'The job has been successfully deleted',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: clr.passive,
            fontSize: txt.textSizeDefault,
          );
        } catch (error) {
          GlobalMethod.showErrorDialog(
            context: context,
            icon: Icons.error,
            iconColor: clr.error,
            title: 'Error',
            body: 'Unable to delete job',
            buttonText: 'OK',
          );
        }
      },
      child: Row(
        children: const [
          Icon(
            Icons.delete,
            color: Colors.red,
          ),
          Text(
            ' Yes',
            style: txt.body2Dark,
          ),
        ],
      ),
    );
  }

  Widget _textButtonCancel(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Row(
        children: const [
          Icon(
            Icons.cancel,
            color: clr.primary,
          ),
          Text(
            ' No',
            style: txt.body2Dark,
          ),
        ],
      ),
    );
  }
}
