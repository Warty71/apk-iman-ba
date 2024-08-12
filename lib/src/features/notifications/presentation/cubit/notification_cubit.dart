import 'package:apk_iman_ba/src/features/notifications/data/repositories/notification_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<void> {
  final NotificationRepository _notificationRepository;

  NotificationCubit(this._notificationRepository) : super(null);

  Future<void> init() async {
    debugPrint('Initializing NotificationCubit');
    await _notificationRepository.initialize();
  }
}
