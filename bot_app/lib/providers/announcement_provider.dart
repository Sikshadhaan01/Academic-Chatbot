import 'package:flutter/cupertino.dart';
import 'package:flutter_new/services/subject_service.dart';

class AnnouncementProvider extends ChangeNotifier {
  List announcements = [];
  getAllAnnouncements() async {
    var response = await SubjectService().getAllAnnouncements();
    announcements = response['result'];
    notifyListeners();
  }

  removeAnnouncement(index){
    announcements.removeAt(index);
    notifyListeners();
  }

  addAnnouncement(announcement){
    announcements.add(announcement);
    notifyListeners();
  }

  getAllAnnouncementsFromIndex(announcement){
    int index = announcements.indexOf(announcement);
    return announcements.sublist(index);
  }
}
