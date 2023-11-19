import '../../model/application/application_form.dart';
import '../../provider/application/application_local_provider.dart';
import '../../provider/application/application_provider.dart';

class ApplicationRepository {
  final ApplicationLocalProvider applicationLocalProvider;
  final ApplicationProvider applicationProvider;

  ApplicationRepository({
    required this.applicationLocalProvider,
    required this.applicationProvider,
  });

  ApplicationForm getApplicationForm() {
    return applicationLocalProvider.getDummyApplicationForm();
  }

  Future<ApplicationForm> readApplicationForm(int clubId) async {
    Map<String, dynamic> data =
        await applicationProvider.getApplicationForm(clubId);
    print("asdasd $data");
    if (data.isEmpty) {
      return ApplicationForm.empty();
    } else {
      return ApplicationForm.fromJson(data);
    }
  }

  Future<void> postApplicationForm(int clubId, dynamic data) async {
    await applicationProvider.postApplication(clubId, data);
  }
}
