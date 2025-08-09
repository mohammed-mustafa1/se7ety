import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/doctor/search/presentation/widgets/patient_card.dart';
import 'package:se7ety/features/patient/search/presentation/widgets/search_text_form_field.dart';

class PatientSearchScreen extends StatefulWidget {
  const PatientSearchScreen({super.key, this.keyword});
  final String? keyword;
  @override
  State<PatientSearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<PatientSearchScreen> {
  TextEditingController searchController = TextEditingController();
  late String keyword;
  Future<List<DocumentSnapshot<Object?>>>? future;
  @override
  void initState() {
    keyword = widget.keyword ?? '';
    future = getPatients(keyword: keyword);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ابحث عن مريض')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SearchTextFormField(
              hintText: 'ابحث عن مريض',
              controller: searchController,
              onFieldSubmitted:
                  (value) => setState(() {
                    keyword = value;
                    future = getPatients(keyword: keyword);
                  }),
              onPressed:
                  () => setState(() {
                    keyword = searchController.text;
                    future = getPatients(keyword: keyword);
                  }),
            ),
            Gap(16),
            Expanded(
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Center(child: Text(snapshot.error.toString())),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return emptyUi();
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Gap(16),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        var patient = PatientModel.fromJson(
                          snapshot.data?[index].data() as Map<String, dynamic>,
                        );
                        return PatientCard(patient: patient);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot<Object?>>> getPatients({
    String keyword = '',
  }) async {
    return FireBaseService.getPatientsForDoctor(keyword: keyword);
  }

  Column emptyUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: SvgPicture.asset(AppAssets.noSearch, width: 250),
        ),
      ],
    );
  }
}
