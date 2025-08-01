import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/search_text_form_field.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    this.keyword,
    this.searchType = SearchType.nameWithSearchBar,
  });
  final String? keyword;
  final SearchType? searchType;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  late String keyword;
  Future<QuerySnapshot<Object?>>? future;
  @override
  void initState() {
    keyword = widget.keyword ?? '';
    future = getDoctors(keyword: keyword, searchType: widget.searchType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.searchType == SearchType.specialization
              ? keyword
              : 'ابحث عن دكتور',
          style: TextStyles.getTitle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Visibility(
              visible: widget.searchType == SearchType.nameWithSearchBar,
              child: SearchTextFormField(
                controller: searchController,
                onFieldSubmitted:
                    (value) => setState(() {
                      keyword = value;
                      future = getDoctors(keyword: keyword);
                    }),
                onPressed:
                    () => setState(() {
                      keyword = searchController.text;
                      future = getDoctors(keyword: keyword);
                    }),
              ),
            ),
            Gap(16),
            Expanded(
              child: FutureBuilder(
                future: future,

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Center(child: Text(snapshot.error.toString())),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return emptyUi();
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Gap(16),
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        var doctor = DoctorModel.fromJson(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>,
                        );
                        return doctor.specialization == '' ||
                                doctor.specialization == null
                            ? Container()
                            : DoctorCard(doctor: doctor);
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

  Future<QuerySnapshot<Object?>> getDoctors({
    String keyword = '',
    SearchType? searchType,
  }) async {
    if (searchType == SearchType.specialization) {
      return FireBaseService.getDoctorsBySpecialization(keyword: keyword);
    } else {
      return FireBaseService.seachDoctorsByName(
        startAt: keyword,
        endAt: keyword,
      );
    }
  }

  Column emptyUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              searchController.clear();
              future = getDoctors(
                keyword: '',
                searchType: SearchType.nameWithSearchBar,
              );
              keyword = 'كل الدكاتره';
            });
          },
          child: Text(
            'عرض كل الدكاتره',
            style: TextStyles.getTitle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: SvgPicture.asset(AppAssets.noSearch, width: 250),
        ),
      ],
    );
  }
}

enum SearchType { name, nameWithSearchBar, specialization }
