import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/vehicles_cubit.dart';
import '../cubit/vehicles_state.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VehiclesCubit()..loadVehicles(),
      child: const _VehiclesView(),
    );
  }
}

class _VehiclesView extends StatelessWidget {
  const _VehiclesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: BlocBuilder<VehiclesCubit, VehiclesState>(
          builder: (context, state) {
            final cubit = context.read<VehiclesCubit>();

            return Column(
              children: [
                const _Header(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        ...state.vehicles.map(
                          (v) => _VehicleItem(
                            plate: v.plate,
                            isSelected: v.isSelected,
                            onTap: () => cubit.selectVehicle(v.id),
                          ),
                        ),

                        const SizedBox(height: 20),

                        InkWell(
                          onTap: () {
                            cubit.addVehicle('999 تونس 9999');
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.add),
                              SizedBox(width: 10),
                              Text('Ajouter un véhicule'),
                            ],
                          ),
                        ),

                        const Spacer(),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state.canConfirm ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB7F000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              'Confirmer',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          const Text(
            'Mes véhicules',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
class _VehicleItem extends StatelessWidget {
  final String plate;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehicleItem({
    required this.plate,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                plate,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFB7F000)),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Color(0xFFB7F000),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}