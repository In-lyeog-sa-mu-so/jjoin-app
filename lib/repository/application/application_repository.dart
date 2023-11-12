import 'package:jjoin/provider/Application/application_provider.dart';

import '../../model/Application/application_form.dart';

class ApplicationRepository {
  final ApplicationProvider applicationProvider;

  ApplicationRepository({required this.applicationProvider})
      : assert(applicationProvider != null);

  ApplicationForm getApplicationForm() {
    return applicationProvider.getDummyApplicationForm();
  }
}
