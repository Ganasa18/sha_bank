import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/blocs/data_plan/data_plan_bloc.dart';
import 'package:sha_bank/models/data_plan_form_model.dart';
import 'package:sha_bank/models/data_plan_model.dart';
import 'package:sha_bank/models/operator_card_model.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:sha_bank/ui/widgets/package_data_item.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/shared_method.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class DataPackage extends StatefulWidget {
  final OperatorCardModel operatorCard;
  const DataPackage({
    super.key,
    required this.operatorCard,
  });

  @override
  State<DataPackage> createState() => _DataPackageState();
}

class _DataPackageState extends State<DataPackage> {
  final phoneController = TextEditingController(text: '');
  // jika final tidak dapat menimpa valuenya
  DataPlanModel? selectedDataPlan;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPlanBloc(),
      child: BlocConsumer<DataPlanBloc, DataPlanState>(
        listener: (context, state) {
          if (state is DataPlanFailed) {
            showCustomSnackBar(context, state.e);
          }
          if (state is DataPlanSuccess) {
            context.read<AuthBloc>().add(
                  AuthUpdateBalance(
                    selectedDataPlan!.price! * -1,
                  ),
                );

            Navigator.pushNamedAndRemoveUntil(
              context,
              '/data-package-success',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is DataPlanLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Paket Data'),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 30),
                Text(
                  'Phone Number',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 14),
                CustomFormWidget(
                  controller: phoneController,
                  title: '+628',
                  isShowTitle: false,
                ),
                buildListPackage(),
                const SizedBox(height: 85),
                // CustomFilledButton(
                //   title: 'Continue',
                //   onPressed: () async {
                //     if (await Navigator.pushNamed(context, '/pin') == true) {
                //       Navigator.pushNamedAndRemoveUntil(
                //         context,
                //         '/data-package-success',
                //         (route) => false,
                //       );
                //     }
                //   },
                // ),
                // const SizedBox(height: 67),
              ],
            ),
            floatingActionButton:
                (selectedDataPlan != null && phoneController.text.isNotEmpty)
                    ? Container(
                        margin: const EdgeInsets.all(24),
                        child: CustomFilledButton(
                          title: 'Continue',
                          onPressed: () async {
                            if (await Navigator.pushNamed(context, '/pin') ==
                                true) {
                              // di gunakanan karna membutuhkan pin untuk kirim data
                              final authState = context.read<AuthBloc>().state;

                              String pin = '';
                              if (authState is AuthSuccess) {
                                pin = authState.user.pin!;
                              }
                              context.read<DataPlanBloc>().add(
                                    DataPlanPost(
                                      DataPlanFormModel(
                                        dataPlanId: selectedDataPlan?.id,
                                        phoneNumber: phoneController.text,
                                        pin: pin,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      )
                    : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  Widget buildListPackage() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Package',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            runSpacing: 17,
            spacing: 17,
            children: widget.operatorCard.dataPlans!.map((dataPlan) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDataPlan = dataPlan;
                  });
                },
                child: PackageDataItem(
                  dataPlan: dataPlan,
                  isSelected: dataPlan.id == selectedDataPlan?.id,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
